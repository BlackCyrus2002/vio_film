import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../pages/profil/edit_password.dart';

class InputInformation extends StatefulWidget {
  const InputInformation({
    super.key,
    required this.nameController,
    required this.numberController,
    required this.emailController,
    required this.passwordVisible,
    required this.formKey,
    required this.id, required  this.password,
  });

  final TextEditingController? nameController;
  final TextEditingController? numberController;
  final TextEditingController? emailController;
  final String password;
  final bool passwordVisible;
  final GlobalKey<FormState> formKey;
  final int id;

  @override
  State<InputInformation> createState() => _InputInformationState();
}

class _InputInformationState extends State<InputInformation> {
  TextEditingController? passwordController;

  @override
  void initState() {
    passwordController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    passwordController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    passwordController!.text = widget.password;
    return SizedBox(
      child: Column(
        children: [
          Text(
            "Modifier mes information",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),
          Form(
            key: widget.formKey,
            child: Column(
              children: [
                TextFormField(
                  style: GoogleFonts.poppins(),
                  controller: widget.nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "Nom complet",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || widget.nameController!.text.isEmpty) {
                      return 'Veuillez entrer votre nom complet';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: widget.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                  validator: (value) {
                    if (value == null || widget.emailController!.text.isEmpty) {
                      return 'Votre email est obligatoire';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),

                IntlPhoneField(
                  languageCode: "Fr",
                  searchText: "Rechercher un pays",
                  controller: widget.numberController,
                  validator: (value) {
                    if (value == null ||
                        widget.numberController!.text.isEmpty) {
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
          SizedBox(height: 30),
          Row(
            children: [
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPassword(
                        emailController: widget.emailController!,
                        id: widget.id,
                        oldPasswordController: passwordController!,
                      ),
                    ),
                  );
                },
                child: Text("Modifier le mot de passe"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
