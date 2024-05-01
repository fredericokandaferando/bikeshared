import 'package:bikeshared/Usuario/serviceUser.dart';
import 'package:flutter/material.dart';

class home_usuarioRegister extends StatefulWidget {
  const home_usuarioRegister({super.key});

  @override
  State<home_usuarioRegister> createState() => _home_usuarioRegisterState();
}

class _home_usuarioRegisterState extends State<home_usuarioRegister> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  //create the service class object
  ServiceResisterUser service = ServiceResisterUser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastra-te no BikeShared',
              style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 114, 56, 2),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: nomeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Nome',
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 114, 56, 2)),
                    ),
                    validator: (nome) {
                      if (nome == null || nome.isEmpty) {
                        return 'Digite o Nome';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 114, 56, 2)),
                  ),
                  validator: (email) {
                    if (email == null || email.isEmpty) {
                      return 'Digite o Email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  controller: senhaController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Senha',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 114, 56, 2)),
                  ),
                  validator: (senha) {
                    if (senha == null || senha.isEmpty) {
                      return 'Digite a Senha';
                    } else if (senha.length < 5) {
                      return 'Digite uma senha mais forte';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      service.saveUser(10, 2, nomeController.text,
                          emailController.text, senhaController.text, context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 148, 81, 4)),
                  child: const Text('Registar',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                )
              ],
            ),
          ),
        ));
  }
}
