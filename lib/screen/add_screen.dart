import 'package:expense_app/model/expense_model.dart';
import 'package:expense_app/widegts/add_expense.dart';
import 'package:flutter/material.dart';
//no need of this if modal is added
class AddExpense extends StatefulWidget {
  const AddExpense({Key? key, required this.addExpense}) : super(key: key);
  final void Function(ExpenseModel) addExpense;

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Screen'),
        // backgroundColor: const Color.fromARGB(255, 55, 21, 114),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child: NewExpense(addExpense: widget.addExpense),
      ),
    );
  }
}
