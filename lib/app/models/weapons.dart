import 'package:logger/logger.dart';

class WeaponData {
  late final String uuid;
  late final String displayName;
  late final String category;
  late final String displayIcon;
  late final WeaponStats? weaponStats;
 // late final List<ShopData> shopData;
 // late final List<Skins> skins;

  WeaponData({
    required this.uuid,
    required this.displayName,
    required this.category,
    required this.displayIcon,
    required this.weaponStats,
  //  required this.shopData,
  //  required this.skins,
  });

  factory WeaponData.fromMap(Map<String, dynamic> map) {
    return WeaponData(
      uuid: map['uuid'],
      displayName: map['displayName'],
      category: map['category'],
      displayIcon: map['displayIcon'],
      weaponStats: (map['weaponsStats'] != null ? WeaponStats.fromMap(map['weaponStats']) : null),
  //    shopData: map['shopData'],
  //    skins: map['skins'],
    );
  }
}

class WeaponStats {
  final int fireRate;
  final List<DamageRanges> damageRanges;

  WeaponStats({
    required this.fireRate,
    required this.damageRanges,
  });

  factory WeaponStats.fromMap(Map<String, dynamic> map) {
    return WeaponStats(
      fireRate: map['fireRate'],
      damageRanges: List.from(map['damageRanges']).map((e) => DamageRanges.fromMap(e)).toList(),
    );
  }
}

class DamageRanges {
  final int rangeStartMeters;
  final int rangeEndMeters;
  final int headDamage;
  final int bodyDamage;
  final int legDamage;

  DamageRanges({
    required this.rangeStartMeters,
    required this.rangeEndMeters,
    required this.headDamage,
    required this.bodyDamage,
    required this.legDamage,
  });

  factory DamageRanges.fromMap(Map<String, dynamic> map) {
    return DamageRanges(
      rangeStartMeters: map['rangeStartMeters'],
      rangeEndMeters: map['rangeEndMeters'],
      headDamage: map['headDamage'],
      bodyDamage: map['bodyDamage'],
      legDamage: map['legDamage'],
    );
  }
}

class ShopData {
  final int cost;
  final String category;

  ShopData({
    required this.cost,
    required this.category,
  });

  factory ShopData.fromMap(Map<String, dynamic> map) {
    return ShopData(
      cost: map['cost'],
      category: map['category'],
    );
  }
}

class Skins {
  final String uuid;
  final String displayName;
  final String displayIcon;
  final List<Levels> levels;

  Skins({
    required this.uuid,
    required this.displayName,
    required this.displayIcon,
    required this.levels,
  });

  factory Skins.fromMap(Map<String, dynamic> map) {
    return Skins(
      uuid: map['uuid'],
      displayName: map['displayName'],
      displayIcon: map['displayIcon'],
      levels: map['levels'],
    );
  }
}

class Levels {
  final String uuid;
  final String displayName;
  final String displayIcon;
  final String streamedVideo;

  Levels({
    required this.uuid,
    required this.displayName,
    required this.displayIcon,
    required this.streamedVideo,
  });

  factory Levels.fromMap(Map<String, dynamic> map) {
    return Levels(
      uuid: map['uuid'],
      displayName: map['displayName'],
      displayIcon: map['displayIcon'],
      streamedVideo: map['streamedVideo'],
    );
  }
}
