import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class EmailValidationPage extends HookWidget {
  const EmailValidationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final errorMessage = useState<String?>(null);

    void validateEmail() {
      final email = controller.text.trim();

      if (!email.contains("@")) {
        errorMessage.value = "E-mail inválido.";
      } else {
        errorMessage.value = null;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Email enviado com sucesso!")),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Validação de Email")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: "E-mail",
                errorText: errorMessage.value,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: validateEmail,
              child: const Text("Enviar"),
            ),
          ],
        ),
      ),
    );
  }
}
