import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: MealPage()));

class MealPage extends StatefulWidget {
  const MealPage({super.key});
  @override
  State<MealPage> createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  String meal = 'Lunch';
  int quantity = 1;
  bool delivery = false;
  final prices = {'Breakfast': 200, 'Lunch': 350, 'Dinner': 450};

  @override
  Widget build(BuildContext context) {
    final total = prices[meal]! * quantity + (delivery ? 100 : 0);
    return Scaffold(
      appBar: AppBar(title: const Text('Meal estimator')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        SegmentedButton<String>(
          segments: const [
            ButtonSegment(value: 'Breakfast', label: Text('Breakfast')),
            ButtonSegment(value: 'Lunch', label: Text('Lunch')),
            ButtonSegment(value: 'Dinner', label: Text('Dinner')),
          ],
          selected: {meal},
          onSelectionChanged: (v) => setState(() => meal = v.first),
        ),
        Row(children: [
          const Expanded(child: Text('Quantity')),
          IconButton(onPressed: quantity > 1
              ? () => setState(() => quantity--) : null,
              icon: const Icon(Icons.remove)),
          Text('$quantity'),
          IconButton(onPressed: () => setState(() => quantity++),
              icon: const Icon(Icons.add)),
        ]),
        SwitchListTile(
          title: const Text('Home delivery (Rs. 100)'),
          value: delivery,
          onChanged: (v) => setState(() => delivery = v),
        ),
        const Divider(),
        Text('Total: Rs. $total',
            style: Theme.of(context).textTheme.headlineMedium),
      ]),
    );
  }
}
