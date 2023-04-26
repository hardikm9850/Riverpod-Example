
import 'package:flutter_riverpod/flutter_riverpod.dart';


// We create a "provider", which will store a value (here "Hello world").
// By using a provider, this allows us to mock/override the value exposed.
final helloWorldProvider = Provider((ref) => 'Hello World!');

//StateProvider is used for simple value
final stateProvider = StateProvider<String>((ref) => 'State provider');



