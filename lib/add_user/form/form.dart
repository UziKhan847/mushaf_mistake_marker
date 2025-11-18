import 'package:flutter/material.dart';

class AddUserForm extends StatelessWidget {
  const AddUserForm({
    super.key,
    required this.formKey,
    required this.colorScheme,
    required this.textTheme,
    required this.txtCtrl,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController txtCtrl;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        controller: txtCtrl,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          labelText: 'Username',
          hintText: 'e.g. umaza_2040',
          filled: true,
          fillColor: colorScheme.surfaceContainerHighest,
          prefixIcon: Icon(
            Icons.person_outline,
            color: colorScheme.onSurfaceVariant,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: colorScheme.primary, width: 2),
          ),
        ),
        validator: (v) {
          final s = v?.trim() ?? '';
          if (s.isEmpty) {
            return 'Please enter a username';
          }
          if (s.length < 3) {
            return 'Username must be at least 3 characters';
          }
          return null;
        },
      ),
    );
  }
}
