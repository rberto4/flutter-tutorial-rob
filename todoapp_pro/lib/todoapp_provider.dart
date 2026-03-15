import 'package:provider/provider.dart';
import 'package:todoapp_pro/controller/todoapp_controller.dart';
import 'package:todoapp_pro/servizi/implementazioni/todoapp_servizio_impl_firestore.dart';
import 'package:todoapp_pro/servizi/implementazioni/todoapp_servizio_impl_memoria.dart';
import 'package:todoapp_pro/servizi/implementazioni/todoapp_servizio_impl_sqlite.dart';

final todoAppProvider = ChangeNotifierProvider<TodoappController>(

  // Qui creo un'istanza del controller e la fornisco a tutta l'app
  // Il controller ha bisogno di un'istanza del servizio, quindi la creo qui e la passo al controller
  // In questo modo, se in futuro volessi cambiare l'implementazione del servizio 
  // (ad esempio per usare un database invece di una lista in memoria),
  // basterebbe cambiare questa riga con una nuona implementazione del servizio, 
  // senza dover modificare il controller o le schermate, la ui etc.
  // questo sistema si chiama dependency injection, 
  // è un principio fondamentale per scrivere codice modulare e testabile.

    create: (context) {
      final controller = TodoappController(
      //   servizio: TodoappServizioImplMemoria(),
       //servizio: TodoappServizioImplSqlite()
        servizio: TodoappServizioImplFirestore()
      );
      return controller;
    },
);