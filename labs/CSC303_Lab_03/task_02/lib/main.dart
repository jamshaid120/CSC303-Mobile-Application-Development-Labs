import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: InventoryPage()));

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});
  static const items = [
    ('Laptop', Icons.laptop, 129000),
    ('Mouse', Icons.mouse, 2200),
    ('Keyboard', Icons.keyboard, 4900),
    ('Phone', Icons.smartphone, 68000),
    ('Headphones', Icons.headphones, 5500),
    ('Tablet', Icons.tablet, 87000),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Responsive inventory')),
      body: LayoutBuilder(builder: (context, size) {
        final columns = size.maxWidth >= 700 ? 4 :
            size.maxWidth >= 420 ? 3 : 2;
        return GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns, crossAxisSpacing: 12,
            mainAxisSpacing: 12, childAspectRatio: .90,
          ),
          itemCount: items.length,
          itemBuilder: (context, i) {
            final item = items[i];
            return Card(child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item.$2, size: 38, color: Colors.teal),
                  const SizedBox(height: 8),
                  Text(item.$1, textAlign: TextAlign.center),
                  Text('Rs. ${item.$3}', textAlign: TextAlign.center),
                ],
              ),
            ));
          },
        );
      }),
    );
  }
}
