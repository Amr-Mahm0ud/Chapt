// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:chapt/app/app_constants.dart';
import 'package:chapt/domain/models/models.dart';
import 'package:chapt/domain/use_case/send_message_use_case.dart';
import 'package:chapt/presentation/common/freezed_data_classes.dart';
import 'package:chapt/presentation/resources/app_strings.dart';
import 'package:chapt/presentation/resources/values_manager.dart';
import 'package:chapt/presentation/view_models/base/base_view_model.dart';
import 'package:flutter/material.dart';

import '../../common/popup_error.dart';

class MainViewModel extends BaseViewModel
    implements MainViewModelInputs, MainViewModelOutputs {
  final StreamController<String> _messageStreamController =
      StreamController<String>.broadcast();

  final StreamController<bool> _showTtsController =
      StreamController<bool>.broadcast();

  final StreamController<List<Message>> _allMessagesStreamController =
      StreamController.broadcast();

  //APPMENU controller
  final Set<String> appMenu = {
    AppStrings.clearChat,
    AppStrings.changeTheme,
    AppStrings.logout
  };
  //*************************************** */

  final List<Message> _oldMessages = <Message>[];

  bool isLoading = false;
  bool _showTts = false;

  SendMessageObject _sendMessageObject =
      SendMessageObject(AppConstants.emptyStr, []);

  final SendMessageUseCase _sendMessageUseCase;
  MainViewModel(this._sendMessageUseCase);

  //base view model functions
  @override
  void dispose() {
    _messageStreamController.close();
    _allMessagesStreamController.close();
    _showTtsController.close();
  }

  @override
  void start() {}

  clearChat() {
    _oldMessages.clear();
    inputAllMessages.add(<Message>[]);
  }

  // format response Message
  // ******************************

  List<Widget> formatText(String text, context) {
    text = text.replaceAll('\n\n', '\n');
    RegExp regex = RegExp(r'\*\*(.*?)\*\*');
    //to add every splited text
    List<Widget> spans = [];
    //decide if it a title or regular text
    text.splitMapJoin(
      regex,
      onMatch: (Match match) {
        spans.add(
          Text(
            match.group(1).toString(),
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        );
        return '';
      },
      onNonMatch: (restText) {
        regex = RegExp(r'```(.*?)```', dotAll: true);
        restText.splitMapJoin(
          regex,
          onMatch: (Match match) {
            spans.add(
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppPadding.p10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(AppValues.v10),
                ),
                child: Text(
                  match.group(1).toString().trim(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
            );
            return '';
          },
          onNonMatch: (normalText) {
            spans.add(
              Text(
                normalText,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
            return '';
          },
        );
        return '';
      },
    );
    for (var element in spans) {
      print(element);
    }
    return spans;
  }
  //************************************************************* */
  //view model inputs functions

  @override
  Sink<String> get inputMessage => _messageStreamController.sink;

  @override
  Sink get inputAllMessages => _allMessagesStreamController.sink;

  @override
  Sink get inputShowTts => _showTtsController.sink;

  @override
  Future<bool> sendMessage(BuildContext context) async {
    try {
      isLoading = true;
      _sendMessageObject = _sendMessageObject
          .copyWith(oldMsgs: [..._oldMessages.map((msg) => msg)]);
      _oldMessages.add(Message(_sendMessageObject.msg, 'user'));
      inputAllMessages.add([..._oldMessages.map((msg) => msg)]);
      (await _sendMessageUseCase.excute(
        SendMessageUseCaseInput(
            _sendMessageObject.msg, _sendMessageObject.oldMsgs),
      ))
          .fold((failure) {
        isLoading = false;
        _oldMessages.removeLast();
        inputAllMessages.add([..._oldMessages.map((msg) => msg)]);
        PopupError.showErrorDialog(context, failure.message);
        return false;
      }, (data) {
        isLoading = false;
        _oldMessages.add(data);
        inputAllMessages.add([..._oldMessages.map((msg) => msg)]);
        _sendMessageObject = _sendMessageObject
            .copyWith(oldMsgs: [..._oldMessages.map((msg) => msg)]);
        return true;
      });
    } catch (error) {
      isLoading = false;
      if (_oldMessages.isNotEmpty && _oldMessages.last.role == 'user') {
        _oldMessages.removeLast();
      }
      inputAllMessages.add([..._oldMessages.map((msg) => msg)]);
      PopupError.showErrorDialog(context, error.toString());
      return false;
    }
    return false;
  }

  @override
  setMessage(msg) {
    inputMessage.add(msg);
    _sendMessageObject = _sendMessageObject.copyWith(msg: msg);
  }

  @override
  setShowTts() {
    _showTts = !_showTts;
    inputShowTts.add(_showTts);
  }

  //*************************************************************** */
  //output view model functions
  @override
  Stream<bool> get outputMessage =>
      _messageStreamController.stream.map((msg) => _validateMsg(msg));

  @override
  Stream<List<Message>> get outputAllMessages =>
      _allMessagesStreamController.stream;

  @override
  Stream<bool> get outputShowTts => _showTtsController.stream;

  //validation functions
  bool _validateMsg(msg) {
    if (msg == null || msg.trim().isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}

abstract class MainViewModelInputs extends BaseViewModelInputs {
  setMessage(value);
  sendMessage(BuildContext context);
  setShowTts();
  Sink<String> get inputMessage;
  Sink get inputAllMessages;
  Sink get inputShowTts;
}

abstract class MainViewModelOutputs extends BaseViewModelOutputs {
  Stream<bool> get outputMessage;
  Stream<bool> get outputShowTts;
  Stream<List<Message>> get outputAllMessages;
}
