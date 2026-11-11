import 'package:flutter/material.dart';
import 'course_math.dart';

void main() => runApp(const MaterialApp(home: ScorePage()));

class ScorePage extends StatefulWidget {
  const ScorePage({super.key});
  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  int score = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Score tests')),
    body: Center(child: Column(mainAxisSize: MainAxisSize.min,
      children: [
        Text('Score: $score', key: const Key('score_text')),
        FilledButton(
          onPressed: () => setState(() => score = totalScore(
            assignment: 20, midterm: 20, finalExam: 40)),
          child: const Text('Calculate'),
        ),
      ],
    )),
  );
}
