import 'package:valorant_guide_app/app/modules/players/domain/entities/player_entity.dart';

class PlayerAccountModel {
  final String puuid;
  final String name;
  final String tag;
  final String region;
  final int accountLevel;
  final PlayerCardModel? card;
  final int? lastUpdateRaw;

  PlayerAccountModel({
    required this.puuid,
    required this.name,
    required this.tag,
    required this.region,
    required this.accountLevel,
    this.card,
    this.lastUpdateRaw,
  });

  factory PlayerAccountModel.fromJson(Map<String, dynamic> json) {
    return PlayerAccountModel(
      puuid: json['puuid'] ?? '',
      name: json['name'] ?? '',
      tag: json['tag'] ?? '',
      region: json['region'] ?? '',
      accountLevel: json['account_level'] ?? 0,
      card: json['card'] != null ? PlayerCardModel.fromJson(json['card']) : null,
      lastUpdateRaw: json['last_update_raw'],
    );
  }

  PlayerAccountEntity toEntity() {
    return PlayerAccountEntity(
      puuid: puuid,
      name: name,
      tag: tag,
      region: region,
      accountLevel: accountLevel,
      card: card?.toEntity(),
      lastUpdate: lastUpdateRaw != null
          ? DateTime.fromMillisecondsSinceEpoch(lastUpdateRaw! * 1000)
          : null,
    );
  }
}

class PlayerCardModel {
  final String? small;
  final String? large;
  final String? wide;

  PlayerCardModel({
    this.small,
    this.large,
    this.wide,
  });

  factory PlayerCardModel.fromJson(Map<String, dynamic> json) {
    return PlayerCardModel(
      small: json['small'],
      large: json['large'],
      wide: json['wide'],
    );
  }

  PlayerCardEntity toEntity() {
    return PlayerCardEntity(
      small: small,
      large: large,
      wide: wide,
    );
  }
}

class PlayerMmrModel {
  final String name;
  final String tag;
  final CurrentMmrDataModel? currentData;
  final HighestRankModel? highestRank;

  PlayerMmrModel({
    required this.name,
    required this.tag,
    this.currentData,
    this.highestRank,
  });

  factory PlayerMmrModel.fromJson(Map<String, dynamic> json) {
    return PlayerMmrModel(
      name: json['name'] ?? '',
      tag: json['tag'] ?? '',
      currentData: json['current_data'] != null
          ? CurrentMmrDataModel.fromJson(json['current_data'])
          : null,
      highestRank: json['highest_rank'] != null
          ? HighestRankModel.fromJson(json['highest_rank'])
          : null,
    );
  }

  PlayerMmrEntity toEntity() {
    return PlayerMmrEntity(
      name: name,
      tag: tag,
      currentTier: currentData?.currentTier ?? 0,
      currentTierName: currentData?.currentTierPatched ?? 'Unranked',
      rankingInTier: currentData?.rankingInTier ?? 0,
      mmrChangeToLastGame: currentData?.mmrChangeToLastGame ?? 0,
      elo: currentData?.elo ?? 0,
      images: currentData?.images?.toEntity(),
      highestRank: highestRank?.toEntity(),
    );
  }
}

class CurrentMmrDataModel {
  final int currentTier;
  final String currentTierPatched;
  final int rankingInTier;
  final int mmrChangeToLastGame;
  final int elo;
  final RankImagesModel? images;

  CurrentMmrDataModel({
    required this.currentTier,
    required this.currentTierPatched,
    required this.rankingInTier,
    required this.mmrChangeToLastGame,
    required this.elo,
    this.images,
  });

  factory CurrentMmrDataModel.fromJson(Map<String, dynamic> json) {
    return CurrentMmrDataModel(
      currentTier: json['currenttier'] ?? 0,
      currentTierPatched: json['currenttierpatched'] ?? 'Unranked',
      rankingInTier: json['ranking_in_tier'] ?? 0,
      mmrChangeToLastGame: json['mmr_change_to_last_game'] ?? 0,
      elo: json['elo'] ?? 0,
      images:
          json['images'] != null ? RankImagesModel.fromJson(json['images']) : null,
    );
  }
}

