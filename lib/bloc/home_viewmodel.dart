
import 'package:injectable/injectable.dart';
import 'package:to_do_app_flutter/bloc/base_viewmodel.dart';

import '../main.dart';
import '../model/my_todo.dart';

@Injectable()
class HomeViewModel extends BaseViewModel {

  final List<MyTodo> listMyTodo = <MyTodo>[];

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    final allRows = await dbHelper.queryAllRows();
    return allRows;
  }

  void updateFollowName(MyTodo oldMyTodo, MyTodo newMyTodo) async {
    await dbHelper.update(newMyTodo.toMap());
    final indexNeedUpdate = listMyTodo.indexOf(oldMyTodo);
    listMyTodo.replaceRange(indexNeedUpdate, indexNeedUpdate + 1, [newMyTodo]);
  }

  void deleteTodo(MyTodo myTodo) {
    dbHelper.delete(myTodo.toMap());
    listMyTodo.remove(myTodo);
  }

  void insertTodo(MyTodo myTodo) {
    final row = myTodo.toMap();
    dbHelper.insert(row);
    listMyTodo.add(myTodo);
  }
}