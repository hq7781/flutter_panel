import 'package:fast_color_picker/fast_color_picker.dart';
import 'package:flutter/material.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker({
    super.key,
    required this.selectedColor,
    required this.onColorSelected,
    this.label = "Color Picker",
  });
  final Color selectedColor;
  final Function(Color) onColorSelected;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle().copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FastColorPicker(
            icon: Icons.circle_notifications, //.checkCircle,
            selectedColor: selectedColor,
            onColorSelected: onColorSelected,
          ),
        ),
      ],
    );
  }
}
