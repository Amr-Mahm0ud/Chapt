import 'package:chapt/app/app_prefs.dart';
import 'package:chapt/app/dependency_injection.dart';
import 'package:chapt/app/theme_controller.dart';
import 'package:chapt/domain/models/models.dart';
import 'package:chapt/presentation/resources/app_strings.dart';
import 'package:chapt/presentation/resources/color_manager.dart';
import 'package:chapt/presentation/resources/values_manager.dart';
import 'package:chapt/presentation/services/speech_to_text.dart';
import 'package:chapt/presentation/view_models/home/main_view_model.dart';
import 'package:chapt/presentation/widgets/common/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../../resources/assets_manager.dart';
import '../../widgets/common/blur_effect.dart';
import '../../widgets/home/chat_bubble.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MainViewModel _viewModel = instance<MainViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final ThemeController _themeController = instance<ThemeController>();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final SpeechToTextImplementer _speechToTextImplementer =
      SpeechToTextImplementer();

  _bind() {
    _viewModel.start();
    _speechToTextImplementer.initSpeechState(context);
    _messageController
        .addListener(() => _viewModel.setMessage(_messageController.text));
  }

  @override
  void initState() {
    _bind();

    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _themeController.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    _speechToTextImplementer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBodySection(context),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: AppPadding.p10),
          Text('${AppStrings.welcome}, Amr'),
        ],
      ),
      actions: [
        PopupMenuButton<String>(
          position: PopupMenuPosition.under,
          elevation: AppValues.v05,
          onSelected: (val) {
            if (val == AppStrings.logout) {
              _appPreferences.logout(context);
            } else if (val == AppStrings.clearChat) {
              _viewModel.clearChat();
            } else if (val == AppStrings.darkTheme) {
              _themeController.changeTheme();
            }
          },
          itemBuilder: (BuildContext context) {
            return _viewModel.appMenu.map((String choice) {
              return PopupMenuItem<String>(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p25, vertical: AppPadding.p15),
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),
      ],
      flexibleSpace: ClipRRect(
        child: AppBlurEffect(
          child: Container(
            color: Theme.of(context).cardColor.withOpacity(AppValues.v025),
          ),
        ),
      ),
    );
  }

  _buildSendMessageSection() {
    return ClipRRect(
      child: AppBlurEffect(
        child: Container(
          color: Theme.of(context).cardColor.withOpacity(AppValues.v025),
          padding: const EdgeInsets.all(AppPadding.p10),
          child: AppInputField(
            type: TextInputType.multiline,
            hint: AppStrings.writeMsg,
            controller: _messageController,
            filled: false,
            haveErrorText: false,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppValues.v50),
              borderSide: BorderSide.none,
            ),
            action: _viewModel.isLoading
                ? null
                : StreamBuilder<bool>(
                    initialData: false,
                    stream: _speechToTextImplementer.outputListening,
                    builder: (_, isListening) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isListening.data!)
                            IconButton(
                              onPressed: () async {
                                await _speechToTextImplementer
                                    .cancelListening()
                                    .then(
                                      (value) => _messageController.clear(),
                                    );
                              },
                              color: Theme.of(context).disabledColor,
                              icon: const Icon(Icons.close),
                            ),
                          StreamBuilder<bool>(
                            stream: _viewModel.outputMessage,
                            initialData: false,
                            builder: (_, snapshot) {
                              return IconButton(
                                icon: Icon(
                                  snapshot.data! && !(isListening.data!)
                                      ? Icons.send_rounded
                                      : isListening.data!
                                          ? Icons.mic
                                          : Icons.mic_none,
                                ),
                                color: snapshot.data! || isListening.data!
                                    ? ColorManager.primary
                                    : Theme.of(context).disabledColor,
                                onPressed: snapshot.data! &&
                                        !_viewModel.isLoading
                                    ? () async {
                                        Future.delayed(const Duration(
                                                milliseconds: AppValues.i100))
                                            .then((value) =>
                                                _messageController.clear());
                                        await _viewModel
                                            .sendMessage(context)
                                            .then(
                                          (value) {
                                            if (value) {
                                              _scrollController.animateTo(
                                                  _scrollController
                                                      .position.maxScrollExtent,
                                                  duration: const Duration(
                                                      milliseconds:
                                                          AppValues.i300),
                                                  curve: Curves.linear);
                                            }
                                          },
                                        );
                                      }
                                    : isListening.data!
                                        ? () async {
                                            await _speechToTextImplementer
                                                .stopListening();
                                          }
                                        : () async {
                                            await _speechToTextImplementer
                                                .startListening()
                                                .then(
                                                  (value) =>
                                                      _speechToTextImplementer
                                                          .outPutText
                                                          .listen(
                                                    (value) {
                                                      _messageController.text =
                                                          value;
                                                    },
                                                  ),
                                                );
                                          },
                              );
                            },
                          ),
                        ],
                      );
                    }),
          ),
        ),
      ),
    );
  }

  _buildBodySection(context) {
    return StreamBuilder<List<Message>>(
        stream: _viewModel.outputAllMessages,
        builder: (context, snapshot) {
          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AssetsManager.onboarding2,
                          width: AppValues.getWidth(context) * AppValues.v025,
                        ),
                        const SizedBox(height: AppValues.v20),
                        Text(
                          AppStrings.askQuestion,
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  _buildSendMessageSection(),
                ],
              ),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    padding: const EdgeInsets.only(top: AppPadding.p5),
                    child: Column(
                      children: [
                        ...snapshot.data!
                            .map((message) => AppChatBubble(message: message)),
                        _viewModel.isLoading
                            ? LottieBuilder.asset(
                                AssetsManager.loading,
                                width: AppValues.getWidth(context) * 0.25,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
                _buildSendMessageSection(),
              ],
            );
          }
        });
  }
}
