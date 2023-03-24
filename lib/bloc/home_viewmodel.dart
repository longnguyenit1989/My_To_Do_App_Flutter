
import 'package:injectable/injectable.dart';
import 'package:to_do_app_flutter/bloc/base_viewmodel.dart';

import '../main.dart';
import '../model/my_todo.dart';

@Injectable()
class HomeViewModel extends BaseViewModel {

  final List<MyTodo> listMyTodo = <MyTodo>[];

  void addTodo(String value) {
    final newMyTodo = MyTodo(name: value, checked: false);
    listMyTodo.add(newMyTodo);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    final allRows = await dbHelper.queryAllRows();
    return allRows;
  }

  void updateFollowName(MyTodo oldMyTodo, MyTodo newMyTodo) async {
    await dbHelper.updateFollowName(oldMyTodo.name, newMyTodo.name);
  }

  void deleteTodo(MyTodo myTodo) {
    dbHelper.delete(myTodo.name);
  }

  void insert(MyTodo myTodo) {
    final row = myTodo.toMap();
    dbHelper.insert(row);
  }
}