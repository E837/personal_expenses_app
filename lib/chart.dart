import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'chart_bar.dart';
import 'models/transactions_list.dart';
import 'models/transaction.dart';

class Chart extends StatelessWidget {
  List<String> get weekDay {
    final List<String> days = [];
    for (int i = 0; i < 7; i++) {
      days.add(
          DateFormat.E().format(DateTime.now().subtract(Duration(days: i))));
    }
    return days;
  }

  List<Transaction> get recentExpenses {
    return sampleData
        .where((thisTx) =>
            thisTx.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  double get totalExpensesOfWeek {
    return recentExpenses.fold(0.0, (sum, thisTx) {
      return sum + thisTx.amount;
    });
  }

  double thisDayExpenses(int index) {
    List<Transaction> todayTransactions = recentExpenses
        .where((thisTx) =>
            DateTime.now().subtract(Duration(days: index)).day ==
            thisTx.date.day)
        .toList();
    final double sumOfTodayExpenses =
        todayTransactions.fold(0.0, (sum, thisTx) => sum + thisTx.amount);
    return sumOfTodayExpenses;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              7,
              (index) => Expanded(
                child: ChartBar(
                  dayTotalAmount: thisDayExpenses(index),
                  weekDay: weekDay[index],
                  percentage: totalExpensesOfWeek == 0
                      ? 0
                      : thisDayExpenses(index) / totalExpensesOfWeek,
                ),
              ),
            ).reversed.toList(),
          ),
        ),
        elevation: 8,
        // color: Colors.purple,
      ),
    );
  }
}
