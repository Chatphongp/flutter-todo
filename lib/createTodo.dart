import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_list/class/dbProvider.dart';
import 'package:todo_list/class/model.dart';

class CreateTodoPage extends StatefulWidget {
  CreateTodoPage({Key key}) : super(key: key);

  @override
  _CreateTodoPageState createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  TextEditingController titleController;
  TextEditingController descriptionController;
  bool isSubmitted = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  void onSubmit() async {
    setState(() {
      isSubmitted = true;
    });

    Todo todo = Todo(
        id: 0,
        title: titleController.text ?? "",
        description: descriptionController.text ?? "",
        done: 0);

    await DBProvider.db.newTodo(todo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Todo'),
      ),
      backgroundColor: Colors.lightBlue[50],
      body: Container(
          constraints: BoxConstraints.expand(),
          child: SafeArea(
              child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(hintText: 'Title'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(hintText: 'Description'),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: isSubmitted ? null : onSubmit,
                          child: Text('Submit'))
                    ],
                  ),
                )
              ],
            ),
          ))),
    );
  }
}
