import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/Models/Item.dart';

class ItemPage extends StatefulWidget {
  var items = [];

  ItemPage() {
    items = [
      new Item(title: "Tarefa 1", done: true),
    ];
  }

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  var task = new TextEditingController();
  DismissDirection _dismissDirection = DismissDirection.startToEnd;

  _ItemPageState() {
    _load();
  }

  Future _load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString("items");

    if (data != null) {
      Iterable decode = jsonDecode(data);
      List<Item> result = decode.map((item) => Item.fromJson(item)).toList();

      setState(() {
        widget.items = result;
      });
    }
  }

  add() {
    if (task.text.isEmpty) return;
    widget.items.add(
      new Item(title: task.text, done: false),
    );
    save();
  }

  save() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("items", jsonEncode(widget.items));

    task.clear();
    _load();
  }

  delete(int index) {
    setState(() {
      widget.items.removeAt(index);
    });
    save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: task,
          decoration: InputDecoration(
            // border: OutlineInputBorder(),
            hintText: "Digite nome da tarefa...",
            labelStyle: TextStyle(color: Colors.black, fontSize: 15),
            hintStyle: TextStyle(color: Colors.white, fontSize: 18),
          ),
          style: TextStyle(
              // color: Colors.white,
              ),
        ),
      ),
      body: ListView.builder(
          itemCount: widget.items.length,
          itemBuilder: (BuildContext ctx, int index) {
            return Card(
              child: Dismissible(
                key: Key(widget.items[index].title),
                direction: _dismissDirection,
                onDismissed: (direction) => {
                  if (direction == DismissDirection.endToStart) {delete(index)}
                },
                child: ListTile(
                  leading: FlutterLogo(size: 56.0),
                  title: Text(widget.items[index].title),
                  subtitle:
                      Text(widget.items[index].done == true ? "Ok" : "Não Ok"),
                  trailing: Checkbox(
                    value: widget.items[index].done,
                    onChanged: (value) {
                      setState(() {
                        widget.items[index].done = value;
                        save();
                      });
                    },
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          add();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
