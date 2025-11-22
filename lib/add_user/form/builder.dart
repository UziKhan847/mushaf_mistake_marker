import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/add_user/form/buttons.dart';
import 'package:mushaf_mistake_marker/add_user/form/form.dart';
import 'package:mushaf_mistake_marker/add_user/form/header.dart';

class AddUserFormBuilder extends StatefulWidget {
  const AddUserFormBuilder({
    super.key,
    required this.colorScheme,
    required this.textTheme,
    this.onCancel,
    this.onSubmit,
  });

  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final VoidCallback? onCancel;
  final VoidCallback? onSubmit;

  @override
  State<AddUserFormBuilder> createState() => _AddUserFormBuilderState();
}

class _AddUserFormBuilderState extends State<AddUserFormBuilder> {
  final _formKey = GlobalKey<FormState>();
  final txtCtrl = TextEditingController();

  bool submitting = false;

  @override
  void dispose() {
    txtCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 280, maxWidth: 420),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          AddUserHeader(
            colorScheme: widget.colorScheme,
            textTheme: widget.textTheme,
            onCancel: widget.onCancel,
          ),

          const SizedBox(height: 6),

          Text(
            'Enter a username to add a new account. You can update additional details later.',
            style: widget.textTheme.bodyMedium?.copyWith(
              color: widget.colorScheme.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 16),

          AddUserForm(
            formKey: _formKey,
            colorScheme: widget.colorScheme,
            textTheme: widget.textTheme,
            txtCtrl: txtCtrl,
          ),

          const SizedBox(height: 18),

          AddUserButtons(
            colorScheme: widget.colorScheme,
            textTheme: widget.textTheme,
            onCancel: widget.onCancel,
            submitting: submitting,
            onSubmit: () async {
              if (_formKey.currentState!.validate()) {
                submitting = true;
                setState(() {});
              }

              await Future.delayed(Duration(milliseconds: 1000));

              widget.onSubmit!();
            },
          ),

          const SizedBox(height: 8),

          Text(
            'Only username is required for now.',
            style: widget.textTheme.bodySmall?.copyWith(
              color: widget.colorScheme.onSurfaceVariant,
            ),
            textAlign: .center,
          ),
        ],
      ),
    );
  }
}
