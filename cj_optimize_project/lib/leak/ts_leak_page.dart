/*
 * @Author: dvlproad
 * @Date: 2024-10-28 23:16:51
 * @LastEditors: dvlproad
 * @LastEditTime: 2024-10-28 23:37:14
 * @Description: 
 */
import 'package:flutter/material.dart';

class TSLeakPage extends StatefulWidget {
  const TSLeakPage({super.key});

  @override
  State<TSLeakPage> createState() => _TSLeakPageState();
}

class _TSLeakPageState extends State<TSLeakPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FPS"),
      ),
      body: buildList(context),
    );
  }

  Widget buildList(BuildContext context) {
    return ListView.builder(
      itemCount: 1000, // 假设我们有100个列表项
      itemBuilder: (context, index) {
        // 模拟耗时操作，例如使用延时
        preBuildItem(index);

        // 返回列表项
        return ListTile(
          title: Text('Item $index'),
        );
      },
    );
  }

  void preBuildItem(int index) {
    // 模拟耗时操作，这里我们使用一个简单的延时
    // 在实际应用中，这可能是一个复杂的计算或者一个网络请求
    Future.delayed(Duration(milliseconds: 50)).then((value) {
      // 这里实际上不会影响列表构建，因为UI构建和异步操作是分离的
      // 这个延时只是为了演示，实际开发中不应该在UI线程中执行耗时操作
    });
  }
}
