import 'package:expense_app/widegts/expense_cards.dart';
import 'package:expense_app/model/expense_model.dart';
import 'package:expense_app/screen/add_screen.dart';
import 'package:expense_app/widegts/charts/chart.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ExpenseModel> expenseList = [
    ExpenseModel(
      title: "Udemy Courses",
      amount: 998,
      date: DateTime.now(),
      category: CategoryExpense.work,
    ),
    ExpenseModel(
      title: "Goa Trip",
      amount: 20000,
      date: DateTime.now(),
      category: CategoryExpense.travel,
    ),
  ];

  void addExpense(ExpenseModel value) {
    setState(() {
      expenseList.add(value);
    });
  }

  void deleteExpense(ExpenseModel value) {
    final deletedIndex = expenseList.indexOf(value);

    setState(() {
      expenseList.remove(value);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 4),
      content: const Text('Expense Deleted!'),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          setState(() {
            expenseList.insert(deletedIndex, value);
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // print(MediaQuery.of(context).size.height);
    Widget mainContent = expenseList.isEmpty
        ? const Center(
            child: Text(
            'No expense was found Try adding a new one.',
            // style: TextStyle(color: Colors.white.withOpacity(0.5)),
          ))
        : ExpensesList(
            expenseList: expenseList,
            ondeleteExpense: deleteExpense,
          );
    return Scaffold(
        appBar: AppBar(
          title: const Text('Expense App'),
          // backgroundColor: const Color.fromARGB(255, 55, 21, 114),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Add Expense',
              //Add modal sheet here by directly calling new expense here
              onPressed: () {
                // showModalBottomSheet(
                //     useSafeArea: true,
                //     isScrollControlled: true,
                //     context: context,
                //     builder: (context) => AddScreen(addExpense: addExpense));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddScreen(addExpense: addExpense)),
                );
              },
            ),
          ],
        ),
        body: width < 600
            ? Column(
                children: [
                  Chart(expenses: expenseList),
                  Expanded(
                    child: mainContent,
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(expenses: expenseList)),
                  Expanded(
                    child: mainContent,
                  ),
                ],
              ));
  }
}
