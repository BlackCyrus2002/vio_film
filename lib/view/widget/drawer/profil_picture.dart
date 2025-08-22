import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfilPicture extends StatelessWidget {
  const ProfilPicture({super.key, required this.getImage, required this.username, required this.image});
  final Function getImage;
  final String username;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
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
                    File(image!),
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
                ),
              ),
              IconButton(
                onPressed: (() => getImage(ImageSource.gallery)),
                icon: Icon(
                  Icons.photo_library,
                  size: 30,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
