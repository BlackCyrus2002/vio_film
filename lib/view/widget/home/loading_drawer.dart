import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LoadingDrawer extends StatelessWidget {
  const LoadingDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
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
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: CircleAvatar(radius: 68),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            "Nom complet",
            maxLines: 1,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text("Email", maxLines: 1, style: GoogleFonts.poppins()),
          Divider(),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {},
                  leading: Icon(Icons.list),
                  title: Text(
                    "Chargement...",
                    maxLines: 1,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange),
                  subtitle: Text(
                    "Chargement...",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: 6,
            ),
          ),
        ],
      ),
    );
  }
}
