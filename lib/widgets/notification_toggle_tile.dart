import 'package:flutter/material.dart';

/// A customizable tile widget for displaying a notification option with a toggle switch.
///
/// This widget presents a card containing a title and a [Switch] widget,
/// allowing users to easily toggle notification settings.
class NotificationToggleTile extends StatelessWidget {
  /// The title text displayed for the notification option.
  final String title;

  /// The current state of the toggle switch (true for on, false for off).
  final bool value;

  /// A callback function that is invoked when the switch's value changes.
  /// It receives the new boolean value of the switch.
  final ValueChanged<bool> onChanged;

  /// Creates a [NotificationToggleTile].
  ///
  /// All parameters [title], [value], and [onChanged] are required.
  const NotificationToggleTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2, // Adds a subtle shadow to the card.
      color: Colors.white, // Sets the background color of the card to white.
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Applies rounded corners to the card.
      ),
      margin: const EdgeInsets.symmetric(vertical: 8), // Adds vertical margin around the card.
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Sets internal padding.
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF003539), // Sets the text color using a hexadecimal value.
            fontSize: 16,
            fontWeight: FontWeight.bold, // Makes the title text bold.
          ),
        ),
        trailing: Switch(
          value: value, // Binds the switch's state to the `value` property.
          onChanged: onChanged, // Calls the `onChanged` callback when the switch is toggled.
          activeColor: const Color(0xFF003539), // Color of the switch when it's active (on).
          inactiveThumbColor: Colors.grey[400], // Color of the switch thumb when inactive (off).
          inactiveTrackColor: Colors.grey[300], // Color of the switch track when inactive (off).
        ),
      ),
    );
  }
}