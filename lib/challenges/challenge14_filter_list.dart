import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class FilteredListPage extends HookWidget {
  const FilteredListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final search = useState('');

    // Lista fixa grande (1000 nomes simulados)
    final allNames = List.generate(1000, (i) => 'Nome ${i + 1}');

    // Simula um filtro pesado
    final filtered = useMemoized(() {
      // Cálculo artificialmente pesado
      final result =
          allNames
              .where(
                (name) =>
                    name.toLowerCase().contains(search.value.toLowerCase()),
              )
              .toList();
      return result;
    }, [search.value]);

    return Scaffold(
      appBar: AppBar(title: const Text("Busca na Lista")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: "Buscar nome..."),
              onChanged: (text) => search.value = text,
            ),
            const SizedBox(height: 16),
            Text("Encontrados: ${filtered.length}"),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder:
                    (context, index) => ListTile(title: Text(filtered[index])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
