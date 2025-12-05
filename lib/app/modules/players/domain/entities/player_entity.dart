import 'package:equatable/equatable.dart';

class PlayerAccountEntity extends Equatable {
  final String puuid;
  final String name;
  final String tag;
  final String region;
  final int accountLevel;
  final PlayerCardEntity? card;
  final DateTime? lastUpdate;

  const PlayerAccountEntity({
    required this.puuid,
    required this.name,
    required this.tag,
    required this.region,
    required this.accountLevel,
    this.card,
    this.lastUpdate,
  });

  String get fullName => '$name#$tag';

  @override
  List<Object?> get props => [
        puuid,
        name,
        tag,
        region,
        accountLevel,
        card,
        lastUpdate,
      ];
}

class PlayerCardEntity extends Equatable {
  final String? small;
  final String? large;
  final String? wide;

  const PlayerCardEntity({
    this.small,
    this.large,
    this.wide,
  });

  @override
  List<Object?> get props => [small, large, wide];
}

class PlayerMmrEntity extends Equatable {
  final String name;
  final String tag;
  final int currentTier;
  final String currentTierName;
  final int rankingInTier;
  final int mmrChangeToLastGame;
  final int elo;
  final RankImagesEntity? images;
  final HighestRankEntity? highestRank;

  const PlayerMmrEntity({
    required this.name,
    required this.tag,
    required this.currentTier,
    required this.currentTierName,
    required this.rankingInTier,
    required this.mmrChangeToLastGame,
    required this.elo,
    this.images,
    this.highestRank,
  });

  String get fullName => '$name#$tag';

  bool get isRanked => currentTier > 0;

  @override
  List<Object?> get props => [
        name,
        tag,
        currentTier,
        currentTierName,
        rankingInTier,
        mmrChangeToLastGame,
        elo,
        images,
        highestRank,
      ];
}

class RankImagesEntity extends Equatable {
  final String? small;
  final String? large;
  final String? triangleDown;
  final String? triangleUp;

  const RankImagesEntity({
    this.small,
    this.large,
    this.triangleDown,
    this.triangleUp,
  });

  @override
  List<Object?> get props => [small, large, triangleDown, triangleUp];
}

class HighestRankEntity extends Equatable {
  final String patchedTier;
  final int tier;
  final String? season;

  const HighestRankEntity({
    required this.patchedTier,
    required this.tier,
    this.season,
  });

  @override
  List<Object?> get props => [patchedTier, tier, season];
}

class PlayerMatchEntity extends Equatable {
  final String matchId;
  final MatchMetadataEntity metadata;
  final PlayerMatchStatsEntity playerStats;
  final MatchTeamsEntity teams;

  const PlayerMatchEntity({
    required this.matchId,
    required this.metadata,
    required this.playerStats,
    required this.teams,
  });

  bool get isWin {
    final playerTeam = playerStats.team.toLowerCase();
    if (playerTeam == 'red') {
      return teams.red.roundsWon > teams.blue.roundsWon;
    }
    return teams.blue.roundsWon > teams.red.roundsWon;
  }

  String get result {
    final playerTeam = playerStats.team.toLowerCase();
    final won = playerTeam == 'red'
        ? teams.red.roundsWon
        : teams.blue.roundsWon;
    final lost = playerTeam == 'red'
        ? teams.red.roundsLost
        : teams.blue.roundsLost;
    return '$won - $lost';
  }

  @override
  List<Object?> get props => [matchId, metadata, playerStats, teams];
}

class MatchMetadataEntity extends Equatable {
  final String map;
  final String mode;
  final String gameStartPatched;
  final int roundsPlayed;
  final String? cluster;

  const MatchMetadataEntity({
    required this.map,
    required this.mode,
    required this.gameStartPatched,
    required this.roundsPlayed,
    this.cluster,
  });

  @override
  List<Object?> get props => [map, mode, gameStartPatched, roundsPlayed, cluster];
}

class PlayerMatchStatsEntity extends Equatable {
  final String puuid;
  final String name;
  final String tag;
  final String team;
  final String character;
  final int score;
  final int kills;
  final int deaths;
  final int assists;
  final AgentAssetsEntity? agentAssets;

  const PlayerMatchStatsEntity({
    required this.puuid,
    required this.name,
    required this.tag,
    required this.team,
    required this.character,
    required this.score,
    required this.kills,
    required this.deaths,
    required this.assists,
    this.agentAssets,
  });

  String get kda => '$kills/$deaths/$assists';

  double get kdRatio {
    if (deaths == 0) return kills.toDouble();
    return kills / deaths;
  }

  @override
  List<Object?> get props => [
        puuid,
        name,
        tag,
        team,
        character,
        score,
        kills,
        deaths,
        assists,
        agentAssets,
      ];
}

class AgentAssetsEntity extends Equatable {
  final String? small;
  final String? full;
  final String? bust;
  final String? killfeed;

  const AgentAssetsEntity({
    this.small,
    this.full,
    this.bust,
    this.killfeed,
  });

  @override
  List<Object?> get props => [small, full, bust, killfeed];
}

class MatchTeamsEntity extends Equatable {
  final TeamResultEntity red;
  final TeamResultEntity blue;

  const MatchTeamsEntity({
    required this.red,
    required this.blue,
  });

  @override
  List<Object?> get props => [red, blue];
}

class TeamResultEntity extends Equatable {
  final int roundsWon;
  final int roundsLost;
  final bool hasWon;

  const TeamResultEntity({
    required this.roundsWon,
    required this.roundsLost,
    required this.hasWon,
  });

  @override
  List<Object?> get props => [roundsWon, roundsLost, hasWon];
}
