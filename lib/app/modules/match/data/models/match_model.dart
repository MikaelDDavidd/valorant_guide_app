import 'package:valorant_guide_app/app/modules/match/domain/entities/match_entity.dart';

class MatchModel extends MatchEntity {
  const MatchModel({
    required MetadataEntity metadata,
    required PlayersEntity players,
    required TeamsEntity teams,
    required List<RoundEntity> rounds,
    required List<KillEntity> kills,
  }) : super(
          metadata: metadata,
          players: players,
          teams: teams,
          rounds: rounds,
          kills: kills,
        );

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      metadata: MetadataModel.fromJson(json['metadata'] ?? {}),
      players: PlayersModel.fromJson(json['players'] ?? {}),
      teams: TeamsModel.fromJson(json['teams'] ?? {}),
      rounds: (json['rounds'] as List? ?? [])
          .map((i) => RoundModel.fromJson(i))
          .toList(),
      kills: (json['kills'] as List? ?? [])
          .map((i) => KillModel.fromJson(i))
          .toList(),
    );
  }
}

class MetadataModel extends MetadataEntity {
  const MetadataModel({
    required String map,
    required String gameVersion,
    required int gameLength,
    required int gameStart,
    required String gameStartPatched,
    required int roundsPlayed,
    required String mode,
    required String matchid,
    required String region,
    required String cluster,
    PremierInfoEntity? premierInfo,
  }) : super(
          map: map,
          gameVersion: gameVersion,
          gameLength: gameLength,
          gameStart: gameStart,
          gameStartPatched: gameStartPatched,
          roundsPlayed: roundsPlayed,
          mode: mode,
          matchid: matchid,
          region: region,
          cluster: cluster,
          premierInfo: premierInfo,
        );

  factory MetadataModel.fromJson(Map<String, dynamic> json) {
    return MetadataModel(
      map: json['map'] ?? '',
      gameVersion: json['game_version'] ?? '',
      gameLength: (json['game_length'] as num? ?? 0).toInt(),
      gameStart: (json['game_start'] as num? ?? 0).toInt(),
      gameStartPatched: json['game_start_patched'] ?? '',
      roundsPlayed: (json['rounds_played'] as num? ?? 0).toInt(),
      mode: json['mode'] ?? '',
      matchid: json['matchid'] ?? '',
      region: json['region'] ?? '',
      cluster: json['cluster'] ?? '',
      premierInfo: json['premier_info'] != null
          ? PremierInfoModel.fromJson(json['premier_info'])
          : null,
    );
  }
}

class PremierInfoModel extends PremierInfoEntity {
  const PremierInfoModel({String? tournamentId, String? matchupId})
      : super(tournamentId: tournamentId, matchupId: matchupId);

  factory PremierInfoModel.fromJson(Map<String, dynamic> json) {
    return PremierInfoModel(
      tournamentId: json['tournament_id'],
      matchupId: json['matchup_id'],
    );
  }
}

class PlayersModel extends PlayersEntity {
  const PlayersModel({
    required List<PlayerDetailEntity> allPlayers,
  }) : super(allPlayers: allPlayers);

  factory PlayersModel.fromJson(Map<String, dynamic> json) {
    return PlayersModel(
      allPlayers: (json['all_players'] as List? ?? [])
          .map((i) => PlayerDetailModel.fromJson(i))
          .toList(),
    );
  }
}

class PlayerDetailModel extends PlayerDetailEntity {
  const PlayerDetailModel({
    required String puuid,
    required String name,
    required String tag,
    required String team,
    required int level,
    required String character,
    required int currenttier,
    required String currenttierPatched,
    required String playerCard,
    required String playerTitle,
    required String partyId,
    required PlayerAssetsEntity assets,
    required BehaviourEntity behaviour,
    required PlatformEntity platform,
    required AbilityCastsEntity abilityCasts,
    required PlayerStatsEntity stats,
    required EconomyEntity economy,
    required int damageMade,
    required int damageReceived,
  }) : super(
          puuid: puuid,
          name: name,
          tag: tag,
          team: team,
          level: level,
          character: character,
          currenttier: currenttier,
          currenttierPatched: currenttierPatched,
          playerCard: playerCard,
          playerTitle: playerTitle,
          partyId: partyId,
          assets: assets,
          behaviour: behaviour,
          platform: platform,
          abilityCasts: abilityCasts,
          stats: stats,
          economy: economy,
          damageMade: damageMade,
          damageReceived: damageReceived,
        );

