import 'package:equatable/equatable.dart';

class MatchEntity extends Equatable {
  final MetadataEntity metadata;
  final PlayersEntity players;
  final TeamsEntity teams;
  final List<RoundEntity> rounds;
  final List<KillEntity> kills;

  const MatchEntity({
    required this.metadata,
    required this.players,
    required this.teams,
    required this.rounds,
    required this.kills,
  });

  @override
  List<Object?> get props => [metadata, players, teams, rounds, kills];
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
  final PremierInfoEntity? premierInfo;

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
    this.premierInfo,
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
        premierInfo,
      ];
}

class PremierInfoEntity extends Equatable {
  final String? tournamentId;
  final String? matchupId;

  const PremierInfoEntity({this.tournamentId, this.matchupId});

  @override
  List<Object?> get props => [tournamentId, matchupId];
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
  final BehaviourEntity behaviour;
  final PlatformEntity platform;
  final AbilityCastsEntity abilityCasts;
  final PlayerStatsEntity stats;
  final EconomyEntity economy;
  final int damageMade;
  final int damageReceived;

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
    required this.behaviour,
    required this.platform,
    required this.abilityCasts,
    required this.stats,
    required this.economy,
    required this.damageMade,
    required this.damageReceived,
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
        behaviour,
        platform,
        abilityCasts,
        stats,
        economy,
        damageMade,
        damageReceived,
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

class BehaviourEntity extends Equatable {
  final double afkRounds;
  final FriendlyFireEntity friendlyFire;
  final double roundsInSpawn;

  const BehaviourEntity({
    required this.afkRounds,
    required this.friendlyFire,
    required this.roundsInSpawn,
  });

  @override
  List<Object?> get props => [afkRounds, friendlyFire, roundsInSpawn];
}

class FriendlyFireEntity extends Equatable {
  final int incoming;
  final int outgoing;

  const FriendlyFireEntity({required this.incoming, required this.outgoing});

  @override
  List<Object?> get props => [incoming, outgoing];
}

class PlatformEntity extends Equatable {
  final String type;
  final OsEntity os;

  const PlatformEntity({required this.type, required this.os});

  @override
  List<Object?> get props => [type, os];
}

class OsEntity extends Equatable {
  final String name;
  final String version;

  const OsEntity({required this.name, required this.version});

  @override
  List<Object?> get props => [name, version];
}

class AbilityCastsEntity extends Equatable {
  final int cCast;
  final int qCast;
  final int eCast;
  final int xCast;

  const AbilityCastsEntity({
    required this.cCast,
    required this.qCast,
    required this.eCast,
    required this.xCast,
  });

  @override
  List<Object?> get props => [cCast, qCast, eCast, xCast];
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

class EconomyEntity extends Equatable {
  final SpentEntity spent;
  final LoadoutValueEntity loadoutValue;

  const EconomyEntity({required this.spent, required this.loadoutValue});

  @override
  List<Object?> get props => [spent, loadoutValue];
}

class SpentEntity extends Equatable {
  final int overall;
  final int average;

  const SpentEntity({required this.overall, required this.average});

  @override
  List<Object?> get props => [overall, average];
}

class LoadoutValueEntity extends Equatable {
  final int overall;
  final int average;

  const LoadoutValueEntity({required this.overall, required this.average});

  @override
  List<Object?> get props => [overall, average];
}

class TeamsEntity extends Equatable {
  final TeamEntity red;
  final TeamEntity blue;

  const TeamsEntity({required this.red, required this.blue});

  @override
  List<Object?> get props => [red, blue];
}

class TeamEntity extends Equatable {
  final bool hasWon;
  final int roundsWon;
  final int roundsLost;

  const TeamEntity({
    required this.hasWon,
    required this.roundsWon,
    required this.roundsLost,
  });

  @override
  List<Object?> get props => [hasWon, roundsWon, roundsLost];
}

class RoundEntity extends Equatable {
  final String winningTeam;
  final String endType;
  final bool bombPlanted;
  final bool bombDefused;
  final List<PlayerRoundStatsEntity> playerStats;

  const RoundEntity({
    required this.winningTeam,
    required this.endType,
    required this.bombPlanted,
    required this.bombDefused,
    required this.playerStats,
  });

  @override
  List<Object?> get props =>
      [winningTeam, endType, bombPlanted, bombDefused, playerStats];
}

class PlayerRoundStatsEntity extends Equatable {
  final String playerPuuid;
  final int kills;
  final int score;
  final EconomyRoundEntity economy;
  final List<DamageEventEntity> damageEvents;
  final List<KillEventEntity> killEvents;

  const PlayerRoundStatsEntity({
    required this.playerPuuid,
    required this.kills,
    required this.score,
    required this.economy,
    required this.damageEvents,
    required this.killEvents,
  });

  @override
  List<Object?> get props => [playerPuuid, kills, score, economy, damageEvents, killEvents];
}

class EconomyRoundEntity extends Equatable {
  final int loadoutValue;
  final String weapon;
  final String armor;

  const EconomyRoundEntity({
    required this.loadoutValue,
    required this.weapon,
    required this.armor,
  });

  @override
  List<Object?> get props => [loadoutValue, weapon, armor];
}

class DamageEventEntity extends Equatable {
  final String receiverPuuid;
  final int damage;
  final int bodyshots;
  final int headshots;
  final int legshots;

  const DamageEventEntity({
    required this.receiverPuuid,
    required this.damage,
    required this.bodyshots,
    required this.headshots,
    required this.legshots,
  });

  @override
  List<Object?> get props => [receiverPuuid, damage, bodyshots, headshots, legshots];
}

class KillEntity extends Equatable {
  final int killTimeInRound;
  final int killTimeInMatch;
  final String killerPuuid;
  final String victimPuuid;
  final String damageWeaponId;
  final List<AssistantEntity> assistants;

  const KillEntity({
    required this.killTimeInRound,
    required this.killTimeInMatch,
    required this.killerPuuid,
    required this.victimPuuid,
    required this.damageWeaponId,
    required this.assistants,
  });

  @override
  List<Object?> get props =>
      [killTimeInRound, killTimeInMatch, killerPuuid, victimPuuid, damageWeaponId, assistants];
}

class AssistantEntity extends Equatable {
  final String assistantPuuid;

  const AssistantEntity({required this.assistantPuuid});

  @override
  List<Object?> get props => [assistantPuuid];
}

class KillEventEntity extends Equatable {
  final int killTimeInRound;
  final String killerPuuid;
  final String victimPuuid;
  final List<AssistantEntity> assistants;

  const KillEventEntity({
    required this.killTimeInRound,
    required this.killerPuuid,
    required this.victimPuuid,
    required this.assistants,
  });

  @override
  List<Object?> get props => [killTimeInRound, killerPuuid, victimPuuid, assistants];
}