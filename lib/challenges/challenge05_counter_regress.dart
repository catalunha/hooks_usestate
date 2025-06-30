import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class CountdownPage extends HookWidget {
  const CountdownPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = useState(10);
    final isRunning = useState(false);

    useEffect(() {
      Timer? timer;

      if (isRunning.value) {
        timer = Timer.periodic(const Duration(seconds: 1), (_) {
          if (counter.value > 0) {
            counter.value--;
          } else {
            isRunning.value = false;
            timer?.cancel();
          }
        });
      }

      // Cancelar o timer ao sair do widget ou reiniciar
      return () => timer?.cancel();
    }, [isRunning.value]); // Dispara quando isRunning muda

    return Scaffold(
      appBar: AppBar(title: const Text("Contador Regressivo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              counter.value > 0
                  ? 'Contando: ${counter.value}'
                  : 'Fim da contagem!',
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  isRunning.value || counter.value == 0
                      ? null
                      : () {
                        counter.value = 10;
                        isRunning.value = true;
                      },
              child: const Text("Iniciar"),
            ),
          ],
        ),
      ),
    );
  }
}
