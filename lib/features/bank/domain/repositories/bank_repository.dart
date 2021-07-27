import 'package:bank_counter_assignment/features/bank/domain/entities/bank.dart';

abstract class IBankRepository {
  Future<Bank> getRandomBank(int counterNum);
}
