import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const unquie = Uuid();
var formatter = DateFormat.yMd();

var categoryIcon = {
  Categorys.food: Icons.food_bank,
  Categorys.lesiure: Icons.movie_creation,
  Categorys.travel: Icons.flight,
  Categorys.work: Icons.work
};

enum Categorys { travel, food, lesiure, work }

class Expenses {
  Expenses({
    required this.expenseAmount,
    required this.expenseCategory,
    required this.expenseDate,
    required this.expenseTitle,
  }) : id = unquie.v4();

  final String id;
  final String expenseTitle;
  final int expenseAmount;
  final Categorys expenseCategory;
  final DateTime expenseDate;

  get formattedDate {
    return formatter.format(expenseDate);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  final List<Expenses> expenses;
  final Categorys category;

  ExpenseBucket.forCategory(List<Expenses> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.expenseCategory == category)
            .toList();

  double get totalExpense {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.expenseAmount;
    }

    return sum;
  }
}
