import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/Db/database_helper.dart';
import 'package:todolist/Models/User.dart';
import 'package:todolist/Pages/User/addUserPage.dart';
import 'package:todolist/Util/NetworkUtil.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Future<SharedPreferences> preferences = SharedPreferences.getInstance();
  List<User> users = [];

  _UserPageState() {
    _loadUsers();
    NetworkUtil.internal().main([]);
  }

  Future _loadUsers() async {
    var data = await DatabaseHelper.instance.queryAllRows();
    if (data.length > 0) {
      //Iterable decode = jsonDecode(data);
      // List<User> result = decode.map((user) => User.fromJson(user)).toList();
      List<User> result = data.map((e) => User.fromJson(e)).toList();

      setState(() {
        users = result;
      });
    }
  }

  _save() async {
    var prefs = await SharedPreferences.getInstance();
    // var usersMap = users.map((e) => e.toJson());
    // var usersInZero = users[0].toJson()

    prefs.setString("data", jsonEncode(users));
  }

  _delete(int id) {
    DatabaseHelper.instance.delete(id);
    _loadUsers();
  }

  Future<void> _insert(Map<String, dynamic> row) async {
    var result = await DatabaseHelper.instance.insert(row);
    _loadUsers();
    print(result);
  }

  Future<void> _update(Map<String, dynamic> obj) async {
    await DatabaseHelper.instance.update(obj);
    _loadUsers();
  }

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    User result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddUserPage(),
        ));

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      if (result.name != null) {
        _insert(result.toJson());
        //_add(result);
        print(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Usuários"),
      ),
      body: _listViewWidget(context),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _awaitReturnValueFromSecondScreen(context);
          },
          child: Icon(
            Icons.add,
          )),
    );
  }

  Widget _listViewWidget(BuildContext ctx) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext ctx, index) {
          return Card(
            child: Dismissible(
              key: Key(users[index].name.toString()),
              confirmDismiss: (DismissDirection direction) async {
                if (direction == DismissDirection.startToEnd) {
                  return false;
                } else {
                  int id = users[index].id as int;
                  _delete(id);
                }
              },
              child: ListTile(
                leading: FlutterLogo(size: 40.0),
                title: Text(users[index].name.toString()),
                subtitle:
                    Text(users[index].isActive == true ? "Ativo" : "Inativo"),
                trailing: Checkbox(
                    key: Key(users[index].name.toString()),
                    value: users[index].isActive,
                    onChanged: (value) {
                      setState(() {
                        users[index].isActive = value;
                        _update(users[index].toJson());
                      });
                    }),
              ),
              background: Container(
                color: Colors.red,
              ),
            ),
          );
        });
  }
}
