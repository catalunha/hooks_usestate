import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class TimerControlPage extends HookWidget {
  const TimerControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    final time = useState(10);
    final isRunning = useState(false);

    useEffect(() {
      Timer? timer;

      if (isRunning.value && time.value > 0) {
        timer = Timer.periodic(const Duration(seconds: 1), (_) {
          if (time.value > 1) {
            time.value--;
          } else {
            time.value = 0;
            isRunning.value = false;
          }
        });
      }

      // Limpa o timer ao pausar ou desmontar
      return () => timer?.cancel();
    }, [isRunning.value, time.value]);

    return Scaffold(
      appBar: AppBar(title: const Text("Temporizador")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              time.value > 0
                  ? "Tempo restante: ${time.value}s"
                  : "⏰ Tempo esgotado!",
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (time.value == 0) time.value = 10;
                isRunning.value = true;
              },
              child: const Text("Iniciar"),
            ),
            ElevatedButton(
              onPressed: () {
                isRunning.value = false;
              },
              child: const Text("Pausar"),
            ),
            ElevatedButton(
              onPressed: () {
                isRunning.value = false;
                time.value = 10;
              },
              child: const Text("Resetar"),
            ),
          ],
        ),
      ),
    );
  }
}
