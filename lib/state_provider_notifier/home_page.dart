import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

//StateProviderNotifier example

class HomePageSPN extends ConsumerWidget {
  const HomePageSPN({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text(user.name)),
        body: Column(
          children: [
            TextField(
              onChanged: (value) => {
                updateName(ref,value)
              },
            ),
            TextField(
              onChanged: (value) => {
                updateAge(ref,value)
              },
            ),
            Center(
              child: Text(user.age.toString()),
            ),
          ],
        ),
      ),
    );
  }

  updateName(WidgetRef ref, String value) {
    ref.read(userProvider.notifier).update(value);
  }

  updateAge(WidgetRef ref, String value) {
    ref.read(userProvider.notifier).updateAge(value);
  }


}