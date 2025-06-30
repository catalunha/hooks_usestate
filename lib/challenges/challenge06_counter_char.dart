import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class CharacterCounterPage extends HookWidget {
  const CharacterCounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final charCount = useState(0);
    const maxLength = 50;

    // Atualiza a contagem sempre que o texto muda
    useEffect(() {
      void listener() {
        charCount.value = controller.text.length;
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    return Scaffold(
      appBar: AppBar(title: const Text("Contador de Caracteres")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              maxLength: maxLength,
              decoration: const InputDecoration(
                labelText: "Digite algo",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            Text("Caracteres: ${charCount.value} / $maxLength"),
            if (charCount.value == maxLength)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  "Limite atingido!",
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
