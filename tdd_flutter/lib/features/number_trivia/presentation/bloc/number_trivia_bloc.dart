import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_flutter/core/error/failuere.dart';
import 'package:tdd_flutter/core/usecases/usecases.dart';
import 'package:tdd_flutter/core/util/input_converter.dart';
import 'package:tdd_flutter/features/number_trivia/domain/enetities/number_trivia.dart';
import 'package:tdd_flutter/features/number_trivia/presentation/bloc/number_trivia_event.dart';
import 'package:tdd_flutter/features/number_trivia/presentation/bloc/number_trivia_state.dart';

import '../../domain/usecases/get_concrte_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;

  NumberTriviaBloc(
      {required this.getConcreteNumberTrivia,
        required this.getRandomNumberTrivia})
      : super(NumberTriviaInitial()) {
    on<GetTriviaForConcreteNumber>((event, emit) async {
      emit(Loading());

      var response = await getConcreteNumberTrivia
          .call(Params(number: int.parse(event.number)));
      print("call block gcn ");

      response.fold((failure) {
        emit(Error(message: failureType(failure)));
      }, (success) {
        emit(Loaded(trivia: success));
      });
    });

    on<GetTriviaForRandomNumber>((event, emit) async {
      emit(Loading());
      var response = await getRandomNumberTrivia.call(NoParams());
      print("call block grn ");
      response.fold((failure) {
        emit(Error(message: failureType(failure)));
      }, (success) {
        emit(Loaded(trivia: success));
      });
    });
  }
}

String failureType(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return "Server not working";
    case CatchFailure:
      return "cache error";
    default:
      return 'Unexpected Error';
  }
}
