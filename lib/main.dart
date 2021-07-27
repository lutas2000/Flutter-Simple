import 'package:bank_counter_assignment/features/bank/data/repositories/BankRepository.dart';
import 'package:bank_counter_assignment/features/bank/domain/repositories/bank_repository.dart';
import 'package:bank_counter_assignment/features/bank/presentation/pages/bank_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  setUp();
  runApp(MyApp());
}

void setUp() {
  // Dependency Injection
  final GetIt getIt = GetIt.instance;
  getIt.registerLazySingleton<IBankRepository>(() => BankRepository());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bank Counter Assignment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BankPage(),
    );
  }
}
