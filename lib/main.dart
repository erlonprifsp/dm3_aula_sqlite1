import 'package:flutter/material.dart';

// Importando o dbhelper:
import '/util/dbhelper.dart';
// Importando a classe do modelo:
import '/model/todo.dart';
// Inserir a classe todolist:
import '/screens/todolist.dart';


void main() => runApp(new MyApp());


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BD com Lista',
      home: new TodoList(),
    );
  }

}