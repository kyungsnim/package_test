import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';

class PreloadPageViewDemo extends StatefulWidget {
  PreloadPageViewDemo({Key? key}) : super(key: key);

  @override
  _PreloadPageViewState createState() => _PreloadPageViewState();
}

class _PreloadPageViewState extends State<PreloadPageViewDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("PreloadPageView Demo"),
        ),
        body: Container(
            child: PreloadPageView.builder(
              preloadPagesCount: 5,
              itemBuilder: (BuildContext context, int position) =>
                  DemoPage(position),
              controller: PreloadPageController(initialPage: 1),
              onPageChanged: (int position) {
                print('page changed. current: $position');
              },
            )));
  }
}

class DemoPage extends StatelessWidget {
  DemoPage(this.index);
  final int index;

  @override
  Widget build(BuildContext context) {
    print('Page loaded: $index}');

    return Center(
      child: Text(
        'Page $index',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}