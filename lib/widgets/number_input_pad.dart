import 'package:flutter/material.dart';
import '../core/app_constants.dart';

/// A numeric input pad for entering answers.
class NumberInputPad extends StatelessWidget {
  final Function(String) onNumberInput;
  final VoidCallback onBackspace;
  final VoidCallback onClear;
  final VoidCallback onSubmit;

  const NumberInputPad({
    super.key,
    required this.onNumberInput,
    required this.onBackspace,
    required this.onClear,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.backgroundDark,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildNumberRow(['1', '2', '3']),
          const SizedBox(height: AppSizes.paddingSmall),
          _buildNumberRow(['4', '5', '6']),
          const SizedBox(height: AppSizes.paddingSmall),
          _buildNumberRow(['7', '8', '9']),
          const SizedBox(height: AppSizes.paddingSmall),
          _buildActionRow(),
          const SizedBox(height: AppSizes.paddingMedium),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildNumberRow(List<String> numbers) {
    return Row(
      children: numbers.map((number) => _createNumberButton(number)).toList(),
    );
  }

  Widget _buildActionRow() {
    return Row(
      children: [
        _createActionButton(
          label: 'C',
          icon: Icons.clear_rounded,
          onPressed: onClear,
          color: AppColors.error,
        ),
        _createNumberButton('0'),
        _createActionButton(
          label: '⌫',
          icon: Icons.backspace_rounded,
          onPressed: onBackspace,
          color: AppColors.warning,
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.enterButtonHeight,
      child: _InteractiveButton(
        onTap: onSubmit,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusMedium),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_rounded,
                color: AppColors.backgroundDark,
                size: AppSizes.iconSizeMedium,
              ),
              SizedBox(width: AppSizes.paddingSmall),
              Text('ENTER', style: AppTextStyles.enterButtonText),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createNumberButton(String number) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: SizedBox(
          height: AppSizes.numpadButtonHeight,
          child: _InteractiveButton(
            onTap: () => onNumberInput(number),
            backgroundColor: AppColors.surfaceDark,
            hoverColor: AppColors.surfaceLight,
            pressedColor: AppColors.borderGray,
            child: Center(
              child: Text(number, style: AppTextStyles.numpadText),
            ),
          ),
        ),
      ),
    );
  }

  Widget _createActionButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: SizedBox(
          height: AppSizes.numpadButtonHeight,
          child: _InteractiveButton(
            onTap: onPressed,
            backgroundColor: color.withOpacity(0.1),
            hoverColor: color.withOpacity(0.2),
            pressedColor: color.withOpacity(0.3),
            child: Center(
              child: label == '⌫'
                  ? Icon(icon, size: AppSizes.iconSizeSmall, color: color)
                  : Text(
                      label,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InteractiveButton extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;
  final Color? backgroundColor;
  final Color? hoverColor;
  final Color? pressedColor;

  const _InteractiveButton({
    required this.onTap,
    required this.child,
    this.backgroundColor,
    this.hoverColor,
    this.pressedColor,
  });

  @override
  State<_InteractiveButton> createState() => _InteractiveButtonState();
}

class _InteractiveButtonState extends State<_InteractiveButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  Color get _currentColor {
    if (_isPressed && widget.pressedColor != null) {
      return widget.pressedColor!;
    }
    if (_isHovered && widget.hoverColor != null) {
      return widget.hoverColor!;
    }
    return widget.backgroundColor ?? Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusSmall),
          splashColor: AppColors.accent.withOpacity(0.3),
          highlightColor: AppColors.accent.withOpacity(0.1),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: _currentColor,
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusSmall),
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
} 