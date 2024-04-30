import 'package:expense_tracker/class/expense.dart';
import 'package:flutter/material.dart';

class ExpenseInfo extends StatelessWidget {
  const ExpenseInfo({super.key, required this.expense});
  final Expenses expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.expenseTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  'Amount ${expense.expenseAmount}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(
                      categoryIcon[expense.expenseCategory],
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      expense.formattedDate,
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
