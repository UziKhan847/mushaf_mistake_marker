import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/add_user/phase.dart';

class AddUserTextField extends ConsumerWidget {
  const AddUserTextField({
    super.key,
    //required this.formKey,
    required this.colorScheme,
    required this.textTheme,
    required this.textCtrl,
  });

  //final GlobalKey<FormState> formKey;
  final TextEditingController textCtrl;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phase = ref.watch(addUserPhaseProvider);
    final isError = phase == .error;

    return TextField(
      controller: textCtrl,
      textInputAction: .done,
      decoration: InputDecoration(
        labelText: 'Username',
        labelStyle: TextStyle(color: isError ? colorScheme.error : null),
        hintText: 'e.g. umaza_2040',
        hintStyle: TextStyle(
          color: isError
              ? colorScheme.error.withAlpha(178)
              : colorScheme.onSurfaceVariant,
        ),
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        prefixIcon: Icon(
          Icons.person_outline,
          color: isError ? colorScheme.error : colorScheme.onSurfaceVariant,
        ),
        border: OutlineInputBorder(borderRadius: .circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: .circular(12),
          borderSide: BorderSide(
            color: isError ? colorScheme.error : colorScheme.primary,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isError ? colorScheme.error : Colors.transparent,
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mushaf_mistake_marker/providers/user/user_provider.dart';

// class AddUserForm extends ConsumerWidget {
//   const AddUserForm({
//     super.key,
//     required this.formKey,
//     required this.colorScheme,
//     required this.textTheme,
//     required this.textCtrl,
//   });

//   final GlobalKey<FormState> formKey;
//   final TextEditingController textCtrl;
//   final ColorScheme colorScheme;
//   final TextTheme textTheme;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final userProv = ref.read(userProvider.notifier);
//     final usernames = userProv.getUsernames(isLowerCase: true);

//     return Form(
//       key: formKey,
//       child: TextFormField(
//         controller: textCtrl,
//         textInputAction: .done,
//         decoration: InputDecoration(
//           labelText: 'Username',
//           hintText: 'e.g. umaza_2040',
//           filled: true,
//           fillColor: colorScheme.surfaceContainerHighest,
//           prefixIcon: Icon(
//             Icons.person_outline,
//             color: colorScheme.onSurfaceVariant,
//           ),
//           border: OutlineInputBorder(borderRadius: .circular(12)),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: .circular(12),
//             borderSide: BorderSide(color: colorScheme.primary, width: 2),
//           ),
//         ),
//         validator: (v) {
//           final text = v?.trim() ?? '';

//           if (text.isEmpty) {
//             return 'Please enter a username';
//           }
//           if (text.length < 3) {
//             return 'Username must be at least 3 characters';
//           }
//           if (usernames.contains(text.toLowerCase())) {
//             return 'Username already in use.';
//           }

//           return null;
//         },
//       ),
//     );
//   }
// }