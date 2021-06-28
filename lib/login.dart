import 'package:cupoappfinal/services/logonservice.dart';
import 'package:cupoappfinal/userprofileheader.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Color primaryColor = Colors.orange;
  Color secondaryColor = Colors.orangeAccent;

  @override
  Widget build(BuildContext context) {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            Text('Logueate en nuestra aplicacion para continuar',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(color: Colors.black, fontSize: 28)),
            SizedBox(height: 20),
            Text(
              'Ingresar tu correo y contraseña para continuar!',
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(color: Colors.black, fontSize: 14),
            ),
            SizedBox(height: 10),
            Image.asset(
              'assets/4.png',
              width: 100,
              height: 100,
            ),
            buildTextField('UserName', Icons.account_circle),
            SizedBox(height: 10),
            buildTextField('Password', Icons.lock),
            SizedBox(height: 10),
            MaterialButton(
              elevation: 0,
              minWidth: double.maxFinite,
              height: 50,
              onPressed: () {
                Navigator.pushNamed(context, '/todo');
              },
              color: primaryColor,
              child: Text('Login',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              textColor: Colors.white,
            ),
            SizedBox(height: 20),
            MaterialButton(
              elevation: 0,
              minWidth: double.maxFinite,
              height: 50,
              onPressed: () async {
                bool success = await loginService.signInWithGoogle();
                if (success) {
                  Navigator.pushNamed(context, '/todo');
                }
              },
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.google),
                  SizedBox(width: 10),
                  Text('Sign-in Using google'),
                ],
              ),
              textColor: Colors.white,
            ),
            SizedBox(height: 10),
            _buildFooter(),
          ],
        ),
      ),
    );
  }
}

//function
_buildFooter() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Aiuda',
        textAlign: TextAlign.center,
        style: GoogleFonts.openSans(
            color: Colors.grey[900],
            fontSize: 15,
            fontWeight: FontWeight.normal),
      )
    ],
  );
}

buildTextField(String labelText, IconData icon) {
  return Container(
      decoration: BoxDecoration(
          color: Colors.transparent, border: Border.all(color: Colors.grey)),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle:
                TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
            icon: Icon(
              icon,
              color: Colors.black,
            ),
            border: InputBorder.none),
        style: TextStyle(color: Colors.white),
      ));
}
