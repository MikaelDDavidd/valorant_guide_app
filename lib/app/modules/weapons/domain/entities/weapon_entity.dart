import 'package:equatable/equatable.dart';

class WeaponEntity extends Equatable {
  final String uuid;
  final String displayName;
  final String category;
  final String displayIcon;
  final WeaponStatsEntity? weaponStats;

  const WeaponEntity({
    required this.uuid,
    required this.displayName,
    required this.category,
    required this.displayIcon,
    this.weaponStats,
  });

  String get categoryName {
    final parts = category.split('::');
    return parts.last;
  }

  @override
  List<Object?> get props => [uuid, displayName, category, displayIcon, weaponStats];
}

class WeaponStatsEntity extends Equatable {
  final double fireRate;
  final List<DamageRangeEntity> damageRanges;

  const WeaponStatsEntity({
    required this.fireRate,
    required this.damageRanges,
  });

  @override
  List<Object?> get props => [fireRate, damageRanges];
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
