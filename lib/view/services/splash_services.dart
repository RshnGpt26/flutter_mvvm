import 'package:flutter/cupertino.dart';

import '../../model/user_model.dart';
import '../../utils/routes/routes_name.dart';
import '../../view_model/user_view_model.dart';

class SplashServices {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    getUserData().then(
      (value) async {
        if (value.token == null || value.token == "") {
          Future.delayed(
            const Duration(milliseconds: 500),
            () {
              Navigator.pushNamed(context, RoutesName.login);
            },
          );
        } else {
          await Future.delayed(
            const Duration(milliseconds: 500),
            () {
              Navigator.pushNamed(context, RoutesName.home);
            },
          );
        }
      },
    );
  }
}
