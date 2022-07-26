import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptiveButton extends StatelessWidget {
  final String text;
  final Function handler;


  AdaptiveButton({required this.text,required this.handler});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS?CupertinoButton(child: Text(
      text,
      style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold),
    ), onPressed: ()=>handler,):TextButton(
        onPressed: ()=> handler,
        child: Text(
          text,
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ));
  }
}
