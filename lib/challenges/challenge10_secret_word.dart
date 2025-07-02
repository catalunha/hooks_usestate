import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class SecretWordWatcher extends HookWidget {
  const SecretWordWatcher({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final secretActivated = useState(false);

    useEffect(() {
      void listener() {
        if (controller.text.trim().toLowerCase() == 'flutter') {
          secretActivated.value = true;
        } else {
          secretActivated.value = false;
        }
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    return Scaffold(
      appBar: AppBar(title: const Text("Palavra Secreta")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: "Digite algo..."),
            ),
            const SizedBox(height: 20),
            if (secretActivated.value)
              const Text(
                "✨ Você descobriu o segredo!",
                style: TextStyle(fontSize: 20, color: Colors.purple),
              ),
          ],
        ),
      ),
    );
  }
}
