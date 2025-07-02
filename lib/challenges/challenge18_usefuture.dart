import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

Future<String> buscarMensagem(int id) async {
  await Future.delayed(const Duration(seconds: 2));
  return "Resultado para ID $id";
}

class UseFutureExample extends HookWidget {
  const UseFutureExample({super.key});

  @override
  Widget build(BuildContext context) {
    final id = useState(1);

    final future = useMemoized(() => buscarMensagem(id.value), [id.value]);
    final snapshot = useFuture(future);

    return Scaffold(
      appBar: AppBar(title: const Text("useFuture")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (snapshot.connectionState == ConnectionState.waiting)
              const CircularProgressIndicator()
            else if (snapshot.hasError)
              Text("Erro: ${snapshot.error}")
            else if (snapshot.hasData)
              Text(snapshot.data!, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => id.value++,
              child: const Text("Buscar novo ID"),
            ),
          ],
        ),
      ),
    );
  }
}
