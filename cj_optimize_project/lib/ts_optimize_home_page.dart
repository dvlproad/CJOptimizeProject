import 'package:flutter/material.dart';

import 'fps/ts_fps_page.dart';
import 'leak/ts_leak_page.dart';

class TSOptimizeHomePage extends StatefulWidget {
  const TSOptimizeHomePage({Key? key}) : super(key: key);

  @override
  State<TSOptimizeHomePage> createState() => _TSOptimizeHomePageState();
}

class _TSOptimizeHomePageState extends State<TSOptimizeHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("检测Demo"),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TSOptimizeFPSPage()));
            },
            child: const Text("FPS"),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TSLeakPage()));
            },
            child: const Text("Leak"),
          ),
        ],
      ),
    );
  }
}
