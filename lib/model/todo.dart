class Todo {
  // Atributos:

  int? _id; // podemos precisar do objeto ainda sem id
  String _title;
  String? _description; // este atributo é opcional
  String _date;
  int _priority;

  // Construtor para quando o BD ainda não definiu o id.
  // O parâmetro '_description' é opcional.
  Todo(this._title, this._priority, this._date, [this._description]);

  // Construtor para quando já tivermos o id.
  // Lembre-se, em dart não existe sobrecarga de métodos,
  // então precisaremos criar um "named constructor".
  // O parâmetro '_description' é opcional.
  Todo.withId(this._id, this._title, this._priority, this._date,
      [this._description]);

  // Getters...
  int get priority => _priority;
  String get date => _date;
  String? get description => _description;
  String get title => _title;
  int? get id => _id;

  // Setters...

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      _title = newTitle;
    }
  }

  set description(String? newDescription) {
    if (newDescription != null && newDescription.length <= 255) {
      _description = newDescription;
    }
  }

  set priority(int newPriority) {
    if (newPriority > 0 && newPriority <= 3) {
      _priority = newPriority;
    }
  }

  set date(String newDate) {
    _date = newDate;
  }

  // Lembrando Map (aulas dart de dpm)...
  //
  // É uma coleção não-ordenada de pares chave-valor (key-value).
  // Associa valores as suas chaves.
  //
  // Cada chave tem que ser única (não duplicada),
  // mas o mesmo valor pode ser usado várias vezes
  // Dois itens com o mesmo valor ainda serão únicos,
  // baseados em suas chaves diferentes.
  //
  // Use um Map quando você precisa acessar objetos
  // por meio de um identificador único

  // Quando os dados vierem do banco, vem como Map,
  // e para gravar no banco, enviar um Map.

  // Método que vai retornar um Map com os dados de nosso objeto.
  // Vai ser útil para uso com SQLite.

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["title"] = _title;
    map["description"] = _description;
    map["priority"] = _priority;
    map["date"] = _date;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  // Outro construtor nomeado que vai fazer o contrário
  // do método acima, isto é, criar um objeto TODO
  // a partir de um map passado como parâmetro.
  // Sintaxe: inicialização de campo em cascata,
  // uma maneira concisa de inicializar os campos da classe
  // diretamente no construtor.
  // Os : (dois pontos) são a parte crucial.
  // Após os parâmetros do construtor, vem os "inicializadores de campo",
  // que são separados por vírgulas.

  Todo.fromMap(dynamic o)
      : _id = o["id"],
        _title = o["title"],
        _description = o["description"],
        _priority = o["priority"],
        _date = o["date"];
}
