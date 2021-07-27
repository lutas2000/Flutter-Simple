import 'package:bank_counter_assignment/features/bank/data/repositories/BankRepository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test getRandomBank', () async {
    // arrange
    final BankRepository repository = BankRepository();
    // act
    final result = await repository.getRandomBank(5);
    // assert
    // print('banks ${result.counters.map((e) => e.teller.name)}');
    expect(result.counters.length, 5);
    // expect every teller have names
    expect(
        result.counters
            .map((element) => element.teller.name.isNotEmpty)
            .reduce((value, element) => value & element),
        true);
  });
}
