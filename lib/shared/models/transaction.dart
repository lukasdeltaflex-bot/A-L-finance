import 'package:flutter/material.dart';

enum TransactionType { income, expense }

class Transaction {
  final String id;
  final String title;
  final String description;
  final double amount;
  final DateTime date;
  final String category;
  final TransactionType type;
  final IconData icon;
  final Color color;
  final String userId;
  final String? userName;

  Transaction({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
    required this.category,
    required this.type,
    required this.icon,
    required this.color,
    required this.userId,
    this.userName,
  });
}
