import 'package:flutter/material.dart';
import 'package:todoapp_pro/temi/todoapp_colori.dart';

class TodoappAppbar extends StatelessWidget {
  final String? titolo;
  final List<Widget>? azioni;
  final bool? mostraFrecciaIndietro;
  const TodoappAppbar({
    super.key,
    this.titolo,
    this.azioni,
    this.mostraFrecciaIndietro,
  });

  @override
  Widget build(BuildContext context) {
    String primaParte = titolo != null && titolo!.contains(' ')
      ? '${titolo!.split(' ')[0]} '
        : 'Todo';
    String secondaParte = titolo != null && titolo!.contains(' ')
      ? titolo!.split(' ').sublist(1).join(' ')
        : 'App';

    return AppBar(
      automaticallyImplyLeading: mostraFrecciaIndietro ?? false,
      // widget particolare per creare titolo con 2 colori
      title: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyLarge,
          children: [
            TextSpan(
              text: primaParte,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: secondaParte,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: TodoappColori.rosso,
              ),
            ),
          ],
        ),
      ),
      actions: [
        if (azioni != null) ...azioni!,
      ],
      centerTitle: false,
      backgroundColor: Colors.amber,
    );
  }
}
