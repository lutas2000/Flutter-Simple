import 'package:bank_counter_assignment/features/bank/domain/entities/bank.dart';
import 'package:bank_counter_assignment/features/bank/domain/entities/counter.dart';
import 'package:bank_counter_assignment/features/bank/domain/entities/teller.dart';
import 'package:bank_counter_assignment/features/bank/domain/repositories/bank_repository.dart';
import 'package:faker/faker.dart';

class BankRepository extends IBankRepository {
  @override
  Future<Bank> getRandomBank(int counterNum) async {
    return createRandomBank(counterNum);
  }

  Bank createRandomBank(int counterNum) {
    final counters = createRandomCounter(counterNum);
    return Bank(counters);
  }

  List<Counter> createRandomCounter(int num) {
    return List.generate(num, (_) => Counter(createRandomTeller())).toList();
  }

  Teller createRandomTeller() {
    String name = Faker().person.name();
    return Teller(name);
  }
}
