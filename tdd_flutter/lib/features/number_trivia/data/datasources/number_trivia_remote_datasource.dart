import 'dart:convert';

import 'package:tdd_flutter/core/error/exception.dart';
import 'package:tdd_flutter/features/number_trivia/data/model/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteDbNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomDbNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({required this.client});

  @override
  Future<NumberTriviaModel> getConcreteDbNumberTrivia(int number) {
    return _getTriviaFromUrl('http://numbersapi.com/$number');
  }

  @override
  Future<NumberTriviaModel> getRandomDbNumberTrivia() {
    return _getTriviaFromUrl('http://numbersapi.com/random');
  }

  Future<NumberTriviaModel> _getTriviaFromUrl(String path) async {
    Uri uri = Uri.parse(path);
    final response =
    await client.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {

      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
