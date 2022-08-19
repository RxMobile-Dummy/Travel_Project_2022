import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:make_my_trip/core/failures/failures.dart';
import 'package:make_my_trip/core/usecases/usecase.dart';
import 'package:make_my_trip/features/user/domain/repositories/user_repository.dart';

class DeleteDeviceId implements Usecase<bool, NoParams> {
  final UserRepository repository;

  DeleteDeviceId({required this.repository});

  @override
  Future<Either<Failures, bool>> call(NoParams params) async {
    return await repository.deleteDeviceId();
  }
}
