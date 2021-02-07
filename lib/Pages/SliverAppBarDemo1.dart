import 'package:flutter/material.dart';

class SliverAppBarDemo1 extends StatefulWidget {
  @override
  _SliverAppBarDemo1State createState() => _SliverAppBarDemo1State();
}

class _SliverAppBarDemo1State extends State<SliverAppBarDemo1> {
  var _tabs = <String>[
    "Tab 1",
    "Tab 2",
    "Tab 3",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: _tabs.length, // This is the number of tabs.
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  leading: new IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  title: const Text('标题'),
                  centerTitle: false,
                  pinned: true,
                  floating: false,
                  snap: false,
                  primary: true,
                  expandedHeight: 230.0,

                  elevation: 10,
                  //是否显示阴影，直接取值innerBoxIsScrolled，展开不显示阴影，合并后会显示
                  forceElevated: innerBoxIsScrolled,

                  actions: <Widget>[
                    new IconButton(
                      icon: Icon(Icons.more_horiz),
                      onPressed: () {
                        print("更多");
                      },
                    ),
                  ],

                  flexibleSpace: new FlexibleSpaceBar(
                    background: Image.network(
                      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1531798262708&di=53d278a8427f482c5b836fa0e057f4ea&imgtype=0&src=http%3A%2F%2Fh.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F342ac65c103853434cc02dda9f13b07eca80883a.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),

                  bottom: TabBar(
                    tabs: _tabs.map((String name) => Tab(text: name)).toList(),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            // These are the contents of the tab views, below the tabs.
            children: _tabs.map((String name) {
              //SafeArea 适配刘海屏的一个widget
              return SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      key: PageStorageKey<String>(name),
                      slivers: <Widget>[
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(10.0),
                          sliver: SliverFixedExtentList(
                            itemExtent: 50.0, //item高度或宽度，取决于滑动方向
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return ListTile(
                                  title: Text('Item $index'),
                                );
                              },
                              childCount: 30,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
