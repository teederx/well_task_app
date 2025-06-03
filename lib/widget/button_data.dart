import 'package:flutter/material.dart';

import '../utils/constants/app_theme.dart';

class ButtonData {
  final String id;
  final String name;
  final Color color;

  ButtonData({required this.id, required this.name, required this.color});
}

List<ButtonData> buttons = [
  ButtonData(id: '1', name: 'Let\'s Go', color: AppTheme.purple),
];
