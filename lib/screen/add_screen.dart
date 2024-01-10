import 'package:expense_app/model/expense_model.dart';
// import 'package:expense_app/widegts/add_expense.dart';
import 'package:flutter/material.dart';

import '../widegts/add_expense.dart';

//no need of this if modal is added
class AddScreen extends StatefulWidget {
  const AddScreen({Key? key, required this.addExpense}) : super(key: key);
  final void Function(ExpenseModel) addExpense;

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Text('Add Screen'),
        // backgroundColor: const Color.fromARGB(255, 55, 21, 114),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 8 + keyboardSpace),
          child: AddExpense(addExpense: widget.addExpense),
        ),
      ),
    );
  }
}
