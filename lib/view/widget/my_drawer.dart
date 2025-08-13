import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../datas/drawer_data.dart';
import '../../model/drawer_model.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  List<DrawerModel> drawerElements = DrawerData().drawerElements;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: 210,
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
                margin: EdgeInsets.only(top: 145),
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: CircleAvatar(
                      radius: 68,
                      backgroundImage: AssetImage("assets/vio_film.png"),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            "Assan Cyriac",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
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
                  leading: Icon(drawerElements[index].leading,color: Colors.black,),
                  title: Text(
                    drawerElements[index].title,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(drawerElements[index].trailing,color: Colors.orange),
                  subtitle: Text(drawerElements[index].subTitle),
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
