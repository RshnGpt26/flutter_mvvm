import 'package:flutter/material.dart';

import '../app_colors.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    super.key,
    required this.text,
    this.loading = false,
    required this.onTap,
  });

  final String text;
  final bool loading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 40,
        width: 200,
        child: Center(
          child: loading
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: CircularProgressIndicator(),
                )
              : Text(
                  text,
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                  ),
                ),
        ),
      ),
    );
  }
}
