import 'package:flutter/material.dart';

/// A customizable button widget for various UI actions.
/// Supports custom colors, borders, an optional icon, and a loading state.
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final TextStyle? textStyle;
  final Color borderColor;
  final double borderWidth;
  final IconData? icon;
  final bool iconAtStart;
  final bool isLoading;
  final double? elevation;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.backgroundColor = const Color(0xFF003539),
    this.textColor = const Color(0xFFAFEE00),
    this.textStyle,
    this.borderColor = Colors.transparent,
    this.borderWidth = 1.5,
    this.icon,
    this.iconAtStart = true,
    this.isLoading = false,
    this.elevation = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDisabled = isLoading || onPressed == null;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabled ? Colors.grey : backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: elevation,
          padding: const EdgeInsets.symmetric(vertical: 14),
          side: BorderSide(
            color: isDisabled ? Colors.grey : borderColor,
            width: borderWidth,
          ),
        ),
        onPressed: isDisabled ? null : onPressed,
        child: isLoading
            ? const CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2,
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null && iconAtStart) ...[
              Icon(icon, color: textColor),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: textStyle ??
                  TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            if (icon != null && !iconAtStart) ...[
              const SizedBox(width: 8),
              Icon(icon, color: textColor),
            ],
          ],
        ),
      ),
    );
  }
}