import 'package:flutter/material.dart';
import 'package:todoapp_pro/UI/container/todoapp_container.dart';

class TodoAppPulsante extends StatelessWidget {
  final String? testo;
  final Color? coloreDiSfondo;
  final IconData? icona;
  final VoidCallback onPressed;
  final Color? coloreDelTesto;
  const TodoAppPulsante({
    super.key,
    this.testo,
    this.coloreDiSfondo,
    this.icona,
    required this.onPressed,
     this.coloreDelTesto,
  });

  @override
  Widget build(BuildContext context) {
    return TodoappContainer(
      coloreDiSfondo: coloreDiSfondo,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            spacing: 8,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icona != null) Icon(icona, color: coloreDelTesto ?? Colors.black, size: 24,),
              if (testo != null) Text(testo!, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: coloreDelTesto ?? Colors.black)),
            ],
          ),
        ),
      )
    );

  }
}
