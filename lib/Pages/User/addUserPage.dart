import 'package:flutter/material.dart';
import 'package:todolist/Models/User.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  var name = TextEditingController();
  var lastName = TextEditingController();
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // limpa o no focus quando o form for liberado.
    myFocusNode.dispose();
    super.dispose();
  }

  Widget okButton() {
    return FlatButton(
      child: Text("OK"),
      onPressed: () {},
    );
  }

  _addUser(BuildContext ctx) {
    if (name.text.isEmpty ||
        name.text == '' ||
        lastName.text.isEmpty ||
        lastName.text == '') {
      // _showDialog(ctx);
      showDialog(
          context: ctx,
          builder: (BuildContext ctx) {
            return _showDialog(ctx);
          });
    } else {
      // _user = new Object(name);
      Navigator.pop(
          context,
          new User(
            name: name.text,
            lastName: lastName.text,
            isActive: false,
          ));
    }
  }

  _cancel(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar usuário"),
      ),
      body: Column(
        children: [
          TextField(
            controller: name,
            autofocus: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.person),
                hintText: 'Informe nome'),
          ),
          // o segundo campo texto tem o foco quando o usuário
          // clica no botão FloatingActionButton.
          TextField(
            controller: lastName,
            focusNode: myFocusNode,
            decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.mail),
                hintText: 'Informe sobrenome'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    _cancel(context);
                  },
                  child: Text("Cancelar"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                ),
                Text(" "),
                TextButton(
                  onPressed: () {
                    _addUser(context);
                  },
                  child: Text("Salvar"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _showDialog(BuildContext ctx) {
    return AlertDialog(
      title: new Text("Alert Dialog titulo"),
      content: new Text("Alert Dialog body"),
      actions: <Widget>[
        // define os botões na base do dialogo
        new TextButton(
          child: new Text("Fechar"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
