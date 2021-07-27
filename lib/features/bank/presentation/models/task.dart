class Task {
  final int number;
  final int time; // 任務耗時(秒)
  int process = 0; // 已執行時間(秒)

  Task({required this.number, required this.time});
}
