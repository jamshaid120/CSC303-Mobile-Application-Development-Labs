import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: AnimatedPage()));

class AnimatedPage extends StatefulWidget {
  const AnimatedPage({super.key});
  @override
  State<AnimatedPage> createState() => _AnimatedPageState();
}

class _AnimatedPageState extends State<AnimatedPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  bool expanded = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 500));
  }

  @override
  void dispose() { controller.dispose(); super.dispose(); }

  void toggle() {
    setState(() => expanded = !expanded);
    if (expanded) { controller.forward(); }
    else { controller.reverse(); }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Flutter animation lab')),
    body: Column(children: [
      AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        margin: const EdgeInsets.all(12),
        height: expanded ? 140 : 75,
        width: double.infinity,
        decoration: BoxDecoration(
          color: expanded ? Colors.teal : Colors.indigo.shade200,
          borderRadius: BorderRadius.circular(14)),
        child: const Center(child: Text('Tap below to animate')),
      ),
      AnimatedBuilder(animation: controller,
        builder: (_, __) => LinearProgressIndicator(
          value: controller.value)),
      FilledButton(onPressed: toggle,
        child: Text(expanded ? 'Collapse' : 'Expand')),
      Expanded(child: ListView.builder(
        itemCount: 1000,
        itemBuilder: (_, i) => ListTile(
          leading: const Icon(Icons.bolt),
          title: Text('Efficient row ${i + 1}')),
      )),
    ]),
  );
}
