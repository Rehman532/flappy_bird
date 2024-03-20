// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flappy_bird/widgets/game_over_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/barrier_widget.dart';
import '../widgets/bird_widget.dart';
import '../widgets/cloud_widget.dart';
import '../widgets/splash_screen_widget.dart';
import '../widgets/two_line_widget.dart';
import 'game_bloc.dart';

class Game extends StatelessWidget {
  static late GameBloc _bloc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc()..add(OnInitialiseGame()),
      child: BlocConsumer<GameBloc, GameState>(
        listener: (context, state) {
          if (state is GameProgressUpdated) {
            if (state.birdYaxis > 1 || state.isBarrierTouched) {
              showGameDialog(context);
              return;
            }
          }
        },
        builder: (context, state) {
          _bloc = BlocProvider.of<GameBloc>(context);
          if (state is GameProgressUpdated) {
            final birdYaxis = state.birdYaxis;
            final barrierXOne = state.barrierXOne;
            final isStartGame = state.isStartGame;
            final barrierXTwo = state.barrierXTwo;
            final score = state.score;
            final bestScore = state.bestScore;
            return GestureDetector(
              onTap: () {
                isStartGame
                    ? _bloc.add(OnScreenTapped())
                    : _bloc.add(OnStartGame());
              },
              child: Scaffold(
                body: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Stack(
                        children: [
                          MyBird(
                            birdYAxis: birdYaxis,
                          ),
                          // barrierXOne
                          MyBarrier(
                            barrierHeight: 170,
                            barrierXAxis: barrierXOne,
                            barrierYAxis: 1.1,
                          ),
                          //barrierXTwo
                          MyBarrier(
                            barrierHeight: 110,
                            barrierXAxis: barrierXTwo,
                            barrierYAxis: 1.1,
                          ),
                          Align(
                            alignment: Alignment(0.9, -0.85),
                            child: MyClouds(),
                          ),
                          //barrierXTwo
                          MyBarrier(
                            barrierHeight: 250,
                            barrierXAxis: barrierXTwo,
                            barrierYAxis: -1.1,
                          ),
                          //barrierXOne
                          MyBarrier(
                            barrierHeight: 180,
                            barrierXAxis: barrierXOne,
                            barrierYAxis: -1.1,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.green,
                      height: 15,
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 28),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue,
                                  Colors.green,
                                ],
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TwoLineWidget(
                                  title: "Score",
                                  subTitle: score.toString(),
                                ),
                                TwoLineWidget(
                                  title: "High Score",
                                  subTitle: bestScore.toString(),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: !isStartGame,
                            child: Align(
                              alignment: Alignment(0, -0.8),
                              child: Text(
                                "T A P   T O   P L A Y",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return SplashScreen();
        },
      ),
    );
  }

  // showGameOverDialog(context) {
  // showDialog(
  //   context: context,
  //   barrierDismissible: false,
  //   builder: (context) => AlertDialog(
  //     backgroundColor: Colors.black,
  //     title: Text(
  //       "G A M E O V E R",
  //       textAlign: TextAlign.center,
  //       style: TextStyle(color: Colors.red),
  //     ),
  //     actions: [
  //       TextButton(
  //         onPressed: () {
  //           Navigator.pop(context);
  //           _bloc.add(OnStartGame());
  //         },
  //         child: Text(
  //           "Play Again",
  //           style: TextStyle(color: Colors.black),
  //         ),
  //       )
  //     ],
  //   ),
  // );
  // }
  showGameDialog(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.blue,
                    Colors.green,
                  ],
                )),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.black.withAlpha(100),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 100),
                      child: Wrap(
                        direction: Axis.vertical,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 10,
                        children: [
                          const Text(
                            'G A M E  O V E R',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            width: 150,
                            margin: EdgeInsets.only(top: 20),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blueGrey),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                _bloc.add(OnStartGame());
                              },
                              child: const Text(
                                'Play Again',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blueGrey),
                              ),
                              onPressed: () {
                                SystemNavigator.pop();
                              },
                              child: const Text(
                                 'Exit',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
