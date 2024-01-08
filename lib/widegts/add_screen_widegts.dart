// my first approach for styling add screen but made too many stateful widgets
import 'package:flutter/material.dart';

import '../model/expense_model.dart';

String title = "XYZ";
double amount = 999;
DateTime date = DateTime.now();
CategoryExpense category = CategoryExpense.food;

class Column1 extends StatefulWidget {
  const Column1({super.key});

  @override
  State<Column1> createState() => _Column1State();
}

class _Column1State extends State<Column1> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (String value) {
        setState(() {
          title = value;
        });
      },
      decoration: const InputDecoration(
        labelText: "Title",
      ),
    );
  }
}

class Column2 extends StatefulWidget {
  const Column2({super.key});

  @override
  State<Column2> createState() => _Column2State();
}

class _Column2State extends State<Column2> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: TextField(
            onSubmitted: (String value) {
              setState(() {
                amount = value as double;
              });
            },
            decoration: const InputDecoration(
              labelText: "Amount",
            ),
          ),
        ),
      ],
    );
  }
}

class Column3 extends StatefulWidget {
  const Column3({super.key, required this.addExpense});
  final void Function(ExpenseModel) addExpense;
  @override
  State<Column3> createState() => _Column3State();
}

class _Column3State extends State<Column3> {
  List<CategoryExpense> list = CategoryExpense.values;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DropdownButton(
          value: category,
          items: list
              .map<DropdownMenuItem<CategoryExpense>>((CategoryExpense value) {
            return DropdownMenuItem<CategoryExpense>(
              value: value,
              child:
                  Text(value.toString().split('.').elementAt(1).toUpperCase()),
            );
          }).toList(),
          onChanged: (CategoryExpense? value) {
            setState(() {
              category = value ?? CategoryExpense.food;
            });
          },
        ),
        const Spacer(),
        TextButton(onPressed: () {}, child: const Text('cancel')),
        ElevatedButton(
          onPressed: () {
            widget.addExpense(ExpenseModel(
              title: title,
              amount: amount,
              date: date,
              category: category,
            ));
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(),
          child: const Text('Add Expense'),
        ),
      ],
    );
  }
}
