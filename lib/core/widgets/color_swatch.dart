import 'package:flutter/material.dart';

class ColorSwatch extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback? onTap;
  final double size;
  final String? label;

  const ColorSwatch({
    super.key,
    required this.color,
    this.isSelected = false,
    this.onTap,
    this.size = 32,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected 
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey.withValues(alpha: 0.3),
                width: isSelected ? 3 : 1,
              ),
            ),
            child: isSelected 
              ? Icon(
                  Icons.check,
                  size: size * 0.5,
                  color: _getContrastColor(color),
                )
              : null,
          ),
          if (label != null) ...[
            const SizedBox(height: 4),
            Text(
              label!,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Color _getContrastColor(Color color) {
    final double luminance = color.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}

class ColorSwatchList extends StatelessWidget {
  final List<MapEntry<String, Color>> colors;
  final String? selectedColorName;
  final ValueChanged<String>? onColorSelected;
  final bool showLabels;

  const ColorSwatchList({
    super.key,
    required this.colors,
    this.selectedColorName,
    this.onColorSelected,
    this.showLabels = true,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: colors.map((entry) {
        return ColorSwatch(
          color: entry.value,
          label: showLabels ? entry.key : null,
          isSelected: selectedColorName == entry.key,
          onTap: () => onColorSelected?.call(entry.key),
        );
      }).toList(),
    );
  }
}