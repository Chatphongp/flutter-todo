class Todo {
  int id;
  String title;
  String description;
  int done;

  Todo ({ this.id, this.title, this.description, this.done});

  factory Todo.fromJSON(Map<String, dynamic> json) => new Todo(
    id : json["id"],
    title : json["title"],
    description:  json["description"],
    done : json["done"]
  );

  Map<String, dynamic> toJson() => {
    "title" : title,
    "description" : description,
    "done" : done
  };

  Map<String, dynamic> toJsonWithId() => {
    "title" : title,
    "description" : description,
    "done" : done
  };


}