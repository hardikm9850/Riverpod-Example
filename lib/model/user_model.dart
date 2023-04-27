import 'package:flutter_riverpod/flutter_riverpod.dart';

class User {
  String name;
  int age;

  User({required this.name, required this.age});

  User copyWith(
    String? name,
    int? age,
  ) {
    return User(
      name : name ?? this.name,
      age : age ?? this.age,
    );
  }
}

class UserNotifier extends StateNotifier<User> {
  UserNotifier(super.state);

  void update(String name) {
    state = state.copyWith(name, state.age);
  }

  void updateAge(String age) {
    state.copyWith(state.name, int.parse(age));
  }
}
