import 'dart:async';

import 'package:chapt/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped, paused, continued }

class TextToSpeechImplementer {
  //variables to handle Ui
  final StreamController<TtsState> _speakingState =
      StreamController<TtsState>.broadcast();

  TtsState ttsState = TtsState.stopped;

  // *********************************************
  dispose() {
    _speakingState.close();
  }

  //variables for package usage
  final FlutterTts flutterTts = FlutterTts();
  double volume = AppValues.v05;
  double pitch = AppValues.i1.toDouble();
  double rate = AppValues.v05;

  // ******************************************* */
  Sink<TtsState> get inputState => _speakingState.sink;
  Stream<TtsState> get outputState => _speakingState.stream;

  // ******************************************* */
  bool get isPlaying => ttsState == TtsState.playing;
  bool get isStopped => ttsState == TtsState.stopped;
  bool get isPaused => ttsState == TtsState.paused;
  bool get isContinued => ttsState == TtsState.continued;

  // ******************************************** */
  //package functions

  Future<void> speak(String text, context) async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    flutterTts.setCompletionHandler(() {
      ttsState = TtsState.stopped;
      inputState.add(ttsState);
    });

    flutterTts.setPauseHandler(() {
      ttsState = TtsState.paused;
      inputState.add(ttsState);
    });

    flutterTts.setContinueHandler(() {
      ttsState = TtsState.playing;
      inputState.add(ttsState);
    });

    flutterTts.setCancelHandler(() {
      ttsState = TtsState.stopped;
      inputState.add(ttsState);
    });

    flutterTts.setErrorHandler((message) {
      buildSnackBar(context, message);
    });

    if (text.isNotEmpty) {
      await flutterTts.speak(text);
      ttsState = TtsState.playing;
      inputState.add(ttsState);
    }
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buildSnackBar(
      context, message) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).primaryColor,
      behavior: SnackBarBehavior.floating,
      elevation: AppValues.v05,
      margin: const EdgeInsets.all(AppPadding.p10),
      shape: const StadiumBorder(),
      content: Row(
        children: [
          const Icon(Icons.error),
          const SizedBox(width: AppPadding.p10),
          Text(message),
        ],
      ),
    ));
  }

  Future<void> stop() async {
    final res = await flutterTts.stop();
    if (res == 1) {
      ttsState = TtsState.stopped;
      inputState.add(ttsState);
    }
  }

  Future<void> pause() async {
    await flutterTts.pause();
  }

  // changeRate() {
  //   rate = rate == AppValues.v05 ? AppValues.i1.toDouble() : AppValues.v05;
  //   flutterTts.setSpeechRate(rate);
  // }
}
