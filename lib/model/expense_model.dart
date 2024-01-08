import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

//creating a data type Category with predefined values
enum CategoryExpense { food, work, leisure, travel }

const categoryIcons = {
  CategoryExpense.food: Icons.dining_outlined,
  CategoryExpense.leisure: Icons.movie,
  CategoryExpense.travel: Icons.flight_takeoff_outlined,
  CategoryExpense.work: Icons.work_outline_rounded,
};

//Expense Model containg 4 variables and 1 getter
class ExpenseModel {
  ExpenseModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4(); //using uuid version 4 to create unique string ids

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final CategoryExpense category;
  String get formattedDate {
    return formatter.format(date);
  }
}

//Bucket model containg forCategory construction function, total getter, and 2 variables
class ExpenseBucket {
  ExpenseBucket({required this.expenses, required this.category});

  //Constructor function to make list of sifferent categories
  ExpenseBucket.forCategory(List<ExpenseModel> allexpenses, this.category)
      : expenses = allexpenses
            .where((allexpense) => allexpense.category == category)
            .toList();

  final CategoryExpense category;
  final List<ExpenseModel> expenses;

  // getter to get value toyal expenses in the category
  double get total {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
