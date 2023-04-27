import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

//StateProvider example

class MyHomePage extends ConsumerWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Riverpod Example')),
        body: Column(
          children: [
            TextField(
              onChanged: (value) => {
                ref.read(stateProvider.notifier).update((state) => value)
              },
            ),
            Center(
              child: Text(ref.watch(stateProvider)),
            ),
          ],
        ),
      ),
    );
  }
}