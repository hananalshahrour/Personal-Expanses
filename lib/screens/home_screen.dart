import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_expanses_app/widgets/chart.dart';
import '../models/transaction_model.dart';
import '../widgets/new_transaction_widget.dart';
import '../widgets/transaction_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showChart = true;
  List<Transaction> _userInput = [
    // Transaction(
    //     amount: 99.99, date: DateTime.now(), id: 't1', title: 'New Shoes'),
    // Transaction(
    //     amount: 16.98, date: DateTime.now(), id: 't2', title: 'Play GYM'),
  ];

  List<Transaction> get _recentTransaction {
    return _userInput.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        date: chosenDate,
        id: DateTime.now().toString());
    setState(() {
      _userInput.add(newTx);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void deleteTransaction(String id) {
    setState(() {
      _userInput.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final dynamic appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Personal Expanses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => startAddNewTransaction(context),)
              ],
            ),
          )
        : AppBar(
            title: Text(
              'Personal Expanses',
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
            actions: [
              IconButton(
                  onPressed: () => startAddNewTransaction(context),
                  icon: Icon(Icons.add)),
            ],
          );
    final pageBody =SafeArea(child: SingleChildScrollView(
      child: Column(
        children: [
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show Chart',style: Theme.of(context).textTheme.titleMedium,),
                Switch.adaptive(
                    activeColor: Colors.amber,
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    }),
              ],
            ),
          if (!isLandscape)
            Container(
                height: (mediaQuery.size.height -
                    appBar.preferredSize.height -
                    mediaQuery.padding.top) *
                    0.3,
                child: Chart(_recentTransaction)),
          if (!isLandscape)
            Container(
                height: (mediaQuery.size.height -
                    appBar.preferredSize.height -
                    mediaQuery.padding.top) *
                    0.7,
                child: TransactionList(_userInput, deleteTransaction)),
          if (isLandscape)
            _showChart
                ? Container(
                height: (mediaQuery.size.height -
                    appBar.preferredSize.height -
                    mediaQuery.padding.top) *
                    0.7,
                child: Chart(_recentTransaction))
                : Container(
                height: (mediaQuery.size.height -
                    appBar.preferredSize.height -
                    mediaQuery.padding.top) *
                    0.7,
                child: TransactionList(_userInput, deleteTransaction)),
        ],
      ),
    )) ;
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    backgroundColor: Colors.amber,
                    onPressed: () => startAddNewTransaction(context),
                    child: Icon(Icons.add),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
  }
}
