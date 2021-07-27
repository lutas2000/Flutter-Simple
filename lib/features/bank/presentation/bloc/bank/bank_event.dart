part of 'bank_bloc.dart';

@immutable
abstract class BankEvent {}

class GetBankEvent extends BankEvent {
  final int counterNum;

  GetBankEvent({required this.counterNum});
}

class UpdateBankEvent extends BankEvent {}

class AddTaskEvent extends BankEvent {
  final Task task;

  AddTaskEvent(this.task);
}
