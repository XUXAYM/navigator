import 'package:flutter/material.dart';

import 'dialogs.dart';
import 'navigation.dart';
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
      navigatorKey: NavigationManager.instance.key,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  final _tabs = const <Widget>[
    HomeContent(index: 0, key: ValueKey(0)),
    HomeContent(index: 1, key: ValueKey(1)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(DemoApp.title),
      ),
      //body: _tabs[_index],
      body: IndexedStack(
        index: _index,
        children: _tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_one_outlined),
            label: 'first',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks_two_outlined),
            label: 'second',
          ),
        ],
        onTap: (index) {
          if (_index != index) {
            setState(() {
              _index = index;
            });
          }
        },
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key, required this.index});

  final int index;

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  int _lastCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Page ${widget.index + 1}'),
            const SizedBox(height: 32),
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
    return await NavigationManager.instance.openCounter(
      DemoApp.title,
      lastCounter: _lastCounter,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final confirmed = await Dialogs.showConfirmDialog(context);
                    print(confirmed);
                  },
                  child: const Text('Show dialog'),
                ),
                const SizedBox(width: 40),
                ElevatedButton(
                  onPressed: () async {
                    final confirmed = await Dialogs.showConfirmModal(context);
                    print(confirmed);
                  },
                  child: const Text('Show modal'),
                ),
              ],
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
