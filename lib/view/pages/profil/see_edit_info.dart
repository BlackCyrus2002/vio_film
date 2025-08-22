import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:vio_film/model/user_model.dart';
import 'package:vio_film/services/database_client.dart';
import 'package:vio_film/view/pages/signup/signup.dart';
import 'package:vio_film/view/widget/drawer/delete_account.dart';
import 'package:vio_film/view/widget/drawer/input_information.dart';
import 'package:vio_film/view/widget/drawer/profil_picture.dart';

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
  TextEditingController? passwordController;
  bool passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
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
            onPressed: (() {
              if (_formKey.currentState!.validate()) {
                updateInfo(
                  widget.user.id,
                  nameController!.text,
                  numberController!.text,
                  emailController!.text,
                  image,
                );
              }
            }),
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
                ProfilPicture(
                  getImage: getImage,
                  username: username,
                  image: image,
                ),
                Divider(thickness: 2),
                SizedBox(height: 10),
                InputInformation(
                  nameController: nameController,
                  numberController: numberController,
                  emailController: emailController,
                  passwordVisible: passwordVisible,
                  formKey: _formKey,
                  id: widget.user.id,
                  password: widget.user.password,
                ),
                Divider(thickness: 2),
                DeleteAccount(deleteUser: deleteUser, id: widget.user.id)
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
          ),
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
        (Route<dynamic> route) => false,
      );
    });
  }
}
