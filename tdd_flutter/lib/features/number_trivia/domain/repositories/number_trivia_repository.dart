import 'package:dartz/dartz.dart';
import 'package:tdd_flutter/features/number_trivia/domain/enetities/number_trivia.dart';
import '../../../../core/error/failuere.dart';

abstract class NumberTriviaRepository {
  // Future<Either<String, String>> getConcreteNumberTrivia(String number);
  // Future<Either<String, String>> getRandomNumberTrivia();

  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();

}
