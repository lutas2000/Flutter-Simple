import 'dart:async';

import 'package:bank_counter_assignment/features/bank/presentation/bloc/bank/bank_bloc.dart';
import 'package:bank_counter_assignment/features/bank/presentation/models/counter_state.dart';
import 'package:bank_counter_assignment/features/bank/presentation/models/task.dart';
import 'package:bank_counter_assignment/features/bank/presentation/widgets/counter_cell.dart';
import 'package:bank_counter_assignment/features/bank/presentation/widgets/counters_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const counterNum = 6;

class BankPage extends StatefulWidget {
  @override
  _BankPageState createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> {
  final BankBloc _bloc = BankBloc();
  StreamSubscription? _timerSubscription;

  @override
  void dispose() {
    _timerSubscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      // TODO 讓 counterNum 可由 user 輸入
      _bloc.add(GetBankEvent(counterNum: counterNum));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bank Counter')),
      body: BlocProvider<BankBloc>(
        create: (_) => _bloc,
        child: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        children: [
          CountersTitle(),
          Divider(),
          SizedBox(height: 16),
          Expanded(child: _CounterList()),
          SizedBox(height: 32),
          _Panel(),
        ],
      ),
    );
  }
}

class _CounterList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BankBloc, BankState>(builder: (context, state) {
      List<CounterState>? states = state.counterStates;
      return ListView.separated(
        itemBuilder: (context, index) => CounterCell(state: states![index]),
        separatorBuilder: (_, __) => const Divider(),
        itemCount: states?.length ?? 0,
      );
    });
  }
}

class _Panel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BankBloc, BankState>(builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _WaitingQueue(state),
          _TaskButton(state),
        ],
      );
    });
  }
}

class _TaskButton extends StatelessWidget {
  final BankState state;

  const _TaskButton(this.state);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final task = Task(number: state.taskNumber, time: 3);
        context.read<BankBloc>().add(AddTaskEvent(task));
      },
      icon: Icon(Icons.add),
    );
  }
}

class _WaitingQueue extends StatelessWidget {
  final BankState state;

  const _WaitingQueue(this.state);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text('waiting: ${state.waitingList?.length ?? 0}'),
    );
  }
}
