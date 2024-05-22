import 'dart:async';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../resources/values_manager.dart';

class SpeechToTextImplementer {
  //variables to handle package functions
  final StreamController<String> _recognizedText =
      StreamController<String>.broadcast();
  final SpeechToText speech = SpeechToText();
  //***********************************
  //variables to handle UI
  final StreamController<bool> _isListeningController =
      StreamController<bool>.broadcast();

  // *************************************
  //sink & stream
  Sink<String> get _inputText => _recognizedText.sink;
  Stream<String> get outPutText => _recognizedText.stream;
  Sink<bool> get _inputListening => _isListeningController.sink;
  Stream<bool> get outputListening => _isListeningController.stream;
  // ************************************

  dispose() {
    speech.cancel();
    _recognizedText.close();
  }

  // ****************************************************
  //UI handling functions
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

  // ****************************************************
  //Package Functions
  Future<void> initSpeechState(context) async {
    try {
      await speech.initialize(
        onError: (errorNotification) {
          buildSnackBar(context, errorNotification);
        },
      );
    } catch (error) {
      buildSnackBar(context, error.toString());
    }
  }

  Future<void> startListening() async {
    _inputText.add('');
    _inputListening.add(true);
    final options = SpeechListenOptions(
      listenMode: ListenMode.dictation,
      cancelOnError: true,
      partialResults: true,
      autoPunctuation: true,
      enableHapticFeedback: true,
    );
    await speech.listen(
      onResult: resultListener,
      listenOptions: options,
    );
  }

  Future<void> stopListening() async {
    await speech.stop();
    _inputListening.add(false);
  }

  Future<void> cancelListening() async {
    await speech.cancel();
    _inputListening.add(false);
  }

  Future<void> resultListener(SpeechRecognitionResult result) async {
    _inputText.add(result.recognizedWords);
    await Future.delayed(const Duration(milliseconds: AppValues.i300))
        .then((value) => _inputListening.add(false));
  }
}
