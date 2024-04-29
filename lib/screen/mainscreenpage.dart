import 'package:expense_tracker/class/expense.dart';
import 'package:expense_tracker/widgets/add_expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenseitem.dart';
import 'package:flutter/material.dart';

class ExpenseTrackerMainPage extends StatefulWidget {
  const ExpenseTrackerMainPage({super.key});

  @override
  State<ExpenseTrackerMainPage> createState() => _ExpenseTrackerMainPageState();
}

class _ExpenseTrackerMainPageState extends State<ExpenseTrackerMainPage> {
  final List<Expenses> _expensesList = [
    Expenses(
        expenseAmount: 100,
        expenseCategory: Categorys.work,
        expenseDate: DateTime.now(),
        expenseTitle: 'Mouse'),
    Expenses(
        expenseAmount: 200,
        expenseCategory: Categorys.travel,
        expenseDate: DateTime.now(),
        expenseTitle: 'Bag')
  ];
  void addExpenseToList(
      TextEditingController expenseName,
      TextEditingController expenseAmount,
      Categorys expenseCategory,
      DateTime expenseDate) {
    setState(() {
      Expenses newExpense = Expenses(
          expenseAmount: int.tryParse(expenseAmount.text) ?? 0,
          expenseCategory: expenseCategory,
          expenseDate: expenseDate,
          expenseTitle: expenseName.text);

      _expensesList.add(newExpense);

      expenseAmount.clear();
      expenseName.clear();
    });
  }

  void undoTheList(Expenses expense, int index) {
    setState(() {
      _expensesList.insert(index, expense);
    });
  }

  void removeExpenseFromList(Expenses expense, int index) {
    setState(() {
      _expensesList.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Undo the remove Expense'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              undoTheList(expense, index);
            }),
      ),
    );
  }

  void addExpense() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => AddExpenses(
              editList: addExpenseToList,
            ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent =
        const Center(child: Text('There is NO Expense Added yet'));

    if (_expensesList.isNotEmpty) {
      mainContent = ListView.builder(
          itemCount: _expensesList.length,
          itemBuilder: (ctx, index) => Dismissible(
              background: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color:
                        Theme.of(context).colorScheme.error.withOpacity(0.80)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Icon(Icons.delete),
                    )
                  ],
                ),
              ),
              key: ValueKey(_expensesList[index]),
              onDismissed: (direction) {
                removeExpenseFromList(_expensesList[index], index);
              },
              child: ExpenseInfo(expense: _expensesList[index])));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(onPressed: addExpense, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(children: [
        Chart(expenses: _expensesList),
        Expanded(
          child: mainContent,
        ),
      ]),
    );
  }
}
