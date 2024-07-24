import 'package:dartz/dartz.dart';
import 'package:maids_cc_task/data/network/failure.dart';

abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> execute(In params);
}
