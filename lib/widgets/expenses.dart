import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:pract4/modals/exxpenses.dart';
import 'package:pract4/widgets/chart/chart.dart';
import 'package:pract4/widgets/new_expenses.dart';
import 'package:pract4/widgets/expenses_lists/expenses_list.dart';



class Expenses extends StatefulWidget{
  const Expenses({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ExpenseState();
 
  }
}
class _ExpenseState extends State<Expenses>{
  final List<Expense> _registeredExpenses = [
    Expense(title: 'Flutter-corse', amount: 19.19, date: DateTime.now(), category: Category.work),
    Expense(title: 'cinema', amount: 20.13, date: DateTime.now(), category: Category.leisure),  
  ];

  void _addDialog (){
    showModalBottomSheet(
      isScrollControlled: true,
      context: context, builder: (ctx){
      return  NewExpenses(onAddExpense: _addExpenses);
    });
  }

  void _addExpenses(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void removeExpenses(Expense expensee){
    final expenseIndex = _registeredExpenses.indexOf(expensee);
    setState(() {
      _registeredExpenses.remove(expensee);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
      content: const Text('Expense is Deleted'),
      action: SnackBarAction(label:'Undo',
       onPressed: (){
        setState(() {
          _registeredExpenses.insert(expenseIndex, expensee);
        });
        
       }
       ),

      ));
  }
    
  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(child: Text('No Expense is Added Try to Add Some Expenses'),);
    if(_registeredExpenses.isNotEmpty){
      mainContent =  ExpenseList(
          expenses: _registeredExpenses , 
          onRemoveExpense: removeExpenses,
          
        );
    }
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Expense-Tracker'),
        actions: [
          IconButton(onPressed: _addDialog, icon: const Icon(Icons.add))
        ],
      ),
      
      body: Column(children: [
        Chart(expenses: _registeredExpenses),
        Expanded(
          child: mainContent),
      ]),
    );
  
  }
}