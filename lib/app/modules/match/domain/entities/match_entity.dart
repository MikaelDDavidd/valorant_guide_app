import 'package:equatable/equatable.dart';

class MatchEntity extends Equatable {
  final MetadataEntity metadata;
  final PlayersEntity players;

  const MatchEntity({
    required this.metadata,
    required this.players,
  });

  @override
  List<Object?> get props => [metadata, players];
}

class MetadataEntity extends Equatable {
  final String map;
  final String gameVersion;
  final int gameLength;
  final int gameStart;
  final String gameStartPatched;
  final int roundsPlayed;
  final String mode;
  final String matchid;
  final String region;
  final String cluster;

  const MetadataEntity({
    required this.map,
    required this.gameVersion,
    required this.gameLength,
    required this.gameStart,
    required this.gameStartPatched,
    required this.roundsPlayed,
    required this.mode,
    required this.matchid,
    required this.region,
    required this.cluster,
  });

  @override
  List<Object?> get props => [
        map,
        gameVersion,
        gameLength,
        gameStart,
        gameStartPatched,
        roundsPlayed,
        mode,
        matchid,
        region,
        cluster,
      ];
}

class PlayersEntity extends Equatable {
  final List<PlayerDetailEntity> allPlayers;

  const PlayersEntity({required this.allPlayers});

  @override
  List<Object?> get props => [allPlayers];
}

class PlayerDetailEntity extends Equatable {
  final String puuid;
  final String name;
  final String tag;
  final String team;
  final int level;
  final String character;
  final int currenttier;
  final String currenttierPatched;
  final String playerCard;
  final String playerTitle;
  final String partyId;
  final PlayerAssetsEntity assets;
  final PlayerStatsEntity stats;

  const PlayerDetailEntity({
    required this.puuid,
    required this.name,
    required this.tag,
    required this.team,
    required this.level,
    required this.character,
    required this.currenttier,
    required this.currenttierPatched,
    required this.playerCard,
    required this.playerTitle,
    required this.partyId,
    required this.assets,
    required this.stats,
  });

  @override
  List<Object?> get props => [
        puuid,
        name,
        tag,
        team,
        level,
        character,
        currenttier,
        currenttierPatched,
        playerCard,
        playerTitle,
        partyId,
        assets,
        stats,
      ];
}

class PlayerAssetsEntity extends Equatable {
  final AgentAssetsEntity agent;
  final CardAssetsEntity card;

  const PlayerAssetsEntity({required this.agent, required this.card});

  @override
  List<Object?> get props => [agent, card];
}

class AgentAssetsEntity extends Equatable {
  final String small;
  final String bust;
  final String full;
  final String killfeed;

  const AgentAssetsEntity({
    required this.small,
    required this.bust,
    required this.full,
    required this.killfeed,
  });

  @override
  List<Object?> get props => [small, bust, full, killfeed];
}

class CardAssetsEntity extends Equatable {
  final String small;
  final String large;
  final String wide;

  const CardAssetsEntity({
    required this.small,
    required this.large,
    required this.wide,
  });

  @override
  List<Object?> get props => [small, large, wide];
}

class PlayerStatsEntity extends Equatable {
  final int score;
  final int kills;
  final int deaths;
  final int assists;
  final int bodyshots;
  final int headshots;
  final int legshots;

  const PlayerStatsEntity({
    required this.score,
    required this.kills,
    required this.deaths,
    required this.assists,
    required this.bodyshots,
    required this.headshots,
    required this.legshots,
  });

  @override
  List<Object?> get props => [
        score,
        kills,
        deaths,
        assists,
        bodyshots,
        headshots,
        legshots,
      ];
}
