
import 'package:injectable/injectable.dart';
import 'package:to_do_app_flutter/bloc/base_viewmodel.dart';

import '../main.dart';
import '../model/my_todo.dart';

@Injectable()
class HomeViewModel extends BaseViewModel {

  final List<MyTodo> _listMyTodo = <MyTodo>[];

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    final allRows = await dbHelper.queryAllRows();
    return allRows;
  }

  void updateTodo(MyTodo oldMyTodo, MyTodo newMyTodo) async {
    final indexNeedUpdate = _listMyTodo.indexOf(oldMyTodo);
    _listMyTodo.replaceRange(indexNeedUpdate, indexNeedUpdate + 1, [newMyTodo]);
    await dbHelper.update(newMyTodo.toMap());
  }

  void deleteTodo(MyTodo myTodo) {
    dbHelper.delete(myTodo.toMap());
    _listMyTodo.remove(myTodo);
  }

  void insertTodo(MyTodo myTodo) {
    final row = myTodo.toMap();
    dbHelper.insert(row);
    _listMyTodo.add(myTodo);
  }

  void addItemMyTodo(MyTodo myTodo) {
    _listMyTodo.add(myTodo);
  }

  List<MyTodo> getListMyTodo() {
    return _listMyTodo;
  }
}