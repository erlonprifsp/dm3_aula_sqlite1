import 'package:flutter/material.dart';
import '../model/todo.dart';
import '../util/dbhelper.dart';

// Criando o StatefulWidget...
class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TodoListState();
}

class TodoListState extends State<TodoList> {

  // Atributos...
  DbHelper helper = DbHelper();
  List<Todo>? todos;
  int count = 0;     // número de registros na tabela

  // Método para recuperar os dados.
  // Retorna void, mas vai usar setState()
  // para atualizar os atributos.
  void getData() {

    // abre ou cria o banco de dados
    var dbFuture = helper.initializeDb();

    // quando o resultado chega... (banco de dados aberto)
    dbFuture.then( (result) {

      // cria a lista com todos os dados (lista de mapas)
      var todosFuture = helper.getTodos();

      // quando o resultado chega...
      todosFuture.then( (result) {

        // cria uma lista temporaria de objetos todo, chamada todoList (vazia):
        List<Todo> todoList = [];

        // vê quantos registros retornaram, guarda em count:
        count = result.length;

        // varre a lista result...
        // para cada elemento na lista (um Map), cria o objeto todo,
        // e adiciona em todoList.
        for (int i=0; i<count; i++) {
          todoList.add(Todo.fromMap(result[i])); // result[i] é um Map
          // mostra o título do elemento lido, so pra conferir:
          debugPrint(todoList[i].title);
        }

        // Chamando setState, e dentro dela, atualizando os atributos:
        setState(() {
          todos = todoList;
        });

        // mostra a quantidade, só pra conferência:
        debugPrint("Items " + count.toString());
      });
    });
  }

  // build deste widget...

  @override
  Widget build(BuildContext context) {

    // se o atributo todos está vazio, é pq
    // a tela carregou pela 1a vez
    if (todos == null) {
      // cria a lista todos:
      todos = [];
      // popula a lista todos:
      getData();
    }

    return Scaffold(

      appBar: AppBar(
        title: Text("BD com Lista"),
      ),

      body: todoListItems(),

      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: "Add new Todo",
        child: new Icon(Icons.add),
      ),
    );
  }

  // corpo do Scaffold, nosso listview
  ListView todoListItems() {

    // criando e retornando nosso listview:
    return ListView.builder(

      itemCount: count,  // total de elementos na lista

      // no parâmetro itemBuilder vai uma função que será
      // executada para cada item da lista (de número position):
      itemBuilder: (BuildContext context, int position) {
        // cada item da lista sera um Card (CardView do android nativo):
        return Card(

          color: Colors.white,
          elevation: 2.0,

          // Widget que forma o item da lista:
          child: ListTile(

            // o que vai no início do item
            leading: CircleAvatar(
              backgroundColor: getColor(this.todos![position].priority),
              child:Text(this.todos![position].priority.toString()),
            ),

            title: Text(this.todos![position].title),

            subtitle: Text(this.todos![position].date),

            onTap: () {
              debugPrint("Tapped on " + this.todos![position].title.toString());

            },
          ),
        );
      },
    );
  }


  // Método para definir a cor baseada na prioridade:
  Color getColor(int priority) {

    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.orange;
        break;
      case 3:
        return Colors.green;
        break;

      default:
        return Colors.green;
    }

  }

}