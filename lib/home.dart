import 'package:flutter/material.dart';
import 'package:todo_list/class/dbProvider.dart';
import 'package:todo_list/class/model.dart';
import 'package:todo_list/createTodo.dart';
import 'package:todo_list/widget/todoItem.dart';

import 'class/constants.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Todo>> _todoList;

  int total = 0;
  int pending = 0;

  @override
  void initState() {
    super.initState();
    getTodo();
  }

  void getTodo() {
    setState(() {
      _todoList = DBProvider.db.getAllTodo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (BuildContext context) => CreateTodoPage()))
              .then((value) {
            print('pop');
            getTodo();
          });
        },
        tooltip: 'Crete Todo',
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.lightBlue[50],
      body: Container(
          constraints: BoxConstraints.expand(),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                height: 150,
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Todo',
                            style: Constants.MAIN_TEXT_STYLE.copyWith(
                                fontSize: 24, fontWeight: FontWeight.bold))
                      ],
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
              ),
              Expanded(
                  child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: FutureBuilder(
                          future: _todoList,
                          builder: (BuildContext context, AsyncSnapshot ss) {
                            if (ss.hasData) {
                              return ListView.builder(
                                  itemCount: ss.data.length,
                                  itemBuilder: (context, index) {
                                    Todo t = ss.data[index];
                                    return TodoItem(
                                      todo: t,
                                      callback: getTodo,
                                    );
                                  });
                            } else {
                              return Center(
                                child: Text('No Todo abvailable'),
                              );
                            }
                          })))
            ],
          )),
    );
  }
}
