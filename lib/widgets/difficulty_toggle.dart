import 'package:flutter/material.dart';
import '../models/difficulty_level.dart';
import '../core/app_constants.dart';

/// A widget for toggling between difficulty levels.
class DifficultyToggle extends StatelessWidget {
  final DifficultyLevel currentDifficulty;
  final Function(DifficultyLevel) onDifficultyChanged;

  const DifficultyToggle({
    super.key,
    required this.currentDifficulty,
    required this.onDifficultyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundDark,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMedium),
        border: Border.all(
          color: AppColors.borderGray,
          width: 1,
        ),
      ),
      child: Row(
        children: DifficultyLevel.values.asMap().entries.map((entry) {
          final index = entry.key;
          final level = entry.value;
          final isSelected = level == currentDifficulty;
          final isFirst = index == 0;
          final isLast = index == DifficultyLevel.values.length - 1;
          
          return Expanded(
            child: _InteractiveDifficultyButton(
              level: level,
              isSelected: isSelected,
              isFirst: isFirst,
              isLast: isLast,
              onTap: () => onDifficultyChanged(level),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _InteractiveDifficultyButton extends StatefulWidget {
  final DifficultyLevel level;
  final bool isSelected;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onTap;

  const _InteractiveDifficultyButton({
    required this.level,
    required this.isSelected,
    required this.isFirst,
    required this.isLast,
    required this.onTap,
  });

  @override
  State<_InteractiveDifficultyButton> createState() =>
      _InteractiveDifficultyButtonState();
}

class _InteractiveDifficultyButtonState
    extends State<_InteractiveDifficultyButton> {
  bool _isHovered = false;

  Color get _backgroundColor {
    if (widget.isSelected) {
      return AppColors.accent;
    }
    if (_isHovered) {
      return AppColors.surfaceDark;
    }
    return Colors.transparent;
  }

  Color get _textColor {
    if (widget.isSelected) {
      return AppColors.backgroundDark;
    }
    if (_isHovered) {
      return AppColors.textSecondary;
    }
    return AppColors.textTertiary;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppDurations.normal,
          curve: Curves.easeOut,
          width: double.infinity,
          height: AppSizes.buttonHeight,
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: widget.isFirst ? Radius.circular(AppSizes.borderRadiusMedium) : Radius.zero,
              bottomLeft: widget.isFirst ? Radius.circular(AppSizes.borderRadiusMedium) : Radius.zero,
              topRight: widget.isLast ? Radius.circular(AppSizes.borderRadiusMedium) : Radius.zero,
              bottomRight: widget.isLast ? Radius.circular(AppSizes.borderRadiusMedium) : Radius.zero,
            ),
            boxShadow: widget.isSelected ? [
              BoxShadow(
                color: AppColors.accent.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ] : null,
          ),
          child: Center(
            child: AnimatedDefaultTextStyle(
              duration: AppDurations.normal,
              curve: Curves.easeOut,
              style: AppTextStyles.buttonText.copyWith(color: _textColor),
              child: Text(widget.level.displayName.toUpperCase()),
            ),
          ),
        ),
      ),
    );
  }
} 