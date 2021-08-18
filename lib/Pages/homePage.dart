import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Luciano Oliveira"),
              accountEmail: Text("luciano.oliveira@gmail.com"),
              currentAccountPicture: CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(
                    'https://media-exp1.licdn.com/dms/image/C5103AQH9wG4A9Wxcew/profile-displayphoto-shrink_200_200/0/1517366457850?e=1633564800&v=beta&t=QvBd6dNj-nnSOHicEQ0okIBkJZCfqUM210mTQy_7jS4'),
                backgroundColor: Colors.transparent,
              ),
            ),
            ListTile(
              leading: Icon(Icons.supervised_user_circle),
              title: Text("Items"),
              subtitle: Text("Items cadastrados"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushNamed(context, "/items");
              },
            ),
            ListTile(
              leading: Icon(Icons.supervised_user_circle),
              title: Text("Usuários"),
              subtitle: Text("Usuários cadastrados"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushNamed(context, "/users");
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text("Perfis"),
              subtitle: Text("Perfis de usuários..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushNamed(context, "/profiles");
              },
            ),
            ListTile(
              leading: Icon(Icons.location_city_rounded),
              title: Text("Endereços"),
              subtitle: Text("Endereços disponíveis"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushNamed(context, "/addresses");
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text("Filmes Favoritos"),
              subtitle: Text("Filmes favoritos..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text("Mensagens"),
              subtitle: Text("Mensagens e Notificações"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushNamed(context, "/messages");
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Configurações"),
              subtitle: Text("Configurações do app"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushNamed(context, "/configurations");
              },
            ),
          ],
        ),
      ),
    );
  }
}
