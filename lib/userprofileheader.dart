import 'package:cupoappfinal/models/loginusermodel.dart';
import 'package:cupoappfinal/services/logonservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class UserProfileheader extends StatelessWidget {
  bool showProfilePic;
  UserProfileheader({required this.showProfilePic});
  @override
  Widget build(BuildContext context) {
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    LoginUserModel? userModel = loginService.loggedInUserModel;
    String imgPath = userModel != null ? userModel.photoUrl : '';
    return this.showProfilePic && imgPath.length > 0
        ? Container(
            margin: EdgeInsets.only(right: 10),
            padding: EdgeInsets.all(10),
            child: ClipOval(
              child: Image.network(imgPath),
            ),
          )
        : SizedBox(width: 40, height: 40);
  }
}
