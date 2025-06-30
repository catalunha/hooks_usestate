import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class TodoListPage extends HookWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de tarefas
    final todos = useState<List<String>>([]);

    // Controlador de texto
    final controller = useTextEditingController();

    // Função auxiliar para adicionar item
    void addTodo() {
      final text = controller.text.trim();
      if (text.isEmpty) return;

      todos.value = [...todos.value, text];
      controller.clear();
    }

    return Scaffold(
      appBar: AppBar(title: const Text("To-do com useState")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'Nova tarefa'),
              onSubmitted: (_) => addTodo(),
            ),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: addTodo, child: const Text("Adicionar")),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: todos.value.length,
                itemBuilder: (context, index) {
                  final todo = todos.value[index];
                  return ListTile(
                    title: Text(todo),
                    onTap: () {
                      todos.value = List.from(todos.value)..removeAt(index);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
