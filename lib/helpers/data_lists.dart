import 'package:flutter/material.dart';

enum contactType { email, phone }
// List<String> speciality = [
//   'مخ و اعصاب',
//   'باطنه',
//   'اسنان',
//   'عيون',
// ];
List<String> states = [
  'بنها',
  'طوخ',
  'قليوب',
  'شبين',
  'الخانكة',
];
// List<String> team = [
//   'صيدلة',
//   'طب',
// ];
List<String> searchBy = [
  'الاسم',
  'التخصص',
];
List<String> role = [
  'مسؤول الاستقبال',
  'مسؤول الميديا',
  'مسؤول الشراكات',
  'متطوع'
];

Map<String, Color> ColorsKeys = {
  'Lightred': Colors.red[100] as Color,
  'purple': Colors.purple,
  'blue': Colors.blue.shade300,
  'DarkBlue': Colors.blue[800] as Color,
  'brown': Colors.brown,
  'orange': Colors.orange,
  'Lightgreen': Colors.green[300] as Color,
  'grey': Colors.grey,
  'darkGreen': Colors.teal[500] as Color,
  'yellow': Colors.yellow,
};

Map teamByColor = {};
