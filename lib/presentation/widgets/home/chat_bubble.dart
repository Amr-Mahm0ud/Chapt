import 'package:chapt/app/app_constants.dart';
import 'package:chapt/app/dependency_injection.dart';
import 'package:chapt/domain/models/models.dart';
import 'package:chapt/presentation/resources/values_manager.dart';
import 'package:chapt/presentation/services/text_to_speech.dart';
import 'package:chapt/presentation/view_models/home/main_view_model.dart';
import 'package:flutter/material.dart';

class AppChatBubble extends StatefulWidget {
  final Message message;
  const AppChatBubble({super.key, required this.message});

  @override
  State<AppChatBubble> createState() => _AppChatBubbleState();
}

class _AppChatBubbleState extends State<AppChatBubble> {
  final MainViewModel _mainViewModel = instance<MainViewModel>();
  final TextToSpeechImplementer _textToSpeechImplementer =
      TextToSpeechImplementer();

  @override
  void dispose() {
    _mainViewModel.dispose();
    _textToSpeechImplementer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.message.role == AppConstants.modelRoleName
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: StreamBuilder<bool>(
          initialData: false,
          stream: _mainViewModel.outputShowTts,
          builder: (context, snapshot) {
            return GestureDetector(
              onTap: () {
                _mainViewModel.setShowTts();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p15, vertical: AppPadding.p10),
                margin: EdgeInsets.only(
                  bottom: AppPadding.p10,
                  right: widget.message.role == AppConstants.modelRoleName
                      ? AppMargins.m40
                      : AppPadding.p10,
                  left: widget.message.role == AppConstants.modelRoleName
                      ? AppPadding.p10
                      : AppMargins.m40,
                ),
                decoration: BoxDecoration(
                  color: widget.message.role == AppConstants.modelRoleName
                      ? Theme.of(context).cardColor
                      : Theme.of(context).colorScheme.primary,
                  borderRadius:
                      widget.message.role == AppConstants.modelRoleName
                          ? const BorderRadius.only(
                              bottomRight: Radius.circular(AppValues.v15),
                              topRight: Radius.circular(AppValues.v15),
                              topLeft: Radius.circular(AppValues.v15),
                            )
                          : const BorderRadius.only(
                              bottomLeft: Radius.circular(AppValues.v15),
                              topRight: Radius.circular(AppValues.v15),
                              topLeft: Radius.circular(AppValues.v15),
                            ),
                ),
                child: widget.message.role == AppConstants.modelRoleName
                    ? Column(
                        children: [
                          RichText(
                            text: _mainViewModel.formatText(
                                widget.message.msg, context),
                          ),
                          if (snapshot.data!) ...[
                            const SizedBox(height: AppPadding.p10),
                            StreamBuilder<TtsState>(
                                initialData: _textToSpeechImplementer.ttsState,
                                stream: _textToSpeechImplementer.outputState,
                                builder: (context, snapshot) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap:
                                            _textToSpeechImplementer.isPlaying
                                                ? () async {
                                                    await _textToSpeechImplementer
                                                        .pause();
                                                  }
                                                : () async {
                                                    await _textToSpeechImplementer
                                                        .speak(
                                                            _mainViewModel
                                                                .formatMessageAsString(
                                                                    widget
                                                                        .message
                                                                        .msg),
                                                            context);
                                                  },
                                        child: AnimatedIcon(
                                          progress: kAlwaysCompleteAnimation,
                                          icon:
                                              _textToSpeechImplementer.isPlaying
                                                  ? AnimatedIcons.play_pause
                                                  : AnimatedIcons.pause_play,
                                        ),
                                      ),
                                      if (_textToSpeechImplementer.isPlaying ||
                                          _textToSpeechImplementer
                                              .isPaused) ...[
                                        const SizedBox(width: AppPadding.p10),
                                        InkWell(
                                          onTap: () {
                                            _textToSpeechImplementer.changeRate(
                                              _mainViewModel
                                                  .formatMessageAsString(
                                                widget.message.msg,
                                              ),
                                            );
                                          },
                                          child: Icon(
                                              _textToSpeechImplementer.rate ==
                                                      AppValues.v05
                                                  ? Icons.looks_two_outlined
                                                  : Icons.looks_two_rounded),
                                        ),
                                        const SizedBox(width: AppPadding.p10),
                                        InkWell(
                                          onTap: () {
                                            _textToSpeechImplementer.stop();
                                          },
                                          child: const Icon(Icons.close),
                                        )
                                      ]
                                    ],
                                  );
                                })
                          ]
                        ],
                      )
                    : Text(widget.message.msg),
              ),
            );
          }),
    );
  }
}
