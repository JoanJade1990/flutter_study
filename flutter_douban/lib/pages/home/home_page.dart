import 'package:flutter/material.dart';
import 'package:flutterdouban/bean/subject_entity.dart';
import 'package:flutterdouban/constant/constant.dart';
import 'package:flutterdouban/http/API.dart';
import 'package:flutterdouban/http/mock_request.dart';
import 'package:flutterdouban/pages/home/home_app_bar.dart' as myAppBar;
import 'package:flutterdouban/router.dart';
import 'package:flutterdouban/widgets/image/radius_img.dart';
import 'package:flutterdouban/widgets/search_text_field_widget.dart';
import 'package:flutterdouban/widgets/video_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build HomePage');
    return Scaffold(
      body: Center(
        child: Text('主页'),
      ),
    );
  }
}

var _tabs = ['动态', '推荐'];

DefaultTabController getWedget() {
  return DefaultTabController(
    initialIndex: 1,
    length: _tabs.length,
    child: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        //these are the slivers that show up in the "outer" scroll view.
        return <Widget>[
          SliverOverlapAbsorber(
            //This widget takes the overlapping behavior of the SliverAppBar,
            //and redirects it to the SliverOverlapInjector below. If it is
            //missing, then it is possible for the nested "inner" scroll view
            //below to end up under the SliverAppBar even when the inner
            //scroll view thinks it has not been scrolled.
            //This is not necessary if the "headerSliverBuilder" only builds
            //widgets that do not overlap the next sliver.
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            child: myAppBar.SliverAppBar(
              pinned: true,
              //bar悬停
              expandedHeight: 120.0,
              primary: true,
              titleSpacing: 0.0,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  color: Colors.green,
                  child: SearchTextFieldWidget(
                    hintText: '影视作品中你最难忘的离别',
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    onTab: () {
                      Router.push(context, Router.searchPage, '影视作品中你难忘的离别');
                    },
                  ),
                  alignment: Alignment(0, 0),
                ),
              ),
              // The "forceElevated" property causes the SliverAppBar to show
              // a shadow. The "innerBoxIsScrolled" parameter is true when the
              // inner scroll view is scrolled beyond its "zero" point, i.e.
              // when it appears to be scrolled below the SliverAppBar.
              // Without this, there are cases where the shadow would appear
              // or not appear inappropriately, because the SliverAppBar is
              // not actually aware of the precise position of the inner
              // scroll views.
              bottomTextString: _tabs,
              bottom: TabBar(
                //These are the widget to put in each tab in the tab bar.
                tabs: _tabs.map((String name) =>
                    Container(
                      child: Text(
                        name,
                      ),
                      padding: const EdgeInsets.only(bottom: 5),
                    )).toList(),
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        children: _tabs.map((String name) {
          return SliverContainer(
            name: name,
          );
        }).toList(),
      ),
    ),
  );
}

class SliverContainer extends StatefulWidget {
  final String name;

  SliverContainer({Key key, @required this.name}) : super(key: key);

  @override
  _SliverContainerState createState() => _SliverContainerState();
}

class _SliverContainerState extends State<SliverContainer> {
  @override
  void initState() {
    super.initState();
    print('init state${widget.name}');
    //请求动态数据
    if (list == null || list.isEmpty) {
      if (_tabs[0] == widget.name) {
        requestApi();
      } else {
        //请求推荐
        requestApi();
      }
    }
  }

  List<Subject> list;