class RankImagesModel {
  final String? small;
  final String? large;
  final String? triangleDown;
  final String? triangleUp;

  RankImagesModel({
    this.small,
    this.large,
    this.triangleDown,
    this.triangleUp,
  });

  factory RankImagesModel.fromJson(Map<String, dynamic> json) {
    return RankImagesModel(
      small: json['small'],
      large: json['large'],
      triangleDown: json['triangle_down'],
      triangleUp: json['triangle_up'],
    );
  }

  RankImagesEntity toEntity() {
    return RankImagesEntity(
      small: small,
      large: large,
      triangleDown: triangleDown,
      triangleUp: triangleUp,
    );
  }
}

class HighestRankModel {
  final String patchedTier;
  final int tier;
  final String? season;

  HighestRankModel({
    required this.patchedTier,
    required this.tier,
    this.season,
  });

  factory HighestRankModel.fromJson(Map<String, dynamic> json) {
    return HighestRankModel(
      patchedTier: json['patched_tier'] ?? '',
      tier: json['tier'] ?? 0,
      season: json['season'],
    );
  }

  HighestRankEntity toEntity() {
    return HighestRankEntity(
      patchedTier: patchedTier,
      tier: tier,
      season: season,
    );
  }
}

class PlayerMatchModel {
  final MatchMetadataModel metadata;
  final MatchPlayersModel players;
  final MatchTeamsModel teams;

  PlayerMatchModel({
    required this.metadata,
    required this.players,
    required this.teams,
  });

  factory PlayerMatchModel.fromJson(Map<String, dynamic> json) {
    return PlayerMatchModel(
      metadata: MatchMetadataModel.fromJson(json['metadata'] ?? {}),
      players: MatchPlayersModel.fromJson(json['players'] ?? {}),
      teams: MatchTeamsModel.fromJson(json['teams'] ?? {}),
    );
  }

  PlayerMatchEntity toEntity(String puuid) {
    final playerData = players.allPlayers.firstWhere(
      (p) => p.puuid == puuid,
      orElse: () => players.allPlayers.first,
    );

    return PlayerMatchEntity(
      matchId: metadata.matchId,
      metadata: metadata.toEntity(),
      playerStats: playerData.toEntity(),
      teams: teams.toEntity(),
    );
  }
}

class MatchMetadataModel {
  final String matchId;
  final String map;
  final String mode;
  final String gameStartPatched;
  final int roundsPlayed;
  final String? cluster;

  MatchMetadataModel({
    required this.matchId,
    required this.map,
    required this.mode,
    required this.gameStartPatched,
    required this.roundsPlayed,
    this.cluster,
  });

  factory MatchMetadataModel.fromJson(Map<String, dynamic> json) {
    return MatchMetadataModel(
      matchId: json['matchid'] ?? '',
      map: json['map'] ?? '',
      mode: json['mode'] ?? '',
      gameStartPatched: json['game_start_patched'] ?? '',
      roundsPlayed: json['rounds_played'] ?? 0,
      cluster: json['cluster'],
    );
  }

  MatchMetadataEntity toEntity() {
    return MatchMetadataEntity(
      map: map,
      mode: mode,
      gameStartPatched: gameStartPatched,
      roundsPlayed: roundsPlayed,
      cluster: cluster,
    );
  }
}

class MatchPlayersModel {
  final List<MatchPlayerDataModel> allPlayers;

  MatchPlayersModel({required this.allPlayers});

