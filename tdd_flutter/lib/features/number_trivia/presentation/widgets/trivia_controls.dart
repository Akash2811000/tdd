import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:tdd_flutter/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:tdd_flutter/features/number_trivia/presentation/bloc/number_trivia_event.dart';

class TriviaControl extends StatefulWidget {
  @override
  State<TriviaControl> createState() => _TriviaControlState();
}

class _TriviaControlState extends State<TriviaControl> {
  final controller = TextEditingController();
  String? inputStr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          // ignore: prefer_const_constructors
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: "Input a number",
          ),
          onChanged: (value) {
            inputStr = value;
          },
          onSubmitted: (_) {
            dispatchConcrete();
          },
        ),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              // ignore: deprecated_member_use
              child: RaisedButton(
                child: const Text('Search'),
                color: Theme.of(context).colorScheme.secondary,
                textTheme: ButtonTextTheme.primary,
                onPressed: dispatchConcrete,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              // ignore: deprecated_member_use
              child: RaisedButton(
                child: const Text('Get random trivia'),
                onPressed: dispatchRandom,
              ),
            ),
          ],
        )
      ],
    );
  }

  void dispatchConcrete() {
    // Clearing the TextField to prepare it for the next inputted number
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetTriviaForConcreteNumber(number: inputStr!));
  }

  void dispatchRandom() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForRandomNumber());
  }
}