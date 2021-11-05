import 'package:doitnow/controllers/drawer_controller.dart';
import 'package:flutter/material.dart';
import 'package:doitnow/screens/tasks/todo_list_screen.dart';
import 'package:get_it/get_it.dart';

class Auth extends StatefulWidget {

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final formKey = GlobalKey<FormState>();

  late String email, password;

  Color blueColor = Color(0xFF2D55A1);
  
  final _controller = GetIt.I<CustomDrawerController>();


  //To check fields during submit
  checkFields() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //To Validate email
  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Insira um E-mail válido';
    else
      return 'Senha';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: formKey,
          child: _buildLoginForm(),
        ),
      ),
    );
  }

  _buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: ListView(
        children: [
          SizedBox(
            height: 75.0,
          ),
          Container(
            height: 125.0,
            width: 200.0,
            child: Stack(
              children: [
                Text(
                  'Do It Now',
                  style: TextStyle(
                    fontSize: 60.0,
                  ),
                ),
                Positioned(
                  top: 63.0,
                  left: 10.0,
                  child: Text(
                    'Mantenha suas tarefas organizadas',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'E-MAIL',
                labelStyle: TextStyle(
                    fontSize: 12.0, color: Colors.grey.withOpacity(0.5)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: blueColor),
                )),
            onChanged: (value) {
              this.email = value;
            },
            validator: (value) => value!.isEmpty ? 'Insira um e-mail' : null,
          ),
          TextFormField(
              decoration: InputDecoration(
                  labelText: 'SENHA',
                  labelStyle: TextStyle(
                      fontSize: 12.0, color: Colors.grey.withOpacity(0.5)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: blueColor),
                  )),
              obscureText: true,
              onChanged: (value) {
                this.password = value;
              },
              validator: (value) =>
              value!.isEmpty ? 'Insira a senha' : null),
          SizedBox(height: 5.0),
          GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Container()));
              },
              child: Container(
                  alignment: Alignment(1.0, 0.0),
                  padding: EdgeInsets.only(top: 15.0, left: 20.0),
                  child: InkWell(
                      child: Text('Esqueci a senha',
                          style: TextStyle(
                              color: blueColor,
                              fontSize: 11.0,
                              decoration: TextDecoration.underline))))),
          SizedBox(height: 50.0),
          GestureDetector(
            onTap: () {
              if (checkFields()) {
                _controller.setCurrentIndex(3);
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => TodoListScreen()),
                );
                print('Passou');
              }
            },
            child: Container(
                height: 50.0,
                child: Material(
                    borderRadius: BorderRadius.circular(25.0),
                    // shadowColor: Colors.greenAccent,
                    color: blueColor,
                    elevation: 4.0,
                    child: Center(
                        child: Text('LOGIN',
                            style: TextStyle(color: Colors.white))))),
          ),
        ],
      ),
    );
  }
}