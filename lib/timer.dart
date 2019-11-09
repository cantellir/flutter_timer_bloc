import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer/actions.dart' as actions;
import 'package:timer/background.dart';
import 'package:timer/bloc/timer_state.dart';

import 'bloc/timer_bloc.dart';

class Timer extends StatelessWidget {
  static const TextStyle timerTextStyle =
      TextStyle(fontSize: 60, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Timer'),
      ),
      body: Stack(
        children: <Widget>[
          Background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100.0),
                child: Center(
                  child: BlocBuilder<TimerBloc, TimerState>(
                    builder: (context, state) {
                      final String minuteStr = ((state.duration / 60) % 60)
                          .floor()
                          .toString()
                          .padLeft(2, '0');
                      final String secondsStr = (state.duration % 60)
                          .floor()
                          .toString()
                          .padLeft(2, '0');
                      return Text(
                        '$minuteStr:$secondsStr',
                        style: Timer.timerTextStyle,
                      );
                    },
                  ),
                ),
              ),
              BlocBuilder<TimerBloc, TimerState>(
                  condition: (previousState, currentState) =>
                      currentState.runtimeType != previousState.runtimeType,
                  builder: (context, state) => actions.Actions())
            ],
          ),
        ],
      ),
    );
  }
}
