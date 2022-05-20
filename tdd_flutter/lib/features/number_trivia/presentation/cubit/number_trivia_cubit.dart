import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_flutter/features/number_trivia/domain/usecases/get_concrte_number_trivia.dart';
import 'package:tdd_flutter/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:tdd_flutter/features/number_trivia/presentation/cubit/number_trivia_cubit_state.dart';

class NumberCubit extends Cubit<InitailState>{
  GetRandomNumberTrivia grn;
  GetConcreteNumberTrivia gcn;

  NumberCubit(this.grn,this.gcn) : super(userState());
  late var d;
  Future<void> getRandomNumber() async {
    print('getRandomNumber cubit');
  //  d=(await grn.call('15'));
    d.fold((l) => emit(userStateFail(l)), (r) => emit(userStateSucc(r)));
  }
  void getConcrateNumber(value) async{
    print('getConcrateNumber cubit');
 //   d=(await gcn.call(value.toString()));
    d.fold((l) => emit(userStateSucc(l)), (r) =>
        emit(userStateSucc(r)));
  }
}