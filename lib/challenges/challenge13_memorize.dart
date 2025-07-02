import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class MeuWidget extends HookWidget {
  const MeuWidget({super.key});

  int calcularFibonacci(int n) {
    if (n <= 1) return n;
    return calcularFibonacci(n - 1) + calcularFibonacci(n - 2);
  }

  @override
  Widget build(BuildContext context) {
    final n = useState(30);

    final fib = useMemoized(() => calcularFibonacci(n.value), [n.value]);

    return Column(
      children: [
        Text("Fib(${n.value}): $fib"),
        ElevatedButton(
          onPressed: () => n.value++,
          child: const Text("Incrementar N"),
        ),
      ],
    );
  }
}
