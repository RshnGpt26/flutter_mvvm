import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:project1/data/response/api_response.dart';
import 'package:project1/model/student_model.dart';

import '../repo/home_repo.dart';

class HomeViewModel with ChangeNotifier {
  final _myRepo = HomeRepo();

  ApiResponse<StudentModel> studentsList = ApiResponse.loading();

  setStudentsList(ApiResponse<StudentModel> response) {
    studentsList = response;
    notifyListeners();
  }

  Future<void> fetchStudentsList() async {
    setStudentsList(ApiResponse.loading());
    _myRepo.fetchStudentsList().then(
      (value) {
        print(value);
        setStudentsList(ApiResponse.completed(value));
      },
    ).onError(
      (error, stackTrace) {
        setStudentsList(ApiResponse.error(error.toString()));
      },
    );
  }
}
