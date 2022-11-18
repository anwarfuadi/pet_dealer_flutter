import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String name = "Nama";
  String email = "email@email.com";

  @override
  void initState() {
    _loadPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: name,
            icon: "assets/icons/User Icon.svg",
            press: () => {},
          ),
          ProfileMenu(
            text: email,
            icon: "assets/icons/Mail.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            icon2: Icons.arrow_forward_ios,
            press: () async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove("email");
              prefs.remove("name");
              Navigator.pushNamedAndRemoveUntil(context, SignInScreen.routeName, ModalRoute.withName(SignInScreen.routeName));
            },
          ),
        ],
      ),
    );
  }
  
  void _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.get("name").toString();
      email = prefs.get("email").toString();
    });
  }
}
