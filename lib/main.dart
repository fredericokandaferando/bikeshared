import 'package:bikeshared/Usuario/serviceLogin.dart';
import 'package:bikeshared/constantes/shered_preference.dart';
import 'package:bikeshared/home_widgets/home_pricipalpage.dart';
import 'package:flutter/material.dart';

import 'package:bikeshared/Usuario/CadastrarUser.dart';

void main() => runApp(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );

TextEditingController emailControllerr = TextEditingController();
TextEditingController passwordController = TextEditingController();

final _formKey = GlobalKey<FormState>();
ServiceLogin login = ServiceLogin();

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Color.fromARGB(255, 105, 51, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "BikeShared",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: emailControllerr,
                          decoration: const InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 114, 56, 2)),
                            border: OutlineInputBorder(),
                          ),
                          validator: (email) {
                            if (email == null || email.isEmpty) {
                              return 'Digite seu Nome';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: "Senha",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 114, 56, 2)),
                            border: OutlineInputBorder(),
                          ),
                          validator: (senha) {
                            if (senha == null || senha.isEmpty) {
                              return 'Digite a sua senha';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              login.login(emailControllerr.text,
                                  passwordController.text, context);
                              MySharedPreferences.useremail =
                                  emailControllerr.text;
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(350, 50),
                            backgroundColor: Color.fromARGB(255, 114, 56, 2),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => home_usuarioRegister()),
                            );
                          },
                          child: const Text(
                            "Cadastrar-se",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Aqui está a imagem
            ],
          ),
        ),
      ),
    );
  }
}
