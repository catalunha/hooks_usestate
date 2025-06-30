import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class ToggleWithSnackbar extends HookWidget {
  const ToggleWithSnackbar({super.key});

  @override
  Widget build(BuildContext context) {
    final isOn = useState(false);

    // Executa algo sempre que isOn muda
    useEffect(() {
      if (isOn.value) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("O botão foi ligado!")));
      }
      return null; // Nenhuma limpeza necessária
    }, [isOn.value]);

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            isOn.value = !isOn.value;
          },
          child: Text(isOn.value ? 'Ligado' : 'Desligado'),
        ),
      ),
    );
  }
}
