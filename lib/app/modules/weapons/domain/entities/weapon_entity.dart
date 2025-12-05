import 'package:equatable/equatable.dart';

class WeaponEntity extends Equatable {
  final String uuid;
  final String displayName;
  final String category;
  final String displayIcon;
  final String? killStreamIcon;
  final WeaponStatsEntity? weaponStats;
  final ShopDataEntity? shopData;
  final List<SkinEntity> skins;

  const WeaponEntity({
    required this.uuid,
    required this.displayName,
    required this.category,
    required this.displayIcon,
    this.killStreamIcon,
    this.weaponStats,
    this.shopData,
    this.skins = const [],
  });

  String get categoryName {
    final parts = category.split('::');
    return parts.last;
  }

  @override
  List<Object?> get props => [
        uuid,
        displayName,
        category,
        displayIcon,
        killStreamIcon,
        weaponStats,
        shopData,
        skins,
      ];
}

class ShopDataEntity extends Equatable {
  final int cost;
  final String category;
  final String categoryText;

  const ShopDataEntity({
    required this.cost,
    required this.category,
    required this.categoryText,
  });

  @override
  List<Object?> get props => [
        cost,
        category,
        categoryText
      ];
}

class WeaponStatsEntity extends Equatable {
  final double fireRate;
  final int magazineSize;
  final double reloadTimeSeconds;
  final double equipTimeSeconds;
  final String wallPenetration;
  final List<DamageRangeEntity> damageRanges;

  const WeaponStatsEntity({
    required this.fireRate,
    required this.magazineSize,
    required this.reloadTimeSeconds,
    required this.equipTimeSeconds,
    required this.wallPenetration,
    required this.damageRanges,
  });

  @override
  List<Object?> get props => [
        fireRate,
        magazineSize,
        reloadTimeSeconds,
        equipTimeSeconds,
        wallPenetration,
        damageRanges,
      ];
}

class DamageRangeEntity extends Equatable {
  final double rangeStartMeters;
  final double rangeEndMeters;
  final double headDamage;
  final double bodyDamage;
  final double legDamage;

  const DamageRangeEntity({
    required this.rangeStartMeters,
    required this.rangeEndMeters,
    required this.headDamage,
    required this.bodyDamage,
    required this.legDamage,
  });

  @override
  List<Object?> get props => [
        rangeStartMeters,
        rangeEndMeters,
        headDamage,
        bodyDamage,
        legDamage,
      ];
}

class SkinEntity extends Equatable {
  final String uuid;
  final String displayName;
  final String? displayIcon;
  final String? wallpaper;
  final List<ChromaEntity> chromas;
  final List<LevelEntity> levels;

  const SkinEntity({
    required this.uuid,
    required this.displayName,
    this.displayIcon,
    this.wallpaper,
    this.chromas = const [],
    this.levels = const [],
  });

  bool get hasVideo {
    return chromas.any((c) => c.streamedVideo != null) || levels.any((l) => l.streamedVideo != null);
  }

  String? get firstVideoUrl {
    for (final level in levels) {
      if (level.streamedVideo != null) return level.streamedVideo;
    }
    for (final chroma in chromas) {
      if (chroma.streamedVideo != null) return chroma.streamedVideo;
    }
    return null;
  }

  @override
  List<Object?> get props => [
        uuid,
        displayName,
        displayIcon,
        wallpaper,
        chromas,
        levels
      ];
}

class ChromaEntity extends Equatable {
  final String uuid;
  final String displayName;
  final String? displayIcon;
  final String? fullRender;
  final String? swatch;
  final String? streamedVideo;

  const ChromaEntity({
    required this.uuid,
    required this.displayName,
    this.displayIcon,
    this.fullRender,
    this.swatch,
    this.streamedVideo,
  });

  @override
  List<Object?> get props => [
        uuid,
        displayName,
        displayIcon,
        fullRender,
        swatch,
        streamedVideo
      ];
}

class LevelEntity extends Equatable {
  final String uuid;
  final String displayName;
  final String? levelItem;
  final String? displayIcon;
  final String? streamedVideo;

  const LevelEntity({
    required this.uuid,
    required this.displayName,
    this.levelItem,
    this.displayIcon,
    this.streamedVideo,
  });

  String get levelName {
    if (levelItem == null) return displayName;
    final parts = levelItem!.split('::');
    return parts.last;
  }

  @override
  List<Object?> get props => [
        uuid,
        displayName,
        levelItem,
        displayIcon,
        streamedVideo
      ];
}
