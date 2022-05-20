import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_flutter/core/error/failuere.dart';
//
// abstract class UseCase<Type, String> {
//    Future<Either<String,String>?> call (String params);
// }
// // class NoParams extends Equatable {
// //   @override
// //   // TODO: implement props
// //   List<Object?> get props => throw UnimplementedError();
// // }


abstract class UseCase <Type , Params>{
   Future<Either<Failure,Type>> call (Params params);
}

class NoParams extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}