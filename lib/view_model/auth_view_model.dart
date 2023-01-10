import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../repo/auth_repo.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import 'user_view_model.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepo();

  bool _isLoginLoading = false;
  bool _isSignUpLoading = false;

  bool get isLoginLoading => _isLoginLoading;
  bool get isSignUpLoading => _isSignUpLoading;

  setLoginLoading(bool value) {
    _isLoginLoading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _isSignUpLoading = value;
    notifyListeners();
  }

  Future<void> login(Map data, BuildContext context) async {
    setLoginLoading(true);
    _myRepo.login(data).then(
      (value) {
        final userPreferences =
            Provider.of<UserViewModel>(context, listen: false);
        userPreferences.saveUser(UserModel(token: value["token"]));
        setLoginLoading(false);
        Utils.flushBarErrorMessage("Success Login", context);
        Navigator.pushNamed(context, RoutesName.home);
        log(value.toString());
        if (kDebugMode) {
          print(value.toString());
        }
      },
    ).onError(
      (error, stackTrace) {
        setLoginLoading(false);
        Utils.flushBarErrorMessage(error.toString(), context);
        log(error.toString());
        if (kDebugMode) {
          print(error.toString());
        }
      },
    );
  }

  Future<void> signUp(Map data, BuildContext context) async {
    setSignUpLoading(true);
    _myRepo.signUp(data).then(
      (value) {
        setSignUpLoading(false);
        final userPreferences =
            Provider.of<UserViewModel>(context, listen: false);
        userPreferences.saveUser(UserModel(token: value["token"]));
        Utils.flushBarErrorMessage("Success Sign Up", context);
        Navigator.pushNamed(context, RoutesName.home);
        log(value.toString());
        if (kDebugMode) {
          print(value.toString());
        }
      },
    ).onError(
      (error, stackTrace) {
        setSignUpLoading(false);
        Utils.flushBarErrorMessage(error.toString(), context);
        log(error.toString());
        if (kDebugMode) {
          print(error.toString());
        }
      },
    );
  }
}
