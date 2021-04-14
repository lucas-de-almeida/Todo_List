import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/controllers/ToDoController.dart';
import 'package:to_do_list/models/Todo.dart';

class ToDoScreen extends StatelessWidget {
  final TodoController todoController = Get.find();

  final int index;
  ToDoScreen({this.index});
  @override
  Widget build(BuildContext context) {
    String text = '';
    // ignore: deprecated_member_use
    if (!this.index.isNull) {
      text = todoController.todos[index].text;
    }
    TextEditingController textEditingController =
        TextEditingController(text: text);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: textEditingController,
                autofocus: true,
                decoration: InputDecoration(
                    hintText: ' what do you want to accomplish',
                    border: InputBorder.none),
                style: TextStyle(
                  fontSize: 25,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 999,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('Cancel'),
                  color: Colors.red,
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  // ignore: deprecated_member_use
                  child: Text((this.index.isNull) ? 'Add' : 'Edit'),
                  color: Colors.green,
                  onPressed: () {
                    // ignore: deprecated_member_use
                    if (this.index.isNull) {
                      todoController.todos
                          .add(Todo(text: textEditingController.text));

                      textEditingController.text = '';
                    } else {
                      var editing = todoController.todos[index];
                      editing.text = textEditingController.text;
                      todoController.todos[index] = editing;
                    }
                    Get.back();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