  factory MatchPlayersModel.fromJson(Map<String, dynamic> json) {
    return MatchPlayersModel(
      allPlayers: (json['all_players'] as List?)
              ?.map((e) => MatchPlayerDataModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class MatchPlayerDataModel {
  final String puuid;
  final String name;
  final String tag;
  final String team;
  final String character;
  final MatchPlayerStatsModel stats;
  final AgentAssetsModel? assets;

  MatchPlayerDataModel({
    required this.puuid,
    required this.name,
    required this.tag,
    required this.team,
    required this.character,
    required this.stats,
    this.assets,
  });

  factory MatchPlayerDataModel.fromJson(Map<String, dynamic> json) {
    return MatchPlayerDataModel(
      puuid: json['puuid'] ?? '',
      name: json['name'] ?? '',
      tag: json['tag'] ?? '',
      team: json['team'] ?? '',
      character: json['character'] ?? '',
      stats: MatchPlayerStatsModel.fromJson(json['stats'] ?? {}),
      assets: json['assets'] != null
          ? AgentAssetsModel.fromJson(json['assets'])
          : null,
    );
  }

  PlayerMatchStatsEntity toEntity() {
    return PlayerMatchStatsEntity(
      puuid: puuid,
      name: name,
      tag: tag,
      team: team,
      character: character,
      score: stats.score,
      kills: stats.kills,
      deaths: stats.deaths,
      assists: stats.assists,
      agentAssets: assets?.agent?.toEntity(),
    );
  }
}

class MatchPlayerStatsModel {
  final int score;
  final int kills;
  final int deaths;
  final int assists;

  MatchPlayerStatsModel({
    required this.score,
    required this.kills,
    required this.deaths,
    required this.assists,
  });

  factory MatchPlayerStatsModel.fromJson(Map<String, dynamic> json) {
    return MatchPlayerStatsModel(
      score: json['score'] ?? 0,
      kills: json['kills'] ?? 0,
      deaths: json['deaths'] ?? 0,
      assists: json['assists'] ?? 0,
    );
  }
}

class AgentAssetsModel {
  final AgentImagesModel? agent;

  AgentAssetsModel({this.agent});

  factory AgentAssetsModel.fromJson(Map<String, dynamic> json) {
    return AgentAssetsModel(
      agent: json['agent'] != null
          ? AgentImagesModel.fromJson(json['agent'])
          : null,
    );
  }
}

class AgentImagesModel {
  final String? small;
  final String? full;
  final String? bust;
  final String? killfeed;

  AgentImagesModel({
    this.small,
    this.full,
    this.bust,
    this.killfeed,
  });

  factory AgentImagesModel.fromJson(Map<String, dynamic> json) {
    return AgentImagesModel(
      small: json['small'],
      full: json['full'],
      bust: json['bust'],
      killfeed: json['killfeed'],
    );
  }

  AgentAssetsEntity toEntity() {
    return AgentAssetsEntity(
      small: small,
      full: full,
      bust: bust,
      killfeed: killfeed,
    );
  }
}

class MatchTeamsModel {
  final TeamDataModel? red;
  final TeamDataModel? blue;

  MatchTeamsModel({this.red, this.blue});

  factory MatchTeamsModel.fromJson(Map<String, dynamic> json) {
    return MatchTeamsModel(
      red: json['red'] != null ? TeamDataModel.fromJson(json['red']) : null,
      blue: json['blue'] != null ? TeamDataModel.fromJson(json['blue']) : null,
    );
  }

  MatchTeamsEntity toEntity() {
    return MatchTeamsEntity(
      red: red?.toEntity() ??
          const TeamResultEntity(roundsWon: 0, roundsLost: 0, hasWon: false),
      blue: blue?.toEntity() ??
          const TeamResultEntity(roundsWon: 0, roundsLost: 0, hasWon: false),
    );
  }
}

class TeamDataModel {
  final bool hasWon;
  final int roundsWon;
  final int roundsLost;

  TeamDataModel({
    required this.hasWon,
    required this.roundsWon,
    required this.roundsLost,
  });

  factory TeamDataModel.fromJson(Map<String, dynamic> json) {
    return TeamDataModel(
      hasWon: json['has_won'] ?? false,
      roundsWon: json['rounds_won'] ?? 0,
      roundsLost: json['rounds_lost'] ?? 0,
    );
  }

  TeamResultEntity toEntity() {
    return TeamResultEntity(
      hasWon: hasWon,
      roundsWon: roundsWon,
      roundsLost: roundsLost,
    );
  }
}
