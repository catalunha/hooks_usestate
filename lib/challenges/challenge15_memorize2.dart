import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class FatorialCachePage extends HookWidget {
  const FatorialCachePage({super.key});

  int calcularFatorialLento(int n) {
    // Simula cálculo lento com delay
    int resultado = 1;
    for (int i = 1; i <= n; i++) {
      resultado *= i;
    }
    return resultado;
  }

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final input = useState(0);

    // Cache local de resultados
    final cache = useMemoized(() => <int, int>{});

    // Resultado do fatorial (calculado ou reaproveitado)
    final resultado = useMemoized(() {
      final numero = input.value;

      // Retorna do cache, se já existe
      if (cache.containsKey(numero)) {
        return cache[numero]!;
      }

      // Senão, calcula e salva no cache
      final valor = calcularFatorialLento(numero);
      cache[numero] = valor;
      return valor;
    }, [input.value]);

    return Scaffold(
      appBar: AppBar(title: const Text("Fatorial com Cache")),
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
