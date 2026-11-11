import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MaterialApp(home: BatteryPage()));

class BatteryPage extends StatefulWidget {
  const BatteryPage({super.key});
  @override
  State<BatteryPage> createState() => _BatteryPageState();
}
class _BatteryPageState extends State<BatteryPage> {
  static const channel = MethodChannel('edu.cui.sahiwal/device');
  String battery = 'Not read yet';

  Future<void> readBattery() async {
    try {
      final value = await channel.invokeMethod<int>('batteryLevel');
      if (mounted) setState(() => battery =
          value == null ? 'Unknown' : '$value%');
    } on PlatformException catch (e) {
      if (mounted) setState(() => battery = 'Native error: ${e.code}');
    } on MissingPluginException {
      if (mounted) setState(() => battery = 'Native channel missing');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Android battery channel')),
    body: Center(child: Column(mainAxisSize: MainAxisSize.min,
      children: [
        Text('Battery: $battery',
          style: Theme.of(context).textTheme.headlineSmall),
        FilledButton(onPressed: readBattery,
          child: const Text('Read Android battery')),
      ],
    )),
  );
}
