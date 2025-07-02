import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class PhoneValidatorPage extends HookWidget {
  const PhoneValidatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final isValid = useState<bool>(false);

    useEffect(() {
      void listener() {
        final text = controller.text;
        final regex = RegExp(r'^\(\d{2}\) 9\d{4}-\d{4}$');
        isValid.value = regex.hasMatch(text);
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    return Scaffold(
      appBar: AppBar(title: const Text("Validação de Telefone")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: "Digite o telefone",
                hintText: "(11) 91234-5678",
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            Text(
              isValid.value ? "✅ Número válido!" : "❌ Número inválido",
              style: TextStyle(
                fontSize: 18,
                color: isValid.value ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
