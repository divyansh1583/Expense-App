import 'package:expense_app/main.dart';
import 'package:expense_app/model/expense_model.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenseList, required this.ondeleteExpense});
  final void Function(ExpenseModel) ondeleteExpense;
  final List<ExpenseModel> expenseList;
  @override
  Widget build(BuildContext context) {
    //list view for rendering list in one go
    return ListView.builder(
      itemCount: expenseList.length,
      itemBuilder: (context, index) {
        var expense = expenseList[index];
        //dismissible for adding swiping effect
        return Dismissible(
          background: Card(
            color: kColorScheme.error,
            margin: Theme.of(context).cardTheme.margin,
          ),
          key: ValueKey(expenseList[index]),
          onDismissed: (direction) => ondeleteExpense(expenseList[index]),
          //Adding card to giveCard type styling provided by flutter
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(expense.title),
                      const SizedBox(height: 8),
                      // const Spacer(),
                      Text('₹ ${expense.amount.toStringAsFixed(2)}'),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(categoryIcons[expense.category]),
                      const SizedBox(width: 8),
                      Text(expense.formattedDate),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
        // child: ListTile(
        //   title: Text(expenseList[index].title),
        //   subtitle: Text('₹ ${expenseList[index].amount.toString()}'),
        //   trailing: SizedBox(
        //     width: 110,
        //     child: Row(
        //       children: [
        //         categoryIcons[expenseList[index].category]!,
        //         const SizedBox(width: 5),
        //         Text(formatter.format(expenseList[index].date)),
        //       ],
        //     ),
        //   ),
        //   tileColor: Colors.purple[100],
        // ),
        // Text(expenseList[index].title);
        // );
      },
    );
  }
}
