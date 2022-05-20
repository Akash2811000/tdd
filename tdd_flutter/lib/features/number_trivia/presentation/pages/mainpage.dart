import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_flutter/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:tdd_flutter/features/number_trivia/presentation/cubit/number_trivia_cubit.dart';
import 'package:tdd_flutter/features/number_trivia/presentation/cubit/number_trivia_cubit_state.dart';
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<NumberCubit, InitailState>(
            builder: (context, state) {
              if (state is userStateSucc) {
                return Text(
                  state.number.toString(),
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                );
              } else if (state is userStateFail) {
                return Text(state.message,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                );
              } else {
                return const Text(
                  'Serching',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                );
              }
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlatButton(
                  onPressed: () {
                    context.read<NumberCubit>().getRandomNumber();
                  },
                  child: const Text(
                    'Random',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  color: Colors.blue),
              const SizedBox(
                width: 10,
              ),
              FlatButton(
                  onPressed: () {
                    context.read<NumberCubit>().getConcrateNumber(55);
                  },
                  child: const Text(
                    'Serch',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  color: Colors.blue),
            ],
          ),
        ],
      ),
    );
  }
}
