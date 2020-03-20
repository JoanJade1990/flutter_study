import 'package:flutter/material.dart';
import 'package:fluttertest/bloc/page/strem_demo_main.dart';
import 'package:fluttertest/utils/util.dart';
class  BlocHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('导航的学习'),),
      body: ListView(
        children: <Widget>[
          getLines('Stream', context: context,ontap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StreamHome(),
                ));
          }),

        ],
      ) ,
    );
  }
}
