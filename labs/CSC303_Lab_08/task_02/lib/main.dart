import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceCubit extends Cubit<int> {
  AttendanceCubit() : super(0);
  void markPresent() => emit(state + 1);
  void reset() => emit(0);
}

void main() => runApp(BlocProvider(
  create: (_) => AttendanceCubit(),
  child: const MaterialApp(home: AttendancePage()),
));

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Attendance • Cubit')),
    body: Center(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocBuilder<AttendanceCubit, int>(builder: (_, count) =>
          Text('Present students: $count',
            style: const TextStyle(fontSize: 24))),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: () => context.read<AttendanceCubit>().markPresent(),
          child: const Text('Mark present'),
        ),
        TextButton(
          onPressed: () => context.read<AttendanceCubit>().reset(),
          child: const Text('Reset'),
        ),
      ],
    )),
  );
}
