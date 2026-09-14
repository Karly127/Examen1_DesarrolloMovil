import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String trailingText;
  final Color iconColor;

  const ActivityCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.trailingText,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: iconColor, size: 40.0),
        title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Text(trailingText, style: TextStyle(fontSize: 18)),
      ),
    );
  }

}