import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aircrafts_router/src/ui/app_dimensions.dart';

class DigitsInputField extends StatelessWidget {
  const DigitsInputField(
      {super.key, required this.controller, required this.onChanged});

  final TextEditingController controller;
  final void Function(String data) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: AppDimensions.size(context).width * 0.25,
      child: TextField(
        controller: controller,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: onChanged,
      ),
    );
  }
}
