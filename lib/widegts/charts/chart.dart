import 'package:expense_app/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<ExpenseModel> expenses;

  List<ExpenseBucket> get buckets {
    List<ExpenseBucket> sortedBuckets = [
      ExpenseBucket.forCategory(expenses, CategoryExpense.food),
      ExpenseBucket.forCategory(expenses, CategoryExpense.leisure),
      ExpenseBucket.forCategory(expenses, CategoryExpense.travel),
      ExpenseBucket.forCategory(expenses, CategoryExpense.work),
    ];

    // Sort the buckets in descending order based on expenses amount
    sortedBuckets.sort((a, b) => b.total.compareTo(a.total));

    return sortedBuckets;
  }

  //getter function to get max amount spend amoung categories
  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.total > maxTotalExpense) {
        maxTotalExpense = bucket.total;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    //variable to find if dark mode on or not?
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.5),
            Theme.of(context).colorScheme.primary.withOpacity(0.2)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets) // alternative to map()
                  ChartBar(
                    fill:
                        bucket.total == 0 ? 0 : bucket.total / maxTotalExpense,
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcons[bucket.category],
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
