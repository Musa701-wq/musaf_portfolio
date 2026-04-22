import 'package:flutter/material.dart';

class SkillModel {
  final String name;
  final IconData icon;
  final double level; // 0.0 to 1.0
  final String category;

  SkillModel({
    required this.name,
    required this.icon,
    required this.level,
    required this.category,
  });
}

class ProjectModel {
  final String title;
  final String description;
  final String techStack;
  final String? link;
  final String platform;
  final List<String> tags;

  ProjectModel({
    required this.title,
    required this.description,
    required this.techStack,
    this.link,
    required this.platform,
    required this.tags,
  });
}

class ExperienceModel {
  final String role;
  final String company;
  final String period;
  final String description;
  final bool isCurrent;
  final List<String> tags;

  ExperienceModel({
    required this.role,
    required this.company,
    required this.period,
    required this.description,
    this.isCurrent = false,
    required this.tags,
  });
}
