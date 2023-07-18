import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pract4/modals/exxpenses.dart';

class NewExpenses extends StatefulWidget {
  const NewExpenses({super.key, required this.onAddExpense});

  final void Function(Expense) onAddExpense;
  @override
  State<StatefulWidget> createState() {
    return _NewExpensesState();
  }
}

class _NewExpensesState extends State<NewExpenses> {
  final _textController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedItem = Category.leisure;

  void _datePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final _pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = _pickedDate;
    });
  }

  void expenseData() {
    final _enteredAmount = double.tryParse(_amountController.text);
    final _invalidAmount = _enteredAmount == null || _enteredAmount <= 0;
    if (_textController.text.trim().isEmpty ||
        _invalidAmount ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid-Input'),
          content: const Text('You Must Have To Enter The Valid Credentials!'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'))
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(Expense(
        title: _textController.text,
        amount: _enteredAmount,
        date: _selectedDate!,
        category: _selectedItem));

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _textController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints){
      final width = constraints.maxWidth;


      return  SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
          child: Column(
            children: [
              if(width >= 600)
              Row(children: [
                 Expanded(
                   child: TextField(
                                 controller: _textController,
                                 maxLength: 50,
                                 decoration: const InputDecoration(
                    label: Text('Title'),
                                 ),
                               ),
                 ),

                 const SizedBox(width: 40),
                  Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text('Amount'),
                      prefixText: '\$',
                    ),
                  ),
                ),
              ],)
              else
              TextField(
                controller: _textController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              if(width >= 600)
              Row(children: [
                 DropdownButton(
                      value: _selectedItem,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toUpperCase())),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedItem = value;
                        });
                      }),
                      const SizedBox(width: 40),
                      Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(_selectedDate == null
                          ? 'DateNotSelected'
                          : formatter.format(_selectedDate!)),
                      IconButton(
                          onPressed: _datePicker,
                          icon: const Icon(Icons.calendar_month))
                    ],
                  ),
                ),
              ],)
              else
              Row(children: [
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text('Amount'),
                      prefixText: '\$',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(_selectedDate == null
                          ? 'DateNotSelected'
                          : formatter.format(_selectedDate!)),
                      IconButton(
                          onPressed: _datePicker,
                          icon: const Icon(Icons.calendar_month))
                    ],
                  ),
                ),
              ]),
              const SizedBox(height: 16),
              if(width >= 600)
              Row(children: [
                const Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        expenseData();
                      },
                      child: const Text('Save-Expense')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'))
              ],)
              else
              Row(
                children: [
                  DropdownButton(
                      value: _selectedItem,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toUpperCase())),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedItem = value;
                        });
                      }),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        expenseData();
                      },
                      child: const Text('Save-Expense')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'))
                ],
              )
            ],
          ),
        ),
      ),
    );
    }
    
    );
    
   
  }
}
