import 'package:flutter/material.dart';
import 'package:flutter_hello_world/providers.dart';
import 'package:flutter_hello_world/state_provider/home_page.dart';
import 'package:flutter_hello_world/state_provider_notifier/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  // We need to wrap the entire application in a "ProviderScope" widget.
  // This is where the state of our providers will be stored.

  //Providers are fully immutable.
  // Declaring a provider is no different from declaring a function, and providers are testable and maintainable.
  //runApp(const ProviderScope(child: MyApp()));


  runApp(const ProviderScope(child: HomePageSPN()));

}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  // here, entire widget tree will rebuild when provider value change

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String value = ref.watch(helloWorldProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Riverpod Example')),
        body: Center(
          child: Text(value),
        ),
      ),
    );
  }
}

class MyAppWithConsumerBuilder extends StatelessWidget {
  const MyAppWithConsumerBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Consumer(
        builder: (context,ref,child) {
          return Scaffold(
            appBar: AppBar(title: const Text('Riverpod Example')),
            body: Center(
              child: Text(ref.watch(helloWorldProvider)),
            ),
          );
        }
      ),
    );
  }
}


