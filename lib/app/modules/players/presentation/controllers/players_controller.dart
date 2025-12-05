import 'dart:developer' as dev;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:valorant_guide_app/app/core/errors/failures.dart';
import 'package:valorant_guide_app/app/modules/players/domain/entities/player_entity.dart';
import 'package:valorant_guide_app/app/modules/players/domain/usecases/search_player_usecase.dart';
import 'package:valorant_guide_app/app/modules/players/domain/usecases/get_player_mmr_usecase.dart';
import 'package:valorant_guide_app/app/modules/players/domain/usecases/get_player_matches_usecase.dart';

class PlayersController extends GetxController {
  final SearchPlayerUseCase searchPlayerUseCase;
  final GetPlayerMmrUseCase getPlayerMmrUseCase;
  final GetPlayerMatchesUseCase getPlayerMatchesUseCase;

  PlayersController({
    required this.searchPlayerUseCase,
    required this.getPlayerMmrUseCase,
    required this.getPlayerMatchesUseCase,
  });

  final _storage = GetStorage();
  static const _recentSearchesKey = 'recent_player_searches';
  static const _maxRecentSearches = 10;

  final playerAccount = Rxn<PlayerAccountEntity>();
  final playerMmr = Rxn<PlayerMmrEntity>();
  final playerMatches = <PlayerMatchEntity>[].obs;
  final recentSearches = <String>[].obs;

  final isSearching = false.obs;
  final isLoadingMmr = false.obs;
  final isLoadingMatches = false.obs;

  final error = Rxn<String>();
  final mmrError = Rxn<String>();
  final matchesError = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    _loadRecentSearches();
    _checkInitialSearch();
  }

  void _checkInitialSearch() {
    final args = Get.arguments;
    if (args != null && args is Map) {
      final name = args['name'] as String?;
      final tag = args['tag'] as String?;
      if (name != null && tag != null && name.isNotEmpty && tag.isNotEmpty) {
        Future.delayed(const Duration(milliseconds: 100), () {
          searchPlayer('$name#$tag');
        });
      }
    }
  }

  void _loadRecentSearches() {
    final saved = _storage.read<List>(_recentSearchesKey);
    if (saved != null) {
      recentSearches.value = saved.cast<String>();
    }
  }

  void _saveRecentSearch(String query) {
    recentSearches.remove(query);
    recentSearches.insert(0, query);
    if (recentSearches.length > _maxRecentSearches) {
      recentSearches.removeLast();
    }
    _storage.write(_recentSearchesKey, recentSearches.toList());
  }

  void clearRecentSearches() {
    recentSearches.clear();
    _storage.remove(_recentSearchesKey);
  }

  void removeRecentSearch(String query) {
    recentSearches.remove(query);
    _storage.write(_recentSearchesKey, recentSearches.toList());
  }

  bool isValidSearchQuery(String query) {
    return query.contains('#') && query.split('#').length == 2;
  }

  Future<void> searchPlayer(String query) async {
    dev.log('🔎 [PlayersController] searchPlayer: $query');

    if (!isValidSearchQuery(query)) {
      dev.log('❌ [PlayersController] Invalid query format');
      error.value = 'Formato inválido. Use Nome#Tag';
      return;
    }

    _clearPlayerData();
    isSearching.value = true;
    error.value = null;

    try {
      final params = SearchPlayerParams.fromFullName(query);
      dev.log('🔎 [PlayersController] Searching: name=${params.name}, tag=${params.tag}');

      final result = await searchPlayerUseCase(params);

      result.fold(
        (failure) {
          dev.log('❌ [PlayersController] Search failed: ${failure.message}');
          _handleFailure(failure, error);
        },
        (account) {
          dev.log('✅ [PlayersController] Found: ${account.name}#${account.tag} (${account.region})');
          playerAccount.value = account;
          _saveRecentSearch(query);
          _fetchPlayerDetails(account);
        },
      );
    } catch (e, stack) {
      dev.log('❌ [PlayersController] Exception: $e');
      dev.log('❌ [PlayersController] Stack: $stack');
      error.value = 'Erro ao processar busca';
    } finally {
      isSearching.value = false;
    }
  }

  void _fetchPlayerDetails(PlayerAccountEntity account) {
    fetchPlayerMmr(account.region, account.name, account.tag);
    fetchPlayerMatches(account.region, account.name, account.tag);
  }

  Future<void> fetchPlayerMmr(String region, String name, String tag) async {
    isLoadingMmr.value = true;
    mmrError.value = null;

    final params = GetPlayerMmrParams(region: region, name: name, tag: tag);
    final result = await getPlayerMmrUseCase(params);

    result.fold(
      (failure) => _handleFailure(failure, mmrError),
      (mmr) => playerMmr.value = mmr,
    );

    isLoadingMmr.value = false;
  }

  Future<void> fetchPlayerMatches(
    String region,
    String name,
    String tag, {
    int size = 5,
  }) async {
    isLoadingMatches.value = true;
    matchesError.value = null;

    final params = GetPlayerMatchesParams(
      region: region,
      name: name,
      tag: tag,
      size: size,
    );
    final result = await getPlayerMatchesUseCase(params);

    result.fold(
      (failure) => _handleFailure(failure, matchesError),
      (matches) => playerMatches.value = matches,
    );

    isLoadingMatches.value = false;
  }

  Future<void> refreshPlayerData() async {
    final account = playerAccount.value;
    if (account == null) return;

    _fetchPlayerDetails(account);
  }

  void _clearPlayerData() {
    playerAccount.value = null;
    playerMmr.value = null;
    playerMatches.clear();
    mmrError.value = null;
    matchesError.value = null;
  }

  void _handleFailure(Failure failure, Rxn<String> errorState) {
    if (failure is RateLimitFailure) {
      final retryAfter = failure.retryAfter ?? 60;
      errorState.value = 'Limite atingido. Tente em ${retryAfter}s';
    } else {
      errorState.value = failure.message;
    }
  }

  bool get hasPlayerData => playerAccount.value != null;

  bool get isLoading =>
      isSearching.value || isLoadingMmr.value || isLoadingMatches.value;
}
