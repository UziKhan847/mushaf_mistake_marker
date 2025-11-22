import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/add_user/form/builder.dart';
import 'package:mushaf_mistake_marker/add_user/succes_builder.dart';
import 'package:mushaf_mistake_marker/overlay/overlay_type/popup_card.dart';

class AddUserCard extends StatefulWidget {
  const AddUserCard({
    super.key,
    required this.colorScheme,
    required this.textTheme,
    this.onCancel,
  });

  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final VoidCallback? onCancel;

  @override
  State<AddUserCard> createState() => _AddUserCardState();
}

class _AddUserCardState extends State<AddUserCard> {
  bool submitting = false;

  @override
  Widget build(BuildContext context) {
    return PopupCard(
      child: AnimatedSize(
        duration: Duration(milliseconds: 350),
        curve: Curves.decelerate,
        child: submitting
            ? AddUserSuccesBuilder(
                colorScheme: widget.colorScheme,
                textTheme: widget.textTheme,
              )
            : AddUserFormBuilder(
                colorScheme: widget.colorScheme,
                textTheme: widget.textTheme,
                onCancel: widget.onCancel,
                onSubmit: () {
                  submitting = true;
                  setState(() {});
                },
              ),
      ),
    );
  }
}
