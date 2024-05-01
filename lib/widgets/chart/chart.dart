import 'package:expense_tracker/class/expense.dart';
import 'package:expense_tracker/widgets/chart/chart_bar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expenses> expenses;

  List<ExpenseBucket> get buckets => [
        ExpenseBucket.forCategory(expenses, Categorys.food),
        ExpenseBucket.forCategory(expenses, Categorys.lesiure),
        ExpenseBucket.forCategory(expenses, Categorys.travel),
        ExpenseBucket.forCategory(expenses, Categorys.work)
      ];

  double get maxTotalExpense {
    double maxExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalExpense > maxExpense) {
        maxExpense = bucket.totalExpense;
      }
    }

    return maxExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkmode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
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
                for (final bucket in buckets)
                  ChartBar(
                    fill: bucket.totalExpense == 0
                        ? 0
                        : (bucket.totalExpense / maxTotalExpense),
                  )
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcon[bucket.category],
                        color: isDarkmode
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
