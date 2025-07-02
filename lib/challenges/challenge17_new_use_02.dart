import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class Countdown {
  final int value;
  final bool isRunning;
  final void Function() start;
  final void Function() pause;
  final void Function() reset;

  const Countdown({
    required this.value,
    required this.isRunning,
    required this.start,
    required this.pause,
    required this.reset,
  });
}

Countdown useCountdown({required int initialSeconds}) {
  final current = useState(initialSeconds);
  final isRunning = useState(false);

  useEffect(() {
    Timer? timer;

    if (isRunning.value && current.value > 0) {
      timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (current.value > 1) {
          current.value--;
        } else {
          current.value = 0;
          isRunning.value = false;
        }
      });
    }

    return () => timer?.cancel();
  }, [isRunning.value, current.value]);

  void start() {
    if (current.value == 0) {
      current.value = initialSeconds;
    }
    isRunning.value = true;
  }

  void pause() => isRunning.value = false;
  void reset() {
    isRunning.value = false;
    current.value = initialSeconds;
  }

  return Countdown(
    value: current.value,
    isRunning: isRunning.value,
    start: start,
    pause: pause,
    reset: reset,
  );
}

class CountdownPage extends HookWidget {
  const CountdownPage({super.key});

  @override
  Widget build(BuildContext context) {
    final countdown = useCountdown(initialSeconds: 10);

    return Scaffold(
      appBar: AppBar(title: const Text("Contador com Hook")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("⏳ ${countdown.value}", style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: countdown.start,
              child: const Text("Iniciar"),
            ),
            ElevatedButton(
              onPressed: countdown.pause,
              child: const Text("Pausar"),
            ),
            ElevatedButton(
              onPressed: countdown.reset,
              child: const Text("Resetar"),
            ),
          ],
        ),
      ),
    );
  }
}
