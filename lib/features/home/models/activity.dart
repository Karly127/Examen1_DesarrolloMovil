import 'package:flutter/material.dart';

class Activity{
  final String title;
  final String subtitle;
  final IconData icon;
  final String trailingText;
  final Color iconColor;

  Activity({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.trailingText,
    required this.iconColor,
  });
}