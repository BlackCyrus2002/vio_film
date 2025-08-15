import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:vio_film/model/user_model.dart';
import 'package:vio_film/provider/user_provider.dart';
import 'package:vio_film/services/database_client.dart';
import 'package:provider/provider.dart';
import 'package:vio_film/view/widget/home/loading_drawer.dart';
import '../../datas/drawer_data.dart';
import '../../model/drawer_model.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<UserProvider>().getUser());
  }

  @override
  Widget build(BuildContext context) {
    user = context.watch<UserProvider>().user;
    if (user == null) {
      return Drawer(child: LoadingDrawer());
    }
    List<DrawerModel> drawerElements = DrawerData().drawerElements(user!);
    return Drawer(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/vio_film.png"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withValues(alpha: 0.8),
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.16,
                ),
                child: Container(
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
                      child: (user!.image == null)
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
                              backgroundImage: FileImage(File(user!.image!)),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            (user == null) ? "Nom complet" : user!.name,
            maxLines: 1,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            (user == null) ? "Email" : user!.email,
            maxLines: 1,
            style: GoogleFonts.poppins(),
          ),
          Divider(),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            drawerElements[index].widget,
                      ),
                    );
                  },
                  leading: Icon(drawerElements[index].leading),
                  title: Text(
                    drawerElements[index].title,
                    maxLines: 1,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    drawerElements[index].trailing,
                    color: Colors.orange,
                  ),
                  subtitle: Text(
                    drawerElements[index].subTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: drawerElements.length,
            ),
          ),
        ],
      ),
    );
  }
}
