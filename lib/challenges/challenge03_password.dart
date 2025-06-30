import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class PasswordVisibilityPage extends HookWidget {
  const PasswordVisibilityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final obscureText = useState(true); // começa ocultando
    final controller = useTextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Senha com useState")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: controller,
          obscureText: obscureText.value,
          decoration: InputDecoration(
            labelText: "Senha",
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(
                obscureText.value ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                obscureText.value = !obscureText.value;
              },
            ),
          ),
        ),
      ),
    );
  }
}
