import 'package:flutter/material.dart';
import 'package:flutter_app/slide/custom_scroll.dart';
import 'package:flutter_app/slide/listview.dart';
import 'package:flutter_app/slide/my_scroll_view.dart';
import 'package:flutter_app/slide/nested_scroll_main.dart';
import 'package:flutter_app/slide/scroll_controller_main.dart';
import 'package:flutter_app/utils/util.dart';

import 'animation/myAnimation.dart';
import 'layout/HlistViewQianTao.dart';
import 'layout/Vlistview.dart';
import 'layout/dialog.dart';
import 'layout/myColumn.dart';
import 'layout/myGrideView.dart';
import 'layout/myRow.dart';

void main() {
  runApp(MaterialApp(
    title: 'Return Data',
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Study Demo'),
      ),
      body: ListView(
        children: <Widget>[
          getLines("text,button", context: context, ontap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ButtonWidget(),
              )
            );
          }),
          getLines("layout", context: context, ontap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LayoutWidget(),
                )
            );
          }),
          getLines("跳转", context: context, ontap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectionScreen(),
                )
            );
          }),
          getLines("滑动组件的学习", context: context, ontap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MySlideWidget(),
                )
            );
          }),getLines('弹窗和提示', context: context,ontap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PromptPageDemo(),
                ));
          }),getLines('竖向ListView', context: context,ontap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyVerticallylistview(),
                ));
          }),getLines('横向listView嵌套', context: context,ontap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Mylist(),
                ));
          }),getLines('grideView', context: context,ontap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyGridView2(),
                ));
          }),getLines('Row布局', context: context,ontap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyRow(),
                ));
          }),getLines('Column布局', context: context,ontap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyColumn(),
                ));
          }),getLines('animation动画', context: context,ontap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnimationWidget(),
                ));
          }),

        ],
      ),
      /*body: Center(
//          child: SelectionButton()
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SelectionButton(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LayoutButton(),
          )

        ],
      ),
    ),*/
    );
  }
  
}

class SelectionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        _navigateAndDisplaySelection(context);
      },
      child: Text('Pick an option, any option!'),
    );
  }

  // A method that launches the SelectionScreen and awaits the result from
  // Navigator.pop!
  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that will complete after we call
    // Navigator.pop on the Selection Screen!
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectionScreen()),
    );

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result!
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
  }
}
class TextButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        _gotoText(context);
      },
      child: Text('go to Button'),
    );
  }

  // A method that launches the SelectionScreen and awaits the result from
  // Navigator.pop!
  _gotoText(BuildContext context) async {
    // Navigator.push returns a Future that will complete after we call
    // Navigator.pop on the Selection Screen!
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ButtonWidget()),
    );

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result!
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
  }
}

class LayoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        _gotoLayout(context);
      },
      child: Text('go to layout'),
    );
  }

  // A method that launches the SelectionScreen and awaits the result from
  // Navigator.pop!
  _gotoLayout(BuildContext context) async {
    // Navigator.push returns a Future that will complete after we call
    // Navigator.pop on the Selection Screen!
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LayoutWidget()),
    );

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result!
//    Scaffold.of(context)
//      ..removeCurrentSnackBar()
//      ..showSnackBar(SnackBar(content: Text("$result")));
  }
}

class SelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick an option'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  // Close the screen and return "Yes!" as the result
                  Navigator.pop(context, 'Yes!');
                },
                child: Text('Yes!'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  // Close the screen and return "Nope!" as the result
                  Navigator.pop(context, 'No.');
                },
                child: Text('No.'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('button and text'),
      ),
      body: Container(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    child: RaisedButton(
                      onPressed: () {},
                      color: Colors.yellow,
                      disabledTextColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      elevation: 20.0,
                      //下方阴影
                      splashColor: Colors.green,
                      //没设置highlightColor时才生效，点击按钮时逐步颜色变化
                      highlightColor: Colors.red,
                      highlightElevation: 1.0,
                      child: Text("Raised Button"),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    colorBrightness: Brightness.dark,
                    color: Colors.deepPurpleAccent,
                    splashColor: Colors.green,
                    highlightColor: Colors.red,
                    child: Text("FlatButton Button"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(20.0),
                            right: Radius.circular(1.0))),
                  ),
                ],
              ),
              //http://docs.flutter.kim/material/RaisedButton-class.html
              MaterialButton(
                minWidth: 250.0,
                onPressed: () {},
                colorBrightness: Brightness.dark,
                color: Colors.deepPurpleAccent,
                elevation: 20.0,
                splashColor: Colors.green,
                //highlightColor: Colors.red,
                highlightElevation: 1.0,
                child: Text("MaterialButton Button"),
              ),

              OutlineButton(
                onPressed: () {},
                borderSide: BorderSide(width: 5.0, color: Colors.deepPurpleAccent),
                color: Colors.deepPurpleAccent,
                highlightedBorderColor: Colors.purple,
                splashColor: Colors.green,
                //highlightColor: Colors.red,
                child: Text("OutlineButton Button"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.0), bottom: Radius.circular(10.0))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,//MainAxisAlignment（主轴）就是与当前控件方向一致的轴，而CrossAxisAlignment（交叉轴）就是与当前控件方向垂直的轴
                children: <Widget>[
                  FloatingActionButton(
                      backgroundColor: Colors.orange,
                      child: Icon(
                        Icons.mic,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      onPressed: () {}),
                  IconButton(
                      color: Colors.purple,
                      splashColor: Colors.yellow,
                      // highlightColor: Colors.red,
                      icon: Icon(
                        Icons.build,
                        size: 40.0,
                      ),
                      onPressed: () {}),
                ],
              ),
              Text(
                "我的flutter demo,一行展示，啊啊啊啊啊啊啊啊啊啊啊啊",
                textAlign: TextAlign.center,
                textDirection: TextDirection.ltr,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20.0,
                    decoration: TextDecoration.underline,
                    //横线，可设置顶部，底部
                    decorationColor: Colors.green,
                    decorationStyle: TextDecorationStyle.solid //底部线样式
                ),
              ),
              new Text(
                'inherit: 为 false 的时候不显示',
                style: new TextStyle(
                  inherit: true,
                ),
              ),
              new Text(
                'color/fontSize: 字体颜色，字号等',
                style: new TextStyle(
                  color: Color.fromARGB(255, 150, 150, 150),
                  fontSize: 22.0,
                ),
              ),
              new Text(
                'fontWeight: 字重',
                style: new TextStyle(fontWeight: FontWeight.w700),
              ),
              new Text(
                'fontStyle: FontStyle.italic 斜体',
                style: new TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
              new Text(
                'letterSpacing: 字符间距',
                style: new TextStyle(
                  letterSpacing: 10.0,
                  // wordSpacing: 15.0
                ),
              ),
              new Text(
                'wordSpacing: 字或单词间距',
                style: new TextStyle(
                  // letterSpacing: 10.0,
                    wordSpacing: 15.0),
              ),
              new Text(
                'textBaseline:这一行的值为TextBaseline.alphabetic',
                style: new TextStyle(textBaseline: TextBaseline.alphabetic),
              ),
              new Text(
                'textBaseline:这一行的值为TextBaseline.ideographic',
                style: new TextStyle(textBaseline: TextBaseline.ideographic),
              ),
              new Text('height: 用在Text控件上的时候，会乘以fontSize做为行高,所以这个值不能设置过大',
                  style: new TextStyle(
                    height: 1.0,
                  )),
              new Text('decoration: TextDecoration.overline 上划线',
                  style: new TextStyle(
                      decoration: TextDecoration.overline,
                      decorationStyle: TextDecorationStyle.wavy)),
              new Text('decoration: TextDecoration.lineThrough 删除线',
                  style: new TextStyle(
                      decoration: TextDecoration.lineThrough,
                      decorationStyle: TextDecorationStyle.dashed)),
              new Text('decoration: TextDecoration.underline 下划线',
                  style: new TextStyle(
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.dotted)),
            ],
          )),
    );
  }
}

class LayoutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Grid"),
      ),
      body: new Center(
        child: buildGrid(),
      ),
    );
  }

  List<Container> _buildGridTileList(int count) {
    return new List<Container>.generate(
        count, (int index) => Container(
          child: Stack(
            children: <Widget>[
              Container(
                  child: new Image.asset(
                      'images/ic_list.png')),
              Positioned(
                //可设置以左，右，顶部，底部为基准
                  top: 0.0,
                  right: 0.0,
                  left: 0.0,
                  child: Container(
                    height: 20.0,
                    color: Colors.black45,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text("第${index + 1}张图片"),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }

  Widget buildGrid() {
    return new GridView.extent(
        maxCrossAxisExtent: 150.0,
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: _buildGridTileList(30));
  }

}