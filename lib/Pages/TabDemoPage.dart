import 'package:flutter/material.dart';
import 'package:ovenapp/Pages/TLDescribePage.dart';
import 'package:ovenapp/Pages/TLRecipePage.dart';
import 'package:ovenapp/Pages/TLSectionPage.dart';

class TabDemoPage extends StatefulWidget {
  @override
  _TabDemoPageState createState() => _TabDemoPageState();
}

class _TabDemoPageState extends State<TabDemoPage>
    with SingleTickerProviderStateMixin {
      //AutomaticKeepAliveClientMixin  
  TabController tabController;

  @override
  void initState() {
    super.initState();
    print("@@@ => TabDemoPage.initState() ... ");

    tabController = new TabController(length: 3, vsync: this);
    // tabController.
  }

  @override
  void dispose() {
    super.dispose();
    // _streamController.close();
    print("@@@ TabDemoPage.dispose() ...");
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("@@@ => TabDemoPage.build() ... ");

    return Scaffold(
      appBar: AppBar(
        title: Text('昔日重来 ...'),
        bottom: TabBar(          
          controller: tabController,
          tabs: <Widget>[
            new Tab(text: "说明"),
            new Tab(text: "参数"),
            new Tab(text: "原料"),
          ],
        ),
      ),
      body: TabBarView(controller: tabController, children: <Widget>[
        TLDescribePage(),
        TLSectionPage(),
        TLRecipePage(),
      ]),
       bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 45.0,
          child: Row(
            children: <Widget>[
              RaisedButton(
                onPressed: () {},
                child: Text('保存'),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text('运行'),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text('分享'),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text('删除'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
