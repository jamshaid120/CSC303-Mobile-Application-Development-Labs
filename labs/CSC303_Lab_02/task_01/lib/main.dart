import 'package:flutter/material.dart';

String resultFor(double a, double m, double f) {
  final score = a + m + f;
  if (score >= 85) return 'A';
  if (score >= 70) return 'B';
  if (score >= 60) return 'C';
  if (score >= 50) return 'D';
  return 'F';
}

void main() => runApp(const MaterialApp(home: GradeDemo()));

class GradeDemo extends StatefulWidget {
  const GradeDemo({super.key});
  @override
  State<GradeDemo> createState() => _GradeDemoState();
}

class _GradeDemoState extends State<GradeDemo> {
  double assignment = 20, midterm = 18, finalExam = 42;

  @override
  Widget build(BuildContext context) {
    final score = assignment + midterm + finalExam;
    return Scaffold(
      appBar: AppBar(title: const Text('Dart grade analyzer')),
      body: ListView(padding: const EdgeInsets.all(18), children: [
        for (final item in [
          ('Assignment /25', assignment, 25.0),
          ('Midterm /25', midterm, 25.0),
          ('Final /50', finalExam, 50.0),
        ])
          Column(children: [
            Text('${item.$1}: ${item.$2.toStringAsFixed(0)}'),
            Slider(
              value: item.$2, max: item.$3,
              onChanged: (v) => setState(() {
                if (item.$1.startsWith('Assignment')) assignment = v;
                if (item.$1.startsWith('Midterm')) midterm = v;
                if (item.$1.startsWith('Final')) finalExam = v;
              }),
            ),
          ]),
        Card(child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text('Total: ${score.toStringAsFixed(0)}/100  '
              'Grade: ${resultFor(assignment, midterm, finalExam)}'),
        )),
      ]),
    );
  }
}
