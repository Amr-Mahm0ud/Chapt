import 'package:chapt/app/dependency_injection.dart';
import 'package:chapt/presentation/resources/app_strings.dart';
import 'package:chapt/presentation/resources/color_manager.dart';
import 'package:chapt/presentation/resources/values_manager.dart';
import 'package:chapt/presentation/view_models/home/main_view_model.dart';
import 'package:chapt/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';
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
          onSelected: (val) {},
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
          child: const SizedBox(),
        ),
      ),
    );
  }
}
