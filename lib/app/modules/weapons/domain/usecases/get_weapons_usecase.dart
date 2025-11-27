import 'package:dartz/dartz.dart';
import 'package:valorant_guide_app/app/core/errors/failures.dart';
import 'package:valorant_guide_app/app/core/usecases/usecase.dart';
import 'package:valorant_guide_app/app/modules/weapons/domain/entities/weapon_entity.dart';
import 'package:valorant_guide_app/app/modules/weapons/domain/repositories/i_weapon_repository.dart';

class GetWeaponsUseCase implements UseCase<List<WeaponEntity>, NoParams> {
  final IWeaponRepository repository;

  GetWeaponsUseCase(this.repository);

  @override
  Future<Either<Failure, List<WeaponEntity>>> call(NoParams params) {
    return repository.getWeapons();
  }
}
