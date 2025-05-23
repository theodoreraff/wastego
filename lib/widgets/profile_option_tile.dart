import 'package:flutter/material.dart';

/// A customizable tile widget for displaying profile options.
///
/// This widget presents a tappable row with a title and a forward arrow icon,
/// commonly used in profile or settings screens.
class ProfileOptionTile extends StatelessWidget {
  /// The text to display as the title of the option.
  final String title;

  /// A callback function that is executed when the tile is tapped.
  /// If null, the tile will still be tappable but will perform no action.
  final VoidCallback? onTap;

  /// Creates a [ProfileOptionTile].
  ///
  /// The [title] is a required parameter. The [onTap] callback is optional.
  const ProfileOptionTile({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4),
      child: InkWell(
        // Handles the tap gesture. If [onTap] is null, it defaults to an empty function.
        onTap: onTap ?? () {},
        // Applies a border radius to the inkwell's splash effect.
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black), // Adds a black border around the container.
            borderRadius: BorderRadius.circular(12), // Applies a border radius to the container.
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Displays the title of the option with a specific font size.
              Text(title, style: const TextStyle(fontSize: 16)),
              // Displays a forward arrow icon.
              const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}