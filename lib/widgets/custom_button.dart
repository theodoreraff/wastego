import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;
  final bool isLoading;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.backgroundColor = const Color(
      0xFF003539,
    ), // Default color (Greenish tone)
    this.textColor = const Color(
      0xFFAFEE00,
    ), // Default text color (Light Green)
    this.icon,
    this.isLoading = false,
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
          elevation: 4, // Slight shadow for better focus
          padding: const EdgeInsets.symmetric(
            vertical: 14,
          ), // Padding for a clean look
          side: BorderSide(
            color: isDisabled ? Colors.grey : backgroundColor,
            width: 1.5, // Border color adjustment
          ),
        ),
        onPressed: isDisabled ? null : onPressed,
        child:
            isLoading
                ? const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold, // Bolder text for emphasis
                      ),
                    ),
                    if (icon != null) ...[
                      const SizedBox(width: 8),
                      Icon(icon, color: textColor),
                    ],
                  ],
                ),
      ),
    );
  }
}
