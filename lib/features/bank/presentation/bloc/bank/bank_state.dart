part of 'bank_bloc.dart';

@immutable
abstract class BankState {
  final List<CounterState>? counterStates;
  final List<Task>? waitingList;
  final int taskNumber;

  BankState({this.counterStates, this.waitingList, required this.taskNumber});
}

class InitialBankState extends BankState {
  InitialBankState() : super(taskNumber: 0);
}

class ReadyBankState extends BankState {
  ReadyBankState({List<CounterState>? counterStates})
      : super(counterStates: counterStates, taskNumber: 0);
}

class RunningBankState extends BankState {
  RunningBankState({
    List<CounterState>? counterStates,
    List<Task>? waitingList,
    required int taskNumber,
  }) : super(
          counterStates: counterStates,
          waitingList: waitingList,
          taskNumber: taskNumber,
        );
}

class IdleBankState extends BankState {
  IdleBankState({
    List<CounterState>? counterStates,
    List<Task>? waitingList,
    required int taskNumber,
  }) : super(
          counterStates: counterStates,
          waitingList: waitingList,
          taskNumber: taskNumber,
        );
}
