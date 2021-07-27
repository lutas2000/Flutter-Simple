import 'package:bank_counter_assignment/features/bank/presentation/models/counter_state.dart';
import 'package:flutter/material.dart';

class CounterCell extends StatelessWidget {
  final CounterState state;

  const CounterCell({required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text('${state.counter.teller.name}')),
        Expanded(child: Text(state.processingTask?.number.toString() ?? '')),
        Expanded(
            child: Text(state.proceedTasks.map((e) => e.number).join(', '))),
      ],
    );
  }
}
