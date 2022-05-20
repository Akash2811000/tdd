import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_flutter/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:tdd_flutter/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:tdd_flutter/features/number_trivia/domain/usecases/get_concrte_number_trivia.dart';
import 'package:tdd_flutter/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:tdd_flutter/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:tdd_flutter/features/number_trivia/presentation/bloc/number_trivia_state.dart';
import 'package:tdd_flutter/features/number_trivia/presentation/pages/mainpage.dart';
import 'package:tdd_flutter/features/number_trivia/presentation/widgets/loading_widget.dart';
import 'package:tdd_flutter/features/number_trivia/presentation/widgets/message_display.dart';
import 'package:tdd_flutter/features/number_trivia/presentation/widgets/trivia_controls.dart';
import 'package:tdd_flutter/features/number_trivia/presentation/widgets/trivia_display.dart';
import 'package:tdd_flutter/injection_container.dart';

import 'features/number_trivia/presentation/cubit/number_trivia_cubit.dart';
import 'features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {+
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeApp(),
    );
  }
}

class HomeApp extends StatelessWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
      ),
      body: BlocProvider(
        create: (context) => sl<NumberTriviaBloc>(),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                    builder: (context, state) {
                      if (state is Empty) {
                        return const MessageDisplay(
                          message: 'Start searching!',
                        );
                      } else if (state is Loading) {
                        return const LoadingWidget();
                      } else if (state is Loaded) {
                        return TriviaDisplay(
                          numberTrivia: state.trivia,
                        );
                      } else if (state is Error) {
                        return MessageDisplay(
                          message: state.message,
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  TriviaControl(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
