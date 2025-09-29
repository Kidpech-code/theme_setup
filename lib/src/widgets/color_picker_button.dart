import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerButton extends StatelessWidget {
  final Color color;
  final ValueChanged<Color> onColorChanged;

  const ColorPickerButton({
    required this.color,
    required this.onColorChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final Color? picked = await showDialog<Color>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Pick a color'),
            content: SingleChildScrollView(
              child: BlockPicker(
                pickerColor: color,
                onColorChanged: onColorChanged,
              ),
            ),
          ),
        );
        if (picked != null) onColorChanged(picked);
      },
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey),
        ),
      ),
    );
  }
}

// Note: You may want to use a package like 'flutter_colorpicker' for a better picker UI.
// For now, this is a placeholder for a simple color picker dialog.