  factory PlayerDetailModel.fromJson(Map<String, dynamic> json) {
    return PlayerDetailModel(
      puuid: json['puuid'] ?? '',
      name: json['name'] ?? '',
      tag: json['tag'] ?? '',
      team: json['team'] ?? '',
      level: (json['level'] as num? ?? 0).toInt(),
      character: json['character'] ?? '',
      currenttier: (json['currenttier'] as num? ?? 0).toInt(),
      currenttierPatched: json['currenttier_patched'] ?? '',
      playerCard: json['player_card'] ?? '',
      playerTitle: json['player_title'] ?? '',
      partyId: json['party_id'] ?? '',
      assets: PlayerAssetsModel.fromJson(json['assets'] ?? {}),
      behaviour: BehaviourModel.fromJson(json['behaviour'] ?? {}),
      platform: PlatformModel.fromJson(json['platform'] ?? {}),
      abilityCasts: AbilityCastsModel.fromJson(json['ability_casts'] ?? {}),
      stats: PlayerStatsModel.fromJson(json['stats'] ?? {}),
      economy: EconomyModel.fromJson(json['economy'] ?? {}),
      damageMade: (json['damage_made'] as num? ?? 0).toInt(),
      damageReceived: (json['damage_received'] as num? ?? 0).toInt(),
    );
  }
}

class PlayerAssetsModel extends PlayerAssetsEntity {
  const PlayerAssetsModel({
    required AgentAssetsEntity agent,
    required CardAssetsEntity card,
  }) : super(
          agent: agent,
          card: card,
        );

  factory PlayerAssetsModel.fromJson(Map<String, dynamic> json) {
    return PlayerAssetsModel(
      agent: AgentAssetsModel.fromJson(json['agent'] ?? {}),
      card: CardAssetsModel.fromJson(json['card'] ?? {}),
    );
  }
}

class AgentAssetsModel extends AgentAssetsEntity {
  const AgentAssetsModel({
    required String small,
    required String bust,
    required String full,
    required String killfeed,
  }) : super(
          small: small,
          bust: bust,
          full: full,
          killfeed: killfeed,
        );

  factory AgentAssetsModel.fromJson(Map<String, dynamic> json) {
    return AgentAssetsModel(
      small: json['small'] ?? '',
      bust: json['bust'] ?? '',
      full: json['full'] ?? '',
      killfeed: json['killfeed'] ?? '',
    );
  }
}

class CardAssetsModel extends CardAssetsEntity {
  const CardAssetsModel({
    required String small,
    required String large,
    required String wide,
  }) : super(
          small: small,
          large: large,
          wide: wide,
        );

  factory CardAssetsModel.fromJson(Map<String, dynamic> json) {
    return CardAssetsModel(
      small: json['small'] ?? '',
      large: json['large'] ?? '',
      wide: json['wide'] ?? '',
    );
  }
}

class BehaviourModel extends BehaviourEntity {
  const BehaviourModel({
    required double afkRounds,
    required FriendlyFireEntity friendlyFire,
    required double roundsInSpawn,
  }) : super(
          afkRounds: afkRounds,
          friendlyFire: friendlyFire,
          roundsInSpawn: roundsInSpawn,
        );

  factory BehaviourModel.fromJson(Map<String, dynamic> json) {
    return BehaviourModel(
      afkRounds: (json['afk_rounds'] as num? ?? 0).toDouble(),
      friendlyFire: FriendlyFireModel.fromJson(json['friendly_fire'] ?? {}),
      roundsInSpawn: (json['rounds_in_spawn'] as num? ?? 0).toDouble(),
    );
  }
}

class FriendlyFireModel extends FriendlyFireEntity {
  const FriendlyFireModel({required int incoming, required int outgoing})
      : super(incoming: incoming, outgoing: outgoing);

  factory FriendlyFireModel.fromJson(Map<String, dynamic> json) {
    return FriendlyFireModel(
      incoming: (json['incoming'] as num? ?? 0).toInt(),
      outgoing: (json['outgoing'] as num? ?? 0).toInt(),
    );
  }
}

class PlatformModel extends PlatformEntity {
  const PlatformModel({required String type, required OsEntity os})
      : super(type: type, os: os);

  factory PlatformModel.fromJson(Map<String, dynamic> json) {
    return PlatformModel(
      type: json['type'] ?? '',
      os: OsModel.fromJson(json['os'] ?? {}),
    );
  }
}

class OsModel extends OsEntity {
  const OsModel({required String name, required String version})
      : super(name: name, version: version);

  factory OsModel.fromJson(Map<String, dynamic> json) {
    return OsModel(
      name: json['name'] ?? '',
      version: json['version'] ?? '',
    );
  }
}

class AbilityCastsModel extends AbilityCastsEntity {
  const AbilityCastsModel({
    required int cCast,
    required int qCast,
    required int eCast,
    required int xCast,
  }) : super(
          cCast: cCast,
          qCast: qCast,
          eCast: eCast,
          xCast: xCast,
        );

