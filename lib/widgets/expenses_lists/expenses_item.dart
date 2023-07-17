import 'package:flutter/material.dart';
import 'package:pract4/modals/exxpenses.dart';

class ExpensesItem extends StatelessWidget{
const ExpensesItem(this.expensess,{super.key});
  final Expense expensess;
  @override
  Widget build(BuildContext context) {
    return Card(child: 
    Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(expensess.title,
        style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 4),
        Row(children: [
          Text('\$${expensess.amount.toStringAsFixed(2)}'),
          const Spacer(),
          Row(children: [
             Icon(categoryIcons[expensess.category]),
             const SizedBox(width: 8),
            Text(expensess.formattedDate),
          ],)

        ],)
      ],
      )
    ),
    );
  }}