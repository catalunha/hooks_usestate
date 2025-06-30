import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class ColorPickerPage extends HookWidget {
  const ColorPickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedColor = useState<String>("vermelho");

    // Mapeia o nome da cor para uma Color real
    Color getColorFromName(String name) {
      switch (name) {
        case 'vermelho':
          return Colors.red;
        case 'verde':
          return Colors.green;
        case 'azul':
          return Colors.blue;
        default:
          return Colors.white;
      }
    }

    return Scaffold(
      backgroundColor: getColorFromName(selectedColor.value),
      appBar: AppBar(title: const Text("Seletor de Cor")),
      body: Center(
        child: DropdownButton<String>(
          value: selectedColor.value,
          items: const [
            DropdownMenuItem(value: 'vermelho', child: Text('Vermelho')),
            DropdownMenuItem(value: 'verde', child: Text('Verde')),
            DropdownMenuItem(value: 'azul', child: Text('Azul')),
          ],
          onChanged: (value) {
            if (value != null) {
              selectedColor.value = value;
            }
          },
        ),
      ),
    );
  }
}
