import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/controllers/ToDoController.dart';
import 'package:to_do_list/screens/ToDoScreen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.put(TodoController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GetX ToDo List',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(ToDoScreen());
        },
      ),
      body: Container(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.separated(
              itemBuilder: (context, index) => Dismissible(
                key: UniqueKey(),
                onDismissed: (_) {
                  var removed = todoController.todos[index];
                  todoController.todos.removeAt(index);
                  Get.snackbar('tarefa removida',
                      'a tarefa "${removed.text}" foi removida com sucesso',
                      mainButton: TextButton(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'desfazer',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        onPressed: () {
                          // ignore: deprecated_member_use
                          if (removed.isNull) {
                            return;
                          }
                          todoController.todos.insert(index, removed);
                          removed = null;
                          if (Get.isSnackbarOpen) {
                            Get.back();
                          }
                        },
                      ));
                },
                child: ListTile(
                  title: Text(
                    todoController.todos[index].text,
                    style: (todoController.todos[index].done)
                        ? TextStyle(
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough)
                        : TextStyle(
                            color: Theme.of(context).textTheme.bodyText1.color),
                  ),
                  onTap: () {
                    Get.to(ToDoScreen(
                      index: index,
                    ));
                  },
                  leading: Checkbox(
                    value: todoController.todos[index].done,
                    onChanged: (value) {
                      var changed = todoController.todos[index];
                      changed.done = value;
                      todoController.todos[index] = changed;
                    },
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
              itemCount: todoController.todos.length,
              separatorBuilder: (_, __) => Divider(),
            ),
          ),
        ),
      ),
    );
  }
}
