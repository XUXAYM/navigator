import 'package:flutter/material.dart';

import 'routes.dart';

void main() {
  runApp(const DemoApp());
}

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  static const String title = 'Push & Pop';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RouteNames.initialRoute,
      routes: RoutesBuilder.routes,
      // onGenerateRoute: RoutesBuilder.onGenerateRoute,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _lastCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Push the button to see Counter:',
            ),
            Text('Last counter: $_lastCounter'),
            ElevatedButton(
              onPressed: () async {
                final lastCounter =
                    await _onOpenCounter(context) as int? ?? _lastCounter;
                setState(() {
                  _lastCounter = lastCounter;
                });
              },
              child: const Text('Open Counter'),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _onOpenCounter(BuildContext context) async {
    return await Navigator.pushNamed(
      context,
      RouteNames.counter,
      arguments: _lastCounter,
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({
    super.key,
    required this.title,
    required this.lastCounter,
  });

  final String title;
  final int lastCounter;

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _counter = widget.lastCounter;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: _incrementCounter,
              child: const Icon(Icons.add),
            ),
            ElevatedButton(
              onPressed: _onGoBack,
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _onGoBack() {
    Navigator.pop(context, _counter);
    // Navigator.of(context).pop();
  }
}
