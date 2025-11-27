import 'package:valorant_guide_app/app/modules/weapons/domain/entities/weapon_entity.dart';

class WeaponModel {
  final String uuid;
  final String displayName;
  final String category;
  final String displayIcon;
  final WeaponStatsModel? weaponStats;

  WeaponModel({
    required this.uuid,
    required this.displayName,
    required this.category,
    required this.displayIcon,
    this.weaponStats,
  });

  factory WeaponModel.fromJson(Map<String, dynamic> json) {
    return WeaponModel(
      uuid: json['uuid'] ?? '',
      displayName: json['displayName'] ?? '',
      category: json['category'] ?? '',
      displayIcon: json['displayIcon'] ?? '',
      weaponStats: json['weaponStats'] != null
          ? WeaponStatsModel.fromJson(json['weaponStats'])
          : null,
    );
  }

  WeaponEntity toEntity() {
    return WeaponEntity(
      uuid: uuid,
      displayName: displayName,
      category: category,
      displayIcon: displayIcon,
      weaponStats: weaponStats?.toEntity(),
    );
  }
}

class WeaponStatsModel {
  final double fireRate;
  final List<DamageRangeModel> damageRanges;

  WeaponStatsModel({
    required this.fireRate,
    required this.damageRanges,
  });

  factory WeaponStatsModel.fromJson(Map<String, dynamic> json) {
    return WeaponStatsModel(
      fireRate: (json['fireRate'] ?? 0).toDouble(),
      damageRanges: (json['damageRanges'] as List?)
              ?.map((e) => DamageRangeModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  WeaponStatsEntity toEntity() {
    return WeaponStatsEntity(
      fireRate: fireRate,
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
