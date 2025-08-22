import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vio_film/view/home_page.dart';

import '../../../services/database_client.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController? nameController;
  TextEditingController? numberController;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  bool passwordVisible = false;
  final _formKey = GlobalKey<FormState>();

  String? image;

  @override
  void initState() {
    nameController = TextEditingController();
    numberController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController!.dispose();
    numberController!.dispose();
    emailController!.dispose();
    passwordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.orange.shade300),
      body: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.orange.shade300, Colors.blue.shade200],
            ),
          ),
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "S'enregistrer",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: GoogleFonts.poppins(),
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: "Nom complet",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Icon(Icons.person, color: Colors.black),
                        ),
                        validator: (value) {
                          if (value == null || nameController!.text.isEmpty) {
                            return 'Veuillez entrer votre nom complet';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: emailController,
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
                          if (value == null || emailController!.text.isEmpty) {
                            return 'Votre email est obligatoire';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !passwordVisible,
                        decoration: InputDecoration(
                          labelText: "Mot de passe",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Icon(Icons.password, color: Colors.black),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                            icon: (passwordVisible)
                                ?Icon(Icons.visibility_off)
                                : Icon(Icons.visibility, color: Colors.black),
                            color: Colors.black,
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              passwordController!.text.isEmpty) {
                            return 'Veuillez entrer un mot de passe';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      IntlPhoneField(
                        languageCode: "Fr",
                        searchText: "Rechercher un pays",
                        controller: numberController,
                        validator: (value) {
                          if (value == null || numberController!.text.isEmpty) {
                            return 'Veuillez entrer votre numéro de téléphone';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {});
                        },
                        initialCountryCode: "CI",
                        decoration: InputDecoration(
                          labelText: 'Numéro de téléphone',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 70,
                  child: Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: image != null
                          ? DecorationImage(
                              image: FileImage(File(image!)),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: (() => getImage(ImageSource.camera)),
                      icon: Icon(
                        Icons.camera_alt,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: (() => getImage(ImageSource.gallery)),
                      icon: Icon(
                        Icons.photo_library,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: (() {
                    if (_formKey.currentState!.validate()) {
                      addUser(
                        nameController!.text,
                        numberController!.text,
                        emailController!.text,
                        passwordController!.text,
                      );
                    }
                  }),
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontWeight: FontWeight.bold),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text("Enregistrer"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getImage(ImageSource source) async {
    XFile? imageSource = await ImagePicker().pickImage(source: source);
    if (imageSource == null) return;
    setState(() {
      image = imageSource.path;
    });
  }

  addUser(String name, String number, String email, String password) async {
    await DataBaseClient().addUser(name, number, email, image, password).then((
      success,
    ) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage(title: "Vio Film")),
      );
    });
  }
}
