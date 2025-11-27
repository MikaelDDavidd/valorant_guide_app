---
description: Generate a UseCase for a module
argument-hint: "<module> <action> <return-type>"
allowed-tools: Read, Write
---

Generate a UseCase for module $1 with action $2 returning $3.

Example: /gen-usecase agents get List<AgentEntity>

Create file: lib/app/modules/$1/domain/usecases/$2_$1_usecase.dart

Template:

```dart
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/$1_entity.dart';
import '../repositories/i_$1_repository.dart';

class ${Action}${Module}UseCase implements UseCase<$3, NoParams> {
  final I${Module}Repository _repository;

  ${Action}${Module}UseCase(this._repository);

  @override
  Future<Either<Failure, $3>> call(NoParams params) async {
    return await _repository.$2();
  }
}
```

Also update the binding file to include this use case injection.
