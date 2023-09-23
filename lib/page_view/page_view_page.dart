import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:package_test/_importer.dart';

class PageViewPage extends StatefulWidget {
  PageViewPage({super.key});

  @override
  State<PageViewPage> createState() => _PageViewPageState();
}

class _PageViewPageState extends State<PageViewPage> {
  late PageController pageController;

  List<Widget> pages = [
    PageDetailPage1(),
    Container(
      color: Colors.green,
      child: Center(child: Text('page 2', style: TextStyle(color: Colors.white))),
    ),
    Container(
      color: Colors.red,
      child: Center(child: Text('page 3', style: TextStyle(color: Colors.white))),
    ),
    Container(
      color: Colors.purple,
      child: Center(child: Text('page 4', style: TextStyle(color: Colors.white))),
    ),
    Container(
      color: Colors.orange,
      child: Center(child: Text('page 5', style: TextStyle(color: Colors.white))),
    ),
  ];

  int _nowPage = 0;

  @override
  Widget build(BuildContext context) {
    pageController = PageController(viewportFraction: _nowPage == 0 ? 1 : 0.5);
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'previous',
            child: Icon(Icons.arrow_back_ios_new),
            onPressed: () => setState(() {
              pageController.animateToPage(_nowPage - 1, duration: Duration(seconds: 1), curve: Curves.ease);
              print('previous : $_nowPage');
            }),
          ),
          FloatingActionButton(
            heroTag: 'next',
            child: Icon(Icons.arrow_forward_ios),
            onPressed: () => setState(() {
              pageController.animateToPage(_nowPage + 1, duration: Duration(seconds: 1), curve: Curves.ease);
              print('next : $_nowPage');
            }),
          )
        ],
      ),
      body: LayoutBuilder(builder: (context, constrains) {
        return PageView.builder(
          physics: _nowPage == 0 ? NeverScrollableScrollPhysics() : ScrollPhysics(),
          padEnds: false,
          clipBehavior: Clip.antiAlias,
          controller: pageController,
          itemCount: pages.length,
          onPageChanged: (int page) {
            setState(() {
              _nowPage = page;
              print('onPageChanged : $_nowPage');
            });
          },
          dragStartBehavior: DragStartBehavior.start,
          itemBuilder: (context, index) {
            // return your view for pageview
            return pages[index];
          },
        );
      }),
    );
  }
}
