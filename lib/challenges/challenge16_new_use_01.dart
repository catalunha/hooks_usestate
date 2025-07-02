import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

int useFatorialCache(int n) {
  final cache = useMemoized(() => <int, int>{});

  return useMemoized(() {
    if (cache.containsKey(n)) return cache[n]!;

    int resultado = 1;
    for (int i = 1; i <= n; i++) {
      resultado *= i;
    }

    cache[n] = resultado;
    return resultado;
  }, [n]);
}

class FatorialHookPage extends HookWidget {
  const FatorialHookPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final input = useState(0);

    final resultado = useFatorialCache(input.value);

    return Scaffold(
      appBar: AppBar(title: const Text("Hook: useFatorialCache")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Digite um número"),
              onChanged: (text) {
                final n = int.tryParse(text);
                if (n != null && n >= 0) {
                  input.value = n;
                }
              },
            ),
            const SizedBox(height: 20),
            Text(
              "Fatorial de ${input.value} = $resultado",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
