import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider(
  create: (_) => CartModel(),
  child: const MaterialApp(home: ShopPage()),
));

class CartModel extends ChangeNotifier {
  final Map<String, int> quantities = {};
  int get count => quantities.values.fold(0, (a, b) => a + b);
  void add(String item) {
    quantities[item] = (quantities[item] ?? 0) + 1;
    notifyListeners();
  }
  void clear() { quantities.clear(); notifyListeners(); }
}

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});
  @override
  Widget build(BuildContext context) {
    const items = ['Notebook', 'Marker', 'Pen', 'Folder'];
    final count = context.watch<CartModel>().count;
    return Scaffold(
      appBar: AppBar(title: Text('Campus shop • Cart: $count')),
      body: ListView(children: [
        for (final item in items)
          ListTile(title: Text(item),
            trailing: FilledButton(
              onPressed: () => context.read<CartModel>().add(item),
              child: const Text('Add'))),
        const Divider(),
        Consumer<CartModel>(builder: (_, cart, __) => Column(
          children: [
            for (final entry in cart.quantities.entries)
              Text('${entry.key}: ${entry.value}'),
            TextButton(onPressed: cart.clear, child: const Text('Clear cart')),
          ],
        )),
      ]),
    );
  }
}
