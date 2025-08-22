import 'package:flutter/material.dart';

import '../../../services/database_client.dart';

class EditPassword extends StatefulWidget {
  const EditPassword({
    super.key,
    required this.emailController,
    required this.id,
    required this.oldPasswordController,
  });

  final TextEditingController emailController;
  final TextEditingController oldPasswordController;
  final int id;

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  TextEditingController? passwordController;
  TextEditingController? confirmPasswordController;
  bool passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    passwordController!.dispose();
    confirmPasswordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modifier le mot de passe"),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        TextFormField(
                          readOnly: true,
                          controller: widget.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: Icon(
                              Icons.alternate_email,
                              color: Colors.black,
                            ),
                          ),
                          validator: (value) {
                            if (value == null ||
                                widget.emailController.text.isEmpty) {
                              return 'Votre email est obligatoire';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Ancien mot de passe",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: Icon(
                              Icons.password,
                              color: Colors.black,
                            ),
                          ),
                          validator: (value) {
                            if (value == null ||
                                passwordController!.text.isEmpty) {
                              return 'Veuillez entrer un mot de passe';
                            }
                            if(widget.oldPasswordController.text.isNotEmpty){
                              if(widget.oldPasswordController.text != passwordController!.text){
                                return 'Le mot de passe est incorrect';
                              }
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: confirmPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !passwordVisible,
                          decoration: InputDecoration(
                            labelText: "Nouveau mot de passe",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: Icon(
                              Icons.password,
                              color: Colors.black,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                              icon: (passwordVisible)
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility, color: Colors.black),
                              color: Colors.black,
                            ),
                          ),
                          validator: (value) {
                            if (value == null ||
                                confirmPasswordController!.text.isEmpty) {
                              return 'Veuillez entrer un mot de passe';
                            }

                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue.shade600,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {

                            if (_formKey.currentState!.validate()) {
                              editPassword(
                                widget.emailController.text,
                                confirmPasswordController!.text,
                              );
                            }
                          },
                          child: Text("Modifier"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  editPassword(String email, String password) async {

    await DataBaseClient().editPass(email, password).then((value) {
      const snackBar = SnackBar(
        backgroundColor: Colors.green,
        content: Text('Mot de passe modifié!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
    });
  }
}
