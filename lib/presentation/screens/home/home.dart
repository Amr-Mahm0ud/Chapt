import 'package:chapt/app/dependency_injection.dart';
import 'package:chapt/domain/models/models.dart';
import 'package:chapt/presentation/resources/app_strings.dart';
import 'package:chapt/presentation/resources/color_manager.dart';
import 'package:chapt/presentation/resources/values_manager.dart';
import 'package:chapt/presentation/view_models/home/main_view_model.dart';
import 'package:chapt/presentation/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../resources/assets_manager.dart';
import '../../widgets/blur_effect.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MainViewModel _viewModel = instance<MainViewModel>();
  final TextEditingController _messageController = TextEditingController();

  _bind() {
    _viewModel.start();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBodySection(context),
      // bottomSheet: _buildSendMessageSection(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            child: Icon(Icons.person),
          ),
          SizedBox(width: AppPadding.p10),
          Text('${AppStrings.welcome}, Amr'),
        ],
      ),
      actions: [
        PopupMenuButton<String>(
          position: PopupMenuPosition.under,
          elevation: AppValues.v05,
          onSelected: (val) {
            _viewModel.clearChat();
          },
          itemBuilder: (BuildContext context) {
            return {'Logout', 'Clear Chat', 'Settings'}.map((String choice) {
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
            hint: AppStrings.writeMsg,
            controller: _messageController,
            filled: false,
            haveErrorText: false,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppValues.v50),
              borderSide: BorderSide.none,
            ),
            action: StreamBuilder<bool>(
              stream: _viewModel.outputMessage,
              initialData: false,
              builder: (context, snapshot) => IconButton(
                icon: const Icon(Icons.send_rounded),
                color: ColorManager.primary,
                onPressed: snapshot.data!
                    ? () async {
                        Future.delayed(
                                const Duration(milliseconds: AppValues.i100))
                            .then((value) => _messageController.clear());
                        await _viewModel.sendMessage(context);
                      }
                    : null,
              ),
            ),
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
                    child: Column(
                      children: [
                        ...snapshot.data!.map(
                          (message) => Card(
                            child: Text(message.msg),
                          ),
                        )
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
