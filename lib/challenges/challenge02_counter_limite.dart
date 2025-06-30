import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class LimitedCounterPage extends HookWidget {
  const LimitedCounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = useState(0);
    const int max = 10;

    return Scaffold(
      appBar: AppBar(title: const Text("Contador com Limite")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Valor: ${counter.value}',
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: counter.value >= max ? null : () => counter.value++,
              child: const Text("+1"),
            ),
            ElevatedButton(
              onPressed: () => counter.value = 0,
              child: const Text("Resetar"),
            ),
            if (counter.value == max)
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  "Valor máximo atingido!",
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
