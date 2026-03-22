import 'package:flutter/material.dart';
import 'package:todoapp_pro/temi/todoapp_colori.dart';

class TodoappTextfield extends StatelessWidget {
  final String? label;
  final String? hintText;
  final Color? labelColor;
  final Color? coloreDelTesto;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final IconData? icona;
  const TodoappTextfield({
    super.key,
    this.label,
    this.hintText,
    this.labelColor,
    this.coloreDelTesto,
    this.controller,
    this.onChanged,
    this.icona,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: TodoappColori.rosso,
      decoration: InputDecoration(
        isDense: true,
        labelText: label ?? 'Testo ..',
        hintText: hintText ?? '',
        labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: labelColor ?? TodoappColori.nero,
        ),
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        border: OutlineInputBorder(borderSide: BorderSide.none),
              prefixIcon: icona != null ? Icon(icona, color: TodoappColori.nero) : null,
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
