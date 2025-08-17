import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:vio_film/model/user_model.dart';
import 'package:vio_film/services/database_client.dart';
import 'package:vio_film/view/pages/signup/signup.dart';

class SeeEditInfo extends StatefulWidget {
  const SeeEditInfo({super.key, required this.user});

  final UserModel user;

  @override
  State<SeeEditInfo> createState() => _SeeEditInfoState();
}

class _SeeEditInfoState extends State<SeeEditInfo> {
  TextEditingController? nameController;
  TextEditingController? numberController;
  TextEditingController? emailController;
  String username = "";
  String? image;
  UserModel? updatedUser;

  @override
  void initState() {
    nameController = TextEditingController();
    numberController = TextEditingController();
    emailController = TextEditingController();
    myInfo();
    super.initState();
  }

  @override
  void dispose() {
    nameController!.dispose();
    numberController!.dispose();
    emailController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    image = widget.user.image;
    return Scaffold(
      appBar: AppBar(
        title: Text("Mon profil"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (() => updateInfo(
              widget.user.id,
              nameController!.text,
              numberController!.text,
              emailController!.text,
              image,
            )),
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Colors.black38,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: (image == null)
                          ? Skeletonizer(
                              enabled: true,
                              child: CircleAvatar(
                                radius: 68,
                                backgroundImage: AssetImage(
                                  "assets/vio_film.png",
                                ),
                              ),
                            )
                          : CircleAvatar(
                              radius: 68,
                              backgroundImage: FileImage(
                                File(widget.user.image!),
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  username,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                SizedBox(height: 10),
                Divider(thickness: 2),
                SizedBox(height: 10),
                Text(
                  "Modifier mes information",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: nameController,
                  style: GoogleFonts.poppins(),
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "Nom complet",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.person),
                  ),
                  onTap: () {
                    username = nameController!.text;
                    setState(() {});
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
                SizedBox(height: 10),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                ),
                SizedBox(height: 30),
                Divider(thickness: 2),
                SizedBox(height: 10),
                Text(
                  "Supprimer mon compte",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: (() => deleteUser(widget.user.id)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    foregroundColor: Colors.white
                  ),
                  child: Text("Supprimer mon compte"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  myInfo() async {
    nameController!.text = widget.user.name;
    numberController!.text = widget.user.number;
    emailController!.text = widget.user.email;
    username = widget.user.name;
  }

  updateInfo(
    int id,
    String name,
    String number,
    String email,
    String? image,
  ) async {
    await DataBaseClient().updateUser(id, name, number, email, image).then((
      user,
    ) {
      const snackBar = SnackBar(
        backgroundColor: Colors.green,
        content: Text('Informations mises à jour!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      UserModel userUpdate = widget.user;
      userUpdate.name = name;
      userUpdate.number = number;
      userUpdate.email = email;
      userUpdate.image = image;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SeeEditInfo(
            user: userUpdate,
          ), // si tu récupères les nouvelles infos
        ),
      );
    });
  }

  getImage(ImageSource source) async {
    XFile? imageSource = await ImagePicker().pickImage(source: source);
    if (imageSource == null) return;
    setState(() {
      image = imageSource.path;
      updateInfo(
        widget.user.id,
        nameController!.text,
        numberController!.text,
        emailController!.text,
        image,
      );
    });
  }

  deleteUser(int id) async {
    await DataBaseClient().deleteUser(id).then((success) {
      const snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Vous avez supprimé votre compte!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Signup()),
          (Route<dynamic> route) => false
      );
    });
  }
}
