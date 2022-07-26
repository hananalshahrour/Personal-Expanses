import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expanses_app/models/transaction_model.dart';
import 'package:personal_expanses_app/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);

  List<Map<String,dynamic>>get groupedTransactionsValues{
     return List.generate(7, (index) {
       //for day or weekday
       final weekDay=DateTime.now().subtract(Duration(days: index));
       //for amount
       var amountTotal=0.0;
       for(int i=0;i<recentTransaction.length;i++){
         if(recentTransaction[i].date.day==weekDay.day&&
         recentTransaction[i].date.month==weekDay.month&&
         recentTransaction[i].date.year==weekDay.year)
           {
             amountTotal+=recentTransaction[i].amount;
           }
       }
       print(weekDay);
       return {
         'day':DateFormat.E().format(weekDay),
         'amount':amountTotal
       } ;
     }).reversed.toList();
   }
   double get totalSpending{
    return groupedTransactionsValues.fold(0.0, (sum, item) {
      return sum+item['amount'];
    });

   }
  @override
  Widget build(BuildContext context) {
    print(groupedTransactionsValues);
    return Card(
      margin: EdgeInsets.all(20),
      elevation: 6,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
             ...groupedTransactionsValues.map((data) {
               return Flexible(
                 fit: FlexFit.tight,
                 child: ChartBar(data['day'],
                     data['amount'],
                     totalSpending==0.0?0.0:(data['amount'] as double)/totalSpending),
               );
             }).toList(),
          ],
        ),
      ),
    );
  }
}
