import 'dart:async';

import 'package:chapt/presentation/common/popup_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

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
  //Package Functions
  Future<void> initSpeechState(context) async {
    try {
      await speech.initialize(
        onError: (errorNotification) {
          PopupError.showErrorDialog(context, errorNotification.errorMsg);
          _inputListening.add(false);
        },
      );
    } catch (error) {
      PopupError.showErrorDialog(context, error.toString());
      _inputListening.add(false);
    }
  }

  Future<void> startListening() async {
    _inputText.add('');
    _inputListening.add(true);
    final options = SpeechListenOptions(
      listenMode: ListenMode.dictation,
      cancelOnError: true,
      partialResults: false,
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
    _inputText.add('');
  }

  Future<void> resultListener(SpeechRecognitionResult result) async {
    _inputText.add(result.recognizedWords);
    _inputListening.add(false);
  }
}
