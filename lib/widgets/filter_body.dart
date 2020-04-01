import 'package:confs_tech/widgets/topic_filter.dart';
import 'package:flutter/material.dart';

class MyTabbedPage extends StatefulWidget {
  const MyTabbedPage({ Key key }) : super(key: key);
  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage> with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Country'),
    Tab(text: 'Topic'),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: myTabs,
        ),
        title: Text('Filter'),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          TopicFilter('country'),
          TopicFilter('topics'),
        ],
      ),
    );
  }
}