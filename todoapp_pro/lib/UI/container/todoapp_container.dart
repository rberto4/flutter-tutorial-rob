import 'package:flutter/material.dart';

class TodoappContainer extends StatelessWidget {
  final Widget child;
  final Color? coloreDiSfondo;
  const TodoappContainer({super.key, required this.child, this.coloreDiSfondo});

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border(
          bottom: BorderSide(color: Colors.black, width: 5),
          right: BorderSide(color: Colors.black, width: 5),
        ),
        color: coloreDiSfondo ?? Colors.white,
      ),
      child: child,
    );
  }
}