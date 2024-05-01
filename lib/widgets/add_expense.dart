import 'package:expense_tracker/class/expense.dart';
import 'package:flutter/material.dart';

class AddExpenses extends StatefulWidget {
  const AddExpenses({super.key, required this.editList});

  final Function(
          TextEditingController, TextEditingController, Categorys, DateTime)
      editList;

  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  final _textcontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  Categorys _selectedCategories = Categorys.food;

  @override
  void dispose() {
    _textcontroller.dispose();
    _amountcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void addExpenseToList() {
      final validAmount = double.tryParse(_amountcontroller.text);
      final isVaild = validAmount == null || validAmount <= 0;
      if (isVaild || _textcontroller.text.trim().isEmpty) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            actions: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child:
                    Text('Please Enter a valid Input for the given text field'),
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text('Okay'))
            ],
          ),
        );
      } else {
        widget.editList(_textcontroller, _amountcontroller, _selectedCategories,
            _selectedDate);

        Navigator.pop(context);
      }
    }

    void presentDate() async {
      final now = DateTime.now();
      final firstDate = DateTime(now.year - 1, now.month, now.day);
      final lastDate = now;
      final pickedDate = await showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: firstDate,
          lastDate: lastDate);

      setState(() {
        _selectedDate = pickedDate ?? _selectedDate;
      });
    }

    final keyboardspace = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardspace + 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                maxLength: 50,
                style: TextStyle(
                    color: Theme.of(context).textTheme.titleMedium?.color),
                decoration: const InputDecoration(hintText: "Expense Title"),
                controller: _textcontroller,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                          color:
                              Theme.of(context).textTheme.titleMedium?.color),
                      decoration: const InputDecoration(hintText: "Amount"),
                      keyboardType: TextInputType.number,
                      controller: _amountcontroller,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        formatter.format(_selectedDate),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      IconButton(
                          onPressed: presentDate,
                          icon: const Icon(Icons.calendar_month_outlined))
                    ],
                  ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  DropdownButton(
                    items: Categorys.values
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                                e.toString().toUpperCase().split('.').last)))
                        .toList(),
                    value: _selectedCategories,
                    onChanged: (newvalue) {
                      setState(
                        () {
                          _selectedCategories = newvalue!;
                        },
                      );
                    },
                    style: Theme.of(context).textTheme.titleMedium,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                        // backgroundColor: const Color.fromARGB(255, 199, 227, 240),
                        foregroundColor: Colors.black),
                    child: const Text(
                      "Cancel",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: addExpenseToList,
                    child: const Text(
                      "Save",
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
