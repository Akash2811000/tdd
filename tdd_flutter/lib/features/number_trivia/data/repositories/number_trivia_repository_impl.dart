import 'package:tdd_flutter/core/error/exception.dart';
import 'package:tdd_flutter/core/network/network_info.dart';
import 'package:tdd_flutter/features/number_trivia/data/datasources/number_triva_local_datasource.dart';
import 'package:tdd_flutter/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:tdd_flutter/features/number_trivia/data/model/number_trivia_model.dart';
import 'package:tdd_flutter/features/number_trivia/domain/enetities/number_trivia.dart';
import 'package:tdd_flutter/core/error/failuere.dart';
import 'package:dartz/dartz.dart';
import 'package:tdd_flutter/features/number_trivia/domain/repositories/number_trivia_repository.dart';

typedef Future<NumberTrivia> _ConcreteOrRandomChooser();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaLocalDataSource localDataSource;
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl(
      {required this.remoteDataSource,
        required this.localDataSource,
        required this.networkInfo});

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia( int number) async{
    print("repo impl $number");
    return await _getTrivia(() {
      return remoteDataSource.getConcreteDbNumberTrivia(number);
    });

    //return Right("number triva repo impl gcn");
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async{
   return await _getTrivia(() {
      return remoteDataSource.getRandomDbNumberTrivia();
    });
    // print("calling grn repo impl");
    // return Left("lrft triva repo impl grn");
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
    _ConcreteOrRandomChooser getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia as NumberTriviaModel);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CatchFailure());
      }
    }
  }
}
