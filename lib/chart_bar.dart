import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double dayTotalAmount;
  final String weekDay;
  final double percentage;

  ChartBar({
    required this.dayTotalAmount,
    required this.weekDay,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // width: 30,
          height: 20,
          child: FittedBox(
            child: Text('\$${dayTotalAmount.toString()}'),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 80,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10)),
              ),
              Container(
                child: FractionallySizedBox(
                  heightFactor: percentage,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.amber,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(weekDay),
      ],
    );
  }
}
