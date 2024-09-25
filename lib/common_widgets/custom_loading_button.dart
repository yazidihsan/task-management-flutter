import 'package:flutter/material.dart';
import 'package:tasks_management/theme_manager/color_manager.dart';

class CustomLoadingButton extends StatelessWidget {
  const CustomLoadingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: ColorManager.primary,
    );
  }
}
