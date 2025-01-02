import 'package:firebase_core/firebase_core.dart';
import 'package:home_widget/home_widget.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _lastTimeStamp = DateTime.now();
  final groupId = 'group.study.home_widget_silent_notification';

  void _incrementCounter() {
    final date = DateTime.now();
    updateHomeWidgetData(date);

    setState(() {
      _lastTimeStamp = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Last time stamp:',
            ),
            Text(
              _lastTimeStamp.toIso8601String(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void updateHomeWidgetData(DateTime date) async {
    try {
      await HomeWidget.setAppGroupId(groupId);

      await HomeWidget.saveWidgetData<String>(
        'lastTimeStamp',
        date.toIso8601String(),
      );

      await HomeWidget.updateWidget(
        iOSName: 'HomeWidgetSilentNotification',
        androidName: 'HomeWidgetSilentNotification',
      );
    } catch (_) {}
  }
}
