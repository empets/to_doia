import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:to_doia/core/service_systeme/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class EmptyRequest extends Equatable {
  @override
  List<Object> get props => [];
}



abstract class UseCaseStream<Type, Params> {
  Stream<Either<Failure, Type>> call(Params params);
}

