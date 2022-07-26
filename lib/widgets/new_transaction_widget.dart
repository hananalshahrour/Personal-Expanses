import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:personal_expanses_app/widgets/adaptive_button_widget.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  //first method
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? selectedDate;

  void submitData() {
    if(amountController.text.isEmpty){
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate==null) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount,selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom+10),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                // onChanged: (value){
                //   titleInput=value;
                // },
                controller: titleController,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                // onChanged: (value){
                //   amountInput=value;
                // },
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        selectedDate==null? 'No Date Chosen!': "Picked Date ${DateFormat.yMd().format(selectedDate!)}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(onPressed:_presentDatePicker , child: Text('Choose Date',style: TextStyle(fontWeight: FontWeight.bold),))
                    //AdaptiveButton(text: 'Choose Date', handler:()=> _presentDatePicker()),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // print(titleInput);
                  // print(amountInput);
                  //print(titleController.text);
                  submitData();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Add Transaction',
                    //style: TextStyle(color: Colors.purple),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
