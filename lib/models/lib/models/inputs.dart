import 'package:flutter/material.dart';

/// 실제 좌우에 배치될 리스트 데이터 영역
class BoardListsData {
  final String? title;
  Widget? header;
  Color? headerBackgroundColor;
  Color? footerBackgroundColor;
  Widget? footer;
  final List<Widget> items;
  Color? backgroundColor;
  double width;
  BoardListsData({
    this.title,
    this.header,
    this.footer,
    required this.items,
    this.footerBackgroundColor = Colors.blue,
    this.headerBackgroundColor = Colors.green,
    this.backgroundColor = Colors.purple,
    this.width = 500,
  }) {
    // footer = footer ??
    //     Container(
    //       padding: const EdgeInsets.only(left: 15),
    //       height: 45,
    //       width: 300,
    //       color: footerBackgroundColor,
    //       child:const Row(
    //         children:  [
    //           Icon(
    //             Icons.add,
    //             color: Colors.black,
    //             size: 22,
    //           ),
    //           SizedBox(
    //             width: 10,
    //           ),
    //           Text(
    //             'NEW',
    //             style: TextStyle(
    //                 color: Colors.black,
    //                 fontSize: 19,
    //                 fontWeight: FontWeight.bold),
    //           ),
    //         ],
    //       ),
    //     );
    header = header ?? Container();
        // Container(
        //   width: 250,
        //   color: headerBackgroundColor,
        //   padding: const EdgeInsets.only(left: 0, bottom: 12, top: 12),
        //   alignment: Alignment.centerLeft,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text(
        //         'dasasdsdasda',
        //         style: const TextStyle(
        //             fontSize: 20,
        //             color: Colors.blue,
        //             fontWeight: FontWeight.bold),
        //       ),
        //       GestureDetector(
        //         child: const SizedBox(
        //             // padding: const EdgeInsets.all(5),
        //             child:  Icon(Icons.more_vert)),
        //       ),
        //     ],
        //   ),
        // );
  }
}

class ScrollConfig {
  double offset;
  Duration duration;
  Curve curve;

  ScrollConfig({
    required this.offset,
    required this.duration,
    required this.curve,
  });
}
