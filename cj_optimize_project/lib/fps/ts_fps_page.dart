/*
 * @Author: dvlproad
 * @Date: 2024-10-28 23:16:51
 * @LastEditors: dvlproad
 * @LastEditTime: 2024-10-29 01:17:37
 * @Description: 
 */
import 'package:flutter/material.dart';

class TSOptimizeFPSPage extends StatefulWidget {
  const TSOptimizeFPSPage({super.key});

  @override
  State<TSOptimizeFPSPage> createState() => _TSOptimizeFPSPageState();
}

class _TSOptimizeFPSPageState extends State<TSOptimizeFPSPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FPS"),
      ),
      body: buildList(context),
    );
  }

  // imagesNames = @["cqts_1.jpg",
  //                                        "cqts_2.jpg",
  //                                        @"cqts_3.jpg",
  //                                        @"cqts_4.jpg",
  //                                        @"cqts_5.jpg",
  //                                        @"cqts_6.jpg",
  //                                        @"cqts_7.jpg",
  //                                        @"cqts_8.jpg",
  //                                        @"cqts_9.jpg",
  //                                        @"cqts_10.jpg",
  //                                        @"cqts_long_horizontal_1.jpg",
  //                                        @"cqts_long_vertical_1.jpg",
  //   ];
  Widget buildList(BuildContext context) {
    return ListView.builder(
      itemCount: 1000,
      itemBuilder: (context, index) {
        preBuildItem(index); // 模拟耗时操作，例如使用延时

        int imageIndex = index % 10;
        String imageName = "assets/images/cqts_${imageIndex + 1}.jpg";
        return Container(
          color: index % 2 == 0 ? Colors.red : Colors.blue,
          child: Row(
            children: [
              JankText("Item $index"),
              Image(
                image: AssetImage(imageName),
                width: 100,
                height: 100,
              ),
            ],
          ),
        );
      },
    );
  }

  void preBuildItem(int index) {
    int result = 0;
    for (var i = 0; i < 100000000; i++) {
      result += i;
    }
    Text("$result");
  }
}

class JankText extends StatelessWidget {
  final String data;
  const JankText(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int result = 0;
    for (var i = 0; i < 1000000; i++) {
      result += i;
    }
    return Text("$result");
  }
}
