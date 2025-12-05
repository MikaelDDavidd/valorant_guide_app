import 'package:valorant_guide_app/app/modules/match/domain/entities/match_entity.dart';

class MatchModel extends MatchEntity {
  const MatchModel({
    required MetadataEntity metadata,
    required PlayersEntity players,
  }) : super(
          metadata: metadata,
          players: players,
        );

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      metadata: MetadataModel.fromJson(json['metadata']),
      players: PlayersModel.fromJson(json['players']),
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
        );

  factory MetadataModel.fromJson(Map<String, dynamic> json) {
    return MetadataModel(
      map: json['map'],
      gameVersion: json['game_version'],
      gameLength: json['game_length'],
      gameStart: json['game_start'],
      gameStartPatched: json['game_start_patched'],
      roundsPlayed: json['rounds_played'],
      mode: json['mode'],
      matchid: json['matchid'],
      region: json['region'],
      cluster: json['cluster'],
    );
  }
}

class PlayersModel extends PlayersEntity {
  const PlayersModel({
    required List<PlayerDetailEntity> allPlayers,
  }) : super(allPlayers: allPlayers);

  factory PlayersModel.fromJson(Map<String, dynamic> json) {
    return PlayersModel(
      allPlayers: (json['all_players'] as List)
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
    required PlayerStatsEntity stats,
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
          stats: stats,
        );

  factory PlayerDetailModel.fromJson(Map<String, dynamic> json) {
    return PlayerDetailModel(
      puuid: json['puuid'],
      name: json['name'],
      tag: json['tag'],
      team: json['team'],
      level: json['level'],
      character: json['character'],
      currenttier: json['currenttier'],
      currenttierPatched: json['currenttier_patched'],
      playerCard: json['player_card'],
      playerTitle: json['player_title'],
      partyId: json['party_id'],
      assets: PlayerAssetsModel.fromJson(json['assets']),
      stats: PlayerStatsModel.fromJson(json['stats']),
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
      agent: AgentAssetsModel.fromJson(json['agent']),
      card: CardAssetsModel.fromJson(json['card']),
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
      small: json['small'],
      bust: json['bust'],
      full: json['full'],
      killfeed: json['killfeed'],
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
      small: json['small'],
      large: json['large'],
      wide: json['wide'],
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
      score: json['score'],
      kills: json['kills'],
      deaths: json['deaths'],
      assists: json['assists'],
      bodyshots: json['bodyshots'],
      headshots: json['headshots'],
      legshots: json['legshots'],
    );
  }
}