  factory AbilityCastsModel.fromJson(Map<String, dynamic> json) {
    return AbilityCastsModel(
      cCast: json['c_cast'] ?? 0,
      qCast: json['q_cast'] ?? 0,
      eCast: json['e_cast'] ?? 0,
      xCast: json['x_cast'] ?? 0,
    );
  }
}

class PlayerStatsModel extends PlayerStatsEntity {
  const PlayerStatsModel({
    required int score,
    required int kills,
    required int deaths,
    required int assists,
    required int bodyshots,
    required int headshots,
    required int legshots,
  }) : super(
          score: score,
          kills: kills,
          deaths: deaths,
          assists: assists,
          bodyshots: bodyshots,
          headshots: headshots,
          legshots: legshots,
        );

  factory PlayerStatsModel.fromJson(Map<String, dynamic> json) {
    return PlayerStatsModel(
      score: (json['score'] as num? ?? 0).toInt(),
      kills: (json['kills'] as num? ?? 0).toInt(),
      deaths: (json['deaths'] as num? ?? 0).toInt(),
      assists: (json['assists'] as num? ?? 0).toInt(),
      bodyshots: (json['bodyshots'] as num? ?? 0).toInt(),
      headshots: (json['headshots'] as num? ?? 0).toInt(),
      legshots: (json['legshots'] as num? ?? 0).toInt(),
    );
  }
}

class EconomyModel extends EconomyEntity {
  const EconomyModel(
      {required SpentEntity spent, required LoadoutValueEntity loadoutValue})
      : super(spent: spent, loadoutValue: loadoutValue);

  factory EconomyModel.fromJson(Map<String, dynamic> json) {
    return EconomyModel(
      spent: SpentModel.fromJson(json['spent'] ?? {}),
      loadoutValue: LoadoutValueModel.fromJson(json['loadout_value'] ?? {}),
    );
  }
}

class SpentModel extends SpentEntity {
  const SpentModel({required int overall, required int average})
      : super(overall: overall, average: average);

  factory SpentModel.fromJson(Map<String, dynamic> json) {
    return SpentModel(
      overall: (json['overall'] as num? ?? 0).toInt(),
      average: (json['average'] as num? ?? 0).toInt(),
    );
  }
}

class LoadoutValueModel extends LoadoutValueEntity {
  const LoadoutValueModel({required int overall, required int average})
      : super(overall: overall, average: average);

  factory LoadoutValueModel.fromJson(Map<String, dynamic> json) {
    return LoadoutValueModel(
      overall: (json['overall'] as num? ?? 0).toInt(),
      average: (json['average'] as num? ?? 0).toInt(),
    );
  }
}

class TeamsModel extends TeamsEntity {
  const TeamsModel({
    required TeamEntity red,
    required TeamEntity blue,
  }) : super(red: red, blue: blue);

  factory TeamsModel.fromJson(Map<String, dynamic> json) {
    return TeamsModel(
      red: TeamModel.fromJson(json['red'] ?? {}),
      blue: TeamModel.fromJson(json['blue'] ?? {}),
    );
  }
}

class TeamModel extends TeamEntity {
  const TeamModel({
    required bool hasWon,
    required int roundsWon,
    required int roundsLost,
  }) : super(
          hasWon: hasWon,
          roundsWon: roundsWon,
          roundsLost: roundsLost,
        );

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      hasWon: json['has_won'] ?? false,
      roundsWon: json['rounds_won'] ?? 0,
      roundsLost: json['rounds_lost'] ?? 0,
    );
  }
}

class RoundModel extends RoundEntity {
  const RoundModel({
    required String winningTeam,
    required String endType,
    required bool bombPlanted,
    required bool bombDefused,
    required List<PlayerRoundStatsEntity> playerStats,
  }) : super(
          winningTeam: winningTeam,
          endType: endType,
          bombPlanted: bombPlanted,
          bombDefused: bombDefused,
          playerStats: playerStats,
        );

  factory RoundModel.fromJson(Map<String, dynamic> json) {
    return RoundModel(
      winningTeam: json['winning_team'] ?? '',
      endType: json['end_type'] ?? '',
      bombPlanted: json['bomb_planted'] ?? false,
      bombDefused: json['bomb_defused'] ?? false,
      playerStats: (json['player_stats'] as List? ?? [])
          .map((i) => PlayerRoundStatsModel.fromJson(i))
          .toList(),
    );
  }
}

