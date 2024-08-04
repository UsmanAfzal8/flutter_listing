import 'package:flutter/material.dart';

class JobModel {
  final int id;
  final String company;
  final String logo;
  final bool isNew;
  final bool featured;
  final String position;
  final String role;
  final String level;
  final String postedAt;
  final String contract;
  final String location;
  final List<String> languages;
  final List<String> tools;

  JobModel({
    required this.id,
    required this.company,
    required this.logo,
    required this.isNew,
    required this.featured,
    required this.position,
    required this.role,
    required this.level,
    required this.postedAt,
    required this.contract,
    required this.location,
    required this.languages,
    required this.tools,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'],
      company: json['company'],
      logo: json['logo'],
      isNew: json['new'],
      featured: json['featured'],
      position: json['position'],
      role: json['role'],
      level: json['level'],
      postedAt: json['postedAt'],
      contract: json['contract'],
      location: json['location'],
      languages: List<String>.from(json['languages']),
      tools: List<String>.from(json['tools']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company,
      'logo': logo,
      'new': isNew,
      'featured': featured,
      'position': position,
      'role': role,
      'level': level,
      'postedAt': postedAt,
      'contract': contract,
      'location': location,
      'languages': languages,
      'tools': tools,
    };
  }
}
