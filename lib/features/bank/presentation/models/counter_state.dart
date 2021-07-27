import 'package:bank_counter_assignment/features/bank/domain/entities/counter.dart';
import 'package:bank_counter_assignment/features/bank/presentation/models/task.dart';

/// 用於顯示櫃檯資料、櫃檯處理狀態
class CounterState {
  final Counter counter;
  final List<Task> proceedTasks = [];
  Task? processingTask;

  CounterState({required this.counter});
}
