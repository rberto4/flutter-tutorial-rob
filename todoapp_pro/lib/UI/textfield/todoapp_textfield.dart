import 'package:flutter/material.dart';
import 'package:todoapp_pro/temi/todoapp_colori.dart';

class TodoappTextfield extends StatelessWidget {
  final String? label;
  final Color? labelColor;
  final Color? coloreDelTesto;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  const TodoappTextfield({
    super.key,
    this.label,
    this.labelColor,
    this.coloreDelTesto,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: TodoappColori.rosso,
      decoration: InputDecoration(
        labelText: label ?? 'Testo ..',
        labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: labelColor ?? TodoappColori.nero,
        ),
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        border: OutlineInputBorder(borderSide: BorderSide.none),
      ),
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
        color: coloreDelTesto ?? TodoappColori.grigio,
      ),
      maxLines: null,
      expands: true,
      textAlignVertical: TextAlignVertical.top,

      onChanged: (value) {
        onChanged?.call(value);
      },
    );
  }
}
