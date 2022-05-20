import 'package:equatable/equatable.dart';
import 'package:tdd_flutter/core/error/failuere.dart';
import 'package:dartz/dartz.dart';
import 'package:tdd_flutter/core/usecases/usecases.dart';
import 'package:tdd_flutter/features/number_trivia/domain/enetities/number_trivia.dart';
import 'package:tdd_flutter/features/number_trivia/domain/repositories/number_trivia_repository.dart';
//
// class GetRandomNumberTrivia implements UseCase<NumberTrivia, String> {
//   final NumberTriviaRepository repository;
//
//   GetRandomNumberTrivia(this.repository);
//
//   @override
//   Future<Either<String, String>?> call(String s) async {
//     print("calling grn usecase");
//     return await repository.getRandomNumberTrivia();
//   }
// }
//
// class NoParams extends Equatable {
//   @override
//   // TODO: implement props
//   List<Object?> get props => throw UnimplementedError();
// }


class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}
