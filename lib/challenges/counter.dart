import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class CounterPage extends HookWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // useState cria um estado reativo.
    final counter = useState(0);

    return Scaffold(
      appBar: AppBar(title: const Text('Contador com useState')),
      body: Center(
        child: Text(
          'Valor: ${counter.value}',
          style: const TextStyle(fontSize: 24),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counter.value++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
