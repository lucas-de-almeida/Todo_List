import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:to_do_list/models/Todo.dart';

class TodoController extends GetxController {
  // ignore: deprecated_member_use
  var todos = List<Todo>().obs;

  @override
  void onInit() {
    List storedTodos = GetStorage().read<List>('todos');
    // ignore: deprecated_member_use
    if (!storedTodos.isNull) {
      todos = storedTodos.map((e) => Todo.fromJson(e)).toList().obs;
    }
    ever(todos, (_) {
      GetStorage().write('todos', todos.toList());
    });
    super.onInit();
  }
}
