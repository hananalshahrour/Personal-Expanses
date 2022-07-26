import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction_model.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions,this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Text(
                'No Transactions Added yet!',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  height:constraints.maxHeight*0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  )),
            ],
          );
        })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                elevation: 6,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                          child: Text('\$ ${transactions[index].amount}')),
                    ),
                  ),
                  title: Text(
                    '${transactions[index].title}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date)),
                  trailing: MediaQuery.of(context).size.width>460?
                      TextButton.icon( onPressed: ()=>deleteTx(transactions[index].id), icon: Icon(Icons.delete,color: Theme.of(context).errorColor ,),
                          label: Text('Delete',style: TextStyle(color:  Theme.of(context).errorColor),),
                      )
                      :IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: ()=>deleteTx(transactions[index].id),
                  ),
                ),
              );
            },
          );
  }
}
