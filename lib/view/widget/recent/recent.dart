import 'package:flutter/material.dart';

class Recent extends StatefulWidget {
  const Recent({super.key});

  @override
  State<Recent> createState() => _RecentState();
}

class _RecentState extends State<Recent> {
  bool see = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(
      milliseconds: 500,
    ), () {
      setState(() {
        see = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: see ? Text("Aucun trailler visionné") :  CircularProgressIndicator(),
      ),
    );
  }
}
