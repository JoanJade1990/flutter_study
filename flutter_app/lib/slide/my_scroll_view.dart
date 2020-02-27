import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/util.dart';
import 'package:flutter_app/Slide/singleScrollView.dart';
import 'package:flutter_app/Slide/ListView.dart';
import 'package:flutter_app/Slide/custom_scroll.dart';
import 'package:flutter_app/Slide/scroll_controller_main.dart';
import 'package:flutter_app/Slide/sliver_appbar_main.dart';
import 'package:flutter_app/Slide/sliver_persistent.dart';
import 'package:flutter_app/Slide/nested_scroll_main.dart';
class MySlideWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('滑动组件的学习'),),
      body: ListView(
        children: <Widget>[
          getLines('singleSrollView', context: context,ontap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MySingleSrollView(),
                ));
          }),
          getLines('listView', context: context,ontap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyListView(),
                ));
          }),
          getLines('CustomScrollDemoPage', context: context,ontap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomScrollDemoPage(),
                ));
          }),
          getLines('ScrollControllerDemoPage', context: context,ontap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScrollControllerDemoPage(),
                ));
          }),
          getLines('SliverDemo', context: context,ontap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SliverBarDemo(),
                ));
          }),
          getLines('SliverHeaderDemo', context: context,ontap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SliverHeaderDemoPage(),
                ));
          }),
          getLines('NestedScrollView', context: context,ontap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NestedScrollDemoPage(),
                ));
          }),
        ],
      ) ,
    );
  }
}
