import 'dart:async';
import 'dart:collection';

import 'package:bank_counter_assignment/features/bank/domain/repositories/bank_repository.dart';
import 'package:bank_counter_assignment/features/bank/presentation/models/counter_state.dart';
import 'package:bank_counter_assignment/features/bank/presentation/models/task.dart';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'bank_event.dart';
part 'bank_state.dart';

// TODO write unit test
class BankBloc extends Bloc<BankEvent, BankState> {
  BankBloc() : super(InitialBankState());

  final repository = GetIt.instance.get<IBankRepository>();
  StreamSubscription? _timerSubscription;
  Queue<Task> _waitingQueue = Queue();
  int _taskNumber = 0;

  @override
  Future<void> close() {
    _timerSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<BankState> mapEventToState(BankEvent event) async* {
    if (event is GetBankEvent) {
      yield* _mapGetBankEvent(event);
    } else if (event is AddTaskEvent) {
      _waitingQueue.add(event.task);
      _taskNumber++;
      if (state is ReadyBankState) {
        _timerSubscription =
            Stream.periodic(Duration(seconds: 1)).listen((event) {
          add(UpdateBankEvent());
        });
      }
      yield _createRunningState();
    } else if (event is UpdateBankEvent) {
      yield* _mapUpdateBankEvent();
    }
  }

  Stream<BankState> _mapGetBankEvent(GetBankEvent event) async* {
    final bank = await repository.getRandomBank(event.counterNum);
    final counterStates =
        bank.counters.map((counter) => CounterState(counter: counter)).toList();
    yield ReadyBankState(counterStates: counterStates);
  }

  Stream<BankState> _mapUpdateBankEvent() async* {
    state.counterStates?.forEach((element) {
      final processingTask = element.processingTask;
      if (processingTask != null) {
        if (processingTask.process >= processingTask.time) {
          element.proceedTasks.add(processingTask);
          element.processingTask = null;
        } else {
          processingTask.process++;
        }
      } else if (_waitingQueue.isNotEmpty) {
        final task = _waitingQueue.removeFirst();
        element.processingTask = task;
      }
    });

    yield _createRunningState();
  }

  RunningBankState _createRunningState() {
    return RunningBankState(
      taskNumber: _taskNumber,
      waitingList: _waitingQueue.toList(),
      counterStates: state.counterStates,
    );
  }
}