class PlayerRoundStatsModel extends PlayerRoundStatsEntity {
  const PlayerRoundStatsModel({
    required String playerPuuid,
    required int kills,
    required int score,
    required EconomyRoundEntity economy,
    required List<DamageEventEntity> damageEvents,
    required List<KillEventEntity> killEvents,
  }) : super(
          playerPuuid: playerPuuid,
          kills: kills,
          score: score,
          economy: economy,
          damageEvents: damageEvents,
          killEvents: killEvents,
        );

  factory PlayerRoundStatsModel.fromJson(Map<String, dynamic> json) {
    return PlayerRoundStatsModel(
      playerPuuid: json['player_puuid'] ?? '',
      kills: json['kills'] ?? 0,
      score: json['score'] ?? 0,
      economy: EconomyRoundModel.fromJson(json['economy'] ?? {}),
      damageEvents: (json['damage_events'] as List? ?? [])
          .map((i) => DamageEventModel.fromJson(i))
          .toList(),
      killEvents: (json['kill_events'] as List? ?? [])
          .map((i) => KillEventModel.fromJson(i))
          .toList(),
    );
  }
}

class EconomyRoundModel extends EconomyRoundEntity {
  const EconomyRoundModel({
    required int loadoutValue,
    required String weapon,
    required String armor,
  }) : super(
          loadoutValue: loadoutValue,
          weapon: weapon,
          armor: armor,
        );

  factory EconomyRoundModel.fromJson(Map<String, dynamic> json) {
    return EconomyRoundModel(
      loadoutValue: json['loadout_value'] ?? 0,
      weapon: json['weapon']?['name'] ?? 'Unknown',
      armor: json['armor']?['name'] ?? 'Unknown',
    );
  }
}

class DamageEventModel extends DamageEventEntity {
  const DamageEventModel({
    required String receiverPuuid,
    required int damage,
    required int bodyshots,
    required int headshots,
    required int legshots,
  }) : super(
          receiverPuuid: receiverPuuid,
          damage: damage,
          bodyshots: bodyshots,
          headshots: headshots,
          legshots: legshots,
        );

  factory DamageEventModel.fromJson(Map<String, dynamic> json) {
    return DamageEventModel(
      receiverPuuid: json['receiver_puuid'] ?? '',
      damage: (json['damage'] as num? ?? 0).toInt(),
      bodyshots: (json['bodyshots'] as num? ?? 0).toInt(),
      headshots: (json['headshots'] as num? ?? 0).toInt(),
      legshots: (json['legshots'] as num? ?? 0).toInt(),
    );
  }
}

class KillModel extends KillEntity {
  const KillModel({
    required int killTimeInRound,
    required int killTimeInMatch,
    required String killerPuuid,
    required String victimPuuid,
    required String damageWeaponId,
    required List<AssistantEntity> assistants,
  }) : super(
          killTimeInRound: killTimeInRound,
          killTimeInMatch: killTimeInMatch,
          killerPuuid: killerPuuid,
          victimPuuid: victimPuuid,
          damageWeaponId: damageWeaponId,
          assistants: assistants,
        );

  factory KillModel.fromJson(Map<String, dynamic> json) {
    return KillModel(
      killTimeInRound: (json['kill_time_in_round'] as num? ?? 0).toInt(),
      killTimeInMatch: (json['kill_time_in_match'] as num? ?? 0).toInt(),
      killerPuuid: json['killer_puuid'] ?? '',
      victimPuuid: json['victim_puuid'] ?? '',
      damageWeaponId: json['damage_weapon_id'] ?? '',
      assistants: (json['assistants'] as List? ?? [])
          .map((i) => AssistantModel.fromJson(i))
          .toList(),
    );
  }
}

class AssistantModel extends AssistantEntity {
  const AssistantModel({required String assistantPuuid})
      : super(assistantPuuid: assistantPuuid);

  factory AssistantModel.fromJson(Map<String, dynamic> json) {
    return AssistantModel(
      assistantPuuid: json['assistant_puuid'] ?? '',
    );
  }
}

class KillEventModel extends KillEventEntity {
  const KillEventModel({
    required int killTimeInRound,
    required String killerPuuid,
    required String victimPuuid,
    required List<AssistantEntity> assistants,
  }) : super(
          killTimeInRound: killTimeInRound,
          killerPuuid: killerPuuid,
          victimPuuid: victimPuuid,
          assistants: assistants,
        );

  factory KillEventModel.fromJson(Map<String, dynamic> json) {
    return KillEventModel(
      killTimeInRound: (json['kill_time_in_round'] as num? ?? 0).toInt(),
      killerPuuid: json['killer_puuid'] ?? '',
      victimPuuid: json['victim_puuid'] ?? '',
      assistants: (json['assistants'] as List? ?? [])
          .map((i) => AssistantModel.fromJson(i))
          .toList(),
    );
  }
}
