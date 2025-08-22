import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key, required this.deleteUser, required this.id});
  final Function deleteUser;
  final int id;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
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
            onPressed: (() => deleteUser(id)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              foregroundColor: Colors.white,
            ),
            child: Text("Supprimer mon compte"),
          ),
        ],
      )
    );
  }
}
