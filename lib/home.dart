import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_widgetkit/flutter_widgetkit.dart';
import 'package:study_home_widget/data/widget_date.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              child: TextField(
                controller: textController,
                decoration: const InputDecoration(
                  hintText: "Enter widget text",
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                WidgetKit.setItem(
                    'widgetData',
                    jsonEncode(WidgetData(textController.text)),
                    'group.flutterioswidget');
                WidgetKit.reloadAllTimelines();
              },
              child: const Text("Push to Widget"),
            ),
          ],
        ),
      ),
    );
  }
}
