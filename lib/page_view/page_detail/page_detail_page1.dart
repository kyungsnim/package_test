import 'package:flutter/material.dart';
import 'package:package_test/_importer.dart';

class PageDetailPage1 extends StatefulWidget {
  const PageDetailPage1({super.key});

  @override
  State<PageDetailPage1> createState() => _PageDetailPage1State();
}

class _PageDetailPage1State extends State<PageDetailPage1> {
  double _scale = 1.0;

  List<Map<String, List<String>>> data1 = [
    {
      '소인수분해':
      [
        '소수와 약수',
        '소인수분해',
        '소인수분해 1',
      ],
    },
    {
      '최대공약수와 최소공배수':
          [
            '공약수와 공배수',
            '소인수분해와 공약수',
            '공배수와 최소공배수',
            '최대공약수~~~~~~~',
          ]
    },
    {
      '정수와 자연수':
          [
            '양수와 음수',
            '정수와 0'
          ]
    }
  ];
  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      scaleFactor: 1000,
      minScale: 1,
      maxScale: 8.0,
      onInteractionUpdate: (details) {
        setState(() {
          _scale = details.scale;
          print(_scale);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(child: ListView.builder(
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return _buildCell('수와 연산', data1);
              }
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildCell(String title, List<Map<String, List<String>>> datas) {
    return Row(
      children: [
        Flexible(flex: 1,child: Container(
          child: Text(title),
        )),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.green.withOpacity(0.4),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: _scale > 2.0 ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Text('1');
                  },),
                )
              ],
            ) : Text(
              title,
            ),
          ),
        ),
      ],
    );
  }
}