  void requestApi() async {
    var _request = MockRequest();
    var result = await _request.get(API.TOP_250);
    var resultList = result['subjects'];
    list = resultList.map<Subject>((item) => Subject.fromMap(item)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return getContentSliver(context, list);
  }

  getContentSliver(BuildContext context, List<Subject> list) {
    if (widget.name == _tabs[0]) {
      return _loginContainer(context);
    }
    print('getContentSliver');
    if (list == null || list.length == 0) {
      return Text('暂无数据');
    }
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        // This Builder is needed to provide a BuildContext that is "inside"
        // the NestedScrollView, so that sliverOverlapAbsorberHandleFor() can
        // find the NestedScrollView.
        builder: (BuildContext context) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            // The "controller" and "primary" members should be left
            // unset, so that the NestedScrollView can control this
            // inner scroll view.
            // If the "controller" property is set, then this scroll
            // view will not be associated with the NestedScrollView.
            // The PageStorageKey should be unique to this ScrollView;
            // it allows the list to remember its scroll position when
            // the tab view is not on the screen.
            key: PageStorageKey<String>(widget.name),
            slivers: <Widget>[
              SliverOverlapInjector(
                // This is the flip side of the SliverOverlapAbsorber above.
                handle:
                NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      ((BuildContext context, int index) {
                        return getCommonItem(list, index);
                      }), childCount: list.length)),
            ],
          );
        },
      ),
    );
  }

  double singleLineImgHeight = 180.0;
  double contentVideoHeight = 350.0;

  ///列表的普通单个item
  getCommonItem(List<Subject> items, int index) {
    Subject item = items[index];
    bool showVideo = index == 1 || index == 3;
    return Container(
      height: showVideo ? contentVideoHeight : singleLineImgHeight,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.only(
          left: Constant.MARGIN_LEFT,
          right: Constant.MARGIN_RIGHT,
          top: Constant.MARGIN_RIGHT,
          bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(item.casts[0].avatars.medium),
                backgroundColor: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(item.title),
              ),
              Expanded(
                child: Align(
                  child: Icon(
                    Icons.more_horiz,
                    color: Colors.grey,
                    size: 18.0,
                  ),
                  alignment: Alignment.centerRight,
                ),
              )
            ],
          ),
          Expanded(
              child: Container(
                child: showVideo ? getContentVideo(index) : getItemCenterImg(item),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(
                  Constant.ASSETS_IMG + 'ic_vote.png',
                  width: 25.0,
                  height: 25.0,
                ),
                Image.asset(
                  Constant.ASSETS_IMG +
                      'ic_notification_tv_calendar_comments.png',
                  width: 20.0,
                  height: 20.0,
                ),
                Image.asset(
                  Constant.ASSETS_IMG + 'ic_status_detail_reshare_icon.png',
                  width: 25.0,
                  height: 25.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getItemCenterImg(Subject item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Expanded(
          child: RadiusImg.get(item.images.large, null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    bottomLeft: Radius.circular(5.0)),
              )),
        ),
        Expanded(
          child: RadiusImg.get(item.casts[1].avatars.medium, null, radius: 0.0),
        ),
        Expanded(
          child: RadiusImg.get(item.casts[2].avatars.medium, null,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5.0),
                      bottomRight: Radius.circular(5.0)))),
        )
      ],
    );
  }

  getContentVideo(int index) {
    if(!mounted){
      return Container();
    }
    return VideoWidget(
      index == 1 ? Constant.URL_MP4_DEMO_0 :  Constant.URL_MP4_DEMO_1,
      showProgressBar: false,
    );
  }

}
///动态TAB
_loginContainer(BuildContext context) {
  return Align(
    alignment: Alignment(0.0, 0.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          Constant.ASSETS_IMG + 'ic_new_empty_view_default.png',
          width: 120.0,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 25.0),
          child: Text(
            '登录后查看关注人动态',
            style: TextStyle(fontSize: 16.0, color: Colors.grey),
          ),
        ),
        GestureDetector(
          child: Container(
            child: Text(
              '去登录',
              style: TextStyle(fontSize: 16.0, color: Colors.green),
            ),
            padding: const EdgeInsets.only(
                left: 35.0, right: 35.0, top: 8.0, bottom: 8.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: const BorderRadius.all(Radius.circular(6.0))),
          ),
          onTap: () {
            Router.push(context, Router.searchPage, '搜索笨啦灯');
          },
        )
      ],
    ),
  );
}