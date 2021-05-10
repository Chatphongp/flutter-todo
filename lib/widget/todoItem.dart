import 'package:flutter/material.dart';
import 'package:todo_list/class/constants.dart';
import 'package:todo_list/class/dbProvider.dart';
import 'package:todo_list/class/model.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Function callback;
  const TodoItem({Key key,this.todo, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await DBProvider.db.toggleTodo(todo);
        if (callback != null) callback();
      },

      onLongPress: ()  async{
        await DBProvider.db.deleteTodo(todo);
        if (callback != null) callback(); 
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: Constants.MAIN_TEXT_STYLE.copyWith(fontSize : 18, fontWeight: FontWeight.w600),
                ),
                Text(todo.description, style: Constants.MAIN_TEXT_STYLE)
              ],
            ),
            Center(child: Icon(todo.done > 0 ? Icons.check_box : Icons.check_box_outline_blank, color: Colors.yellow[600],))
          ],
        )),
    );
  }
}
