import 'package:dartz/dartz.dart';
import 'package:valorant_guide_app/app/core/errors/failures.dart';
import 'package:valorant_guide_app/app/modules/weapons/domain/entities/weapon_entity.dart';

abstract class IWeaponRepository {
  Future<Either<Failure, List<WeaponEntity>>> getWeapons();
  Future<Either<Failure, WeaponEntity>> getWeaponById(String uuid);
}
