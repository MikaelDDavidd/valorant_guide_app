import 'package:valorant_guide_app/app/modules/weapons/domain/entities/weapon_entity.dart';

class WeaponModel {
  final String uuid;
  final String displayName;
  final String category;
  final String displayIcon;
  final String? killStreamIcon;
  final WeaponStatsModel? weaponStats;
  final ShopDataModel? shopData;
  final List<SkinModel> skins;

  WeaponModel({
    required this.uuid,
    required this.displayName,
    required this.category,
    required this.displayIcon,
    this.killStreamIcon,
    this.weaponStats,
    this.shopData,
    this.skins = const [],
  });

  factory WeaponModel.fromJson(Map<String, dynamic> json) {
    return WeaponModel(
      uuid: json['uuid'] ?? '',
      displayName: json['displayName'] ?? '',
      category: json['category'] ?? '',
      displayIcon: json['displayIcon'] ?? '',
      killStreamIcon: json['killStreamIcon'],
      weaponStats: json['weaponStats'] != null
          ? WeaponStatsModel.fromJson(json['weaponStats'])
          : null,
      shopData: json['shopData'] != null
          ? ShopDataModel.fromJson(json['shopData'])
          : null,
      skins: (json['skins'] as List?)
              ?.map((e) => SkinModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  WeaponEntity toEntity() {
    return WeaponEntity(
      uuid: uuid,
      displayName: displayName,
      category: category,
      displayIcon: displayIcon,
      killStreamIcon: killStreamIcon,
      weaponStats: weaponStats?.toEntity(),
      shopData: shopData?.toEntity(),
      skins: skins.map((e) => e.toEntity()).toList(),
    );
  }
}

class ShopDataModel {
  final int cost;
  final String category;
  final String categoryText;

  ShopDataModel({
    required this.cost,
    required this.category,
    required this.categoryText,
  });

  factory ShopDataModel.fromJson(Map<String, dynamic> json) {
    return ShopDataModel(
      cost: json['cost'] ?? 0,
      category: json['category'] ?? '',
      categoryText: json['categoryText'] ?? '',
    );
  }

  ShopDataEntity toEntity() {
    return ShopDataEntity(
      cost: cost,
      category: category,
      categoryText: categoryText,
    );
  }
}

class WeaponStatsModel {
  final double fireRate;
  final int magazineSize;
  final double reloadTimeSeconds;
  final double equipTimeSeconds;
  final String wallPenetration;
  final List<DamageRangeModel> damageRanges;

  WeaponStatsModel({
    required this.fireRate,
    required this.magazineSize,
    required this.reloadTimeSeconds,
    required this.equipTimeSeconds,
    required this.wallPenetration,
    required this.damageRanges,
  });

  factory WeaponStatsModel.fromJson(Map<String, dynamic> json) {
    String wallPen = json['wallPenetration'] ?? '';
    if (wallPen.contains('::')) {
      wallPen = wallPen.split('::').last;
    }
    return WeaponStatsModel(
      fireRate: (json['fireRate'] ?? 0).toDouble(),
      magazineSize: json['magazineSize'] ?? 0,
      reloadTimeSeconds: (json['reloadTimeSeconds'] ?? 0).toDouble(),
      equipTimeSeconds: (json['equipTimeSeconds'] ?? 0).toDouble(),
      wallPenetration: wallPen,
      damageRanges: (json['damageRanges'] as List?)
              ?.map((e) => DamageRangeModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  WeaponStatsEntity toEntity() {
    return WeaponStatsEntity(
      fireRate: fireRate,
      magazineSize: magazineSize,
      reloadTimeSeconds: reloadTimeSeconds,
      equipTimeSeconds: equipTimeSeconds,
      wallPenetration: wallPenetration,
      damageRanges: damageRanges.map((e) => e.toEntity()).toList(),
    );
  }
}

class DamageRangeModel {
  final double rangeStartMeters;
  final double rangeEndMeters;
  final double headDamage;
  final double bodyDamage;
  final double legDamage;

  DamageRangeModel({
    required this.rangeStartMeters,
    required this.rangeEndMeters,
    required this.headDamage,
    required this.bodyDamage,
    required this.legDamage,
  });

  factory DamageRangeModel.fromJson(Map<String, dynamic> json) {
    return DamageRangeModel(
      rangeStartMeters: (json['rangeStartMeters'] ?? 0).toDouble(),
      rangeEndMeters: (json['rangeEndMeters'] ?? 0).toDouble(),
      headDamage: (json['headDamage'] ?? 0).toDouble(),
      bodyDamage: (json['bodyDamage'] ?? 0).toDouble(),
      legDamage: (json['legDamage'] ?? 0).toDouble(),
    );
  }

  DamageRangeEntity toEntity() {
    return DamageRangeEntity(
      rangeStartMeters: rangeStartMeters,
      rangeEndMeters: rangeEndMeters,
      headDamage: headDamage,
      bodyDamage: bodyDamage,
      legDamage: legDamage,
    );
  }
}

class SkinModel {
  final String uuid;
  final String displayName;
  final String? displayIcon;
  final String? wallpaper;
  final List<ChromaModel> chromas;
  final List<LevelModel> levels;

  SkinModel({
    required this.uuid,
    required this.displayName,
    this.displayIcon,
    this.wallpaper,
    this.chromas = const [],
    this.levels = const [],
  });

  factory SkinModel.fromJson(Map<String, dynamic> json) {
    return SkinModel(
      uuid: json['uuid'] ?? '',
      displayName: json['displayName'] ?? '',
      displayIcon: json['displayIcon'],
      wallpaper: json['wallpaper'],
      chromas: (json['chromas'] as List?)
              ?.map((e) => ChromaModel.fromJson(e))
              .toList() ??
          [],
      levels: (json['levels'] as List?)
              ?.map((e) => LevelModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  SkinEntity toEntity() {
    return SkinEntity(
      uuid: uuid,
      displayName: displayName,
      displayIcon: displayIcon,
      wallpaper: wallpaper,
      chromas: chromas.map((e) => e.toEntity()).toList(),
      levels: levels.map((e) => e.toEntity()).toList(),
    );
  }
}

class ChromaModel {
  final String uuid;
  final String displayName;
  final String? displayIcon;
  final String? fullRender;
  final String? swatch;
  final String? streamedVideo;

  ChromaModel({
    required this.uuid,
    required this.displayName,
    this.displayIcon,
    this.fullRender,
    this.swatch,
    this.streamedVideo,
  });

  factory ChromaModel.fromJson(Map<String, dynamic> json) {
    return ChromaModel(
      uuid: json['uuid'] ?? '',
      displayName: json['displayName'] ?? '',
      displayIcon: json['displayIcon'],
      fullRender: json['fullRender'],
      swatch: json['swatch'],
      streamedVideo: json['streamedVideo'],
    );
  }

  ChromaEntity toEntity() {
    return ChromaEntity(
      uuid: uuid,
      displayName: displayName,
      displayIcon: displayIcon,
      fullRender: fullRender,
      swatch: swatch,
      streamedVideo: streamedVideo,
    );
  }
}

class LevelModel {
  final String uuid;
  final String displayName;
  final String? levelItem;
  final String? displayIcon;
  final String? streamedVideo;

  LevelModel({
    required this.uuid,
    required this.displayName,
    this.levelItem,
    this.displayIcon,
    this.streamedVideo,
  });

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      uuid: json['uuid'] ?? '',
      displayName: json['displayName'] ?? '',
      levelItem: json['levelItem'],
      displayIcon: json['displayIcon'],
      streamedVideo: json['streamedVideo'],
    );
  }

  LevelEntity toEntity() {
    return LevelEntity(
      uuid: uuid,
      displayName: displayName,
      levelItem: levelItem,
      displayIcon: displayIcon,
      streamedVideo: streamedVideo,
    );
  }
}
