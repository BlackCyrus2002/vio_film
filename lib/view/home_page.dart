import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:vio_film/services/database_client.dart';
import 'package:vio_film/view/pages/signup/signup.dart';
import 'package:vio_film/view/widget/my_drawer.dart';

import '../datas/navbar_datas.dart';
import '../datas/pages_datas.dart';
import '../model/user_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List navBar = NavbarDatas().tabBarElements;
  List pages = PagesDatas().pages;
  int currentIndex = 0;
  List<UserModel> users = [];

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) return Signup();

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text(
          widget.title,
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.video_collection)),
        ],
      ),

      body: pages[currentIndex].pages,
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: GNav(
          tabBorderRadius: 25,
          tabActiveBorder: Border.all(width: 1),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          selectedIndex: currentIndex,
          onTabChange: (int index) => {
            setState(() {
              currentIndex = index;
            }),
          },
          tabs: navBar.map((element) {
            return GButton(
              icon: element.iconUnSelectedData,
              text: element.title,
            );
          }).toList(),
        ),
      ),
    );
  }

  getUser() async {
    users = await DataBaseClient().takeUser();
    setState(() {});
  }
}
