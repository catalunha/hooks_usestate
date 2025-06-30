import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class MessageTimerPage extends HookWidget {
  const MessageTimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final showMessage = useState(false);

    useEffect(() {
      Timer? timer;

      if (showMessage.value) {
        timer = Timer(const Duration(seconds: 3), () {
          showMessage.value = false;
        });
      }

      return () => timer?.cancel();
    }, [showMessage.value]);

    return Scaffold(
      appBar: AppBar(title: const Text("Mensagem Temporária")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showMessage.value)
              const Text("Olá, mundo!", style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showMessage.value = true;
              },
              child: const Text("Mostrar Mensagem"),
            ),
          ],
        ),
      ),
    );
  }
}
