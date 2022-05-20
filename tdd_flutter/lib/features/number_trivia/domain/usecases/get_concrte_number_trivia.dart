import 'package:equatable/equatable.dart';
import 'package:tdd_flutter/core/error/failuere.dart';
import 'package:dartz/dartz.dart';
import 'package:tdd_flutter/core/usecases/usecases.dart';
import 'package:tdd_flutter/features/number_trivia/domain/enetities/number_trivia.dart';
import 'package:tdd_flutter/features/number_trivia/domain/repositories/number_trivia_repository.dart';

// class GetConcreteNumberTrivia implements UseCase<NumberTrivia, String> {
//   final NumberTriviaRepository repository;
//
//   GetConcreteNumberTrivia(this.repository);
//
//   @override
//   Future<Either<String, String>> call(String s) async {
//     return await repository.getConcreteNumberTrivia(s.toString());
//   }
// }
//
// class Params extends Equatable {
//   final int number;
//
//   const Params({required this.number});
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => [number];
// }



class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    print(params.number);
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;

  Params({required this.number}) ;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
