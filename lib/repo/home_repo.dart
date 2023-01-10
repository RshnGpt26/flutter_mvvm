import 'package:project1/model/student_model.dart';

import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../res/app_url.dart';

class HomeRepo {
  final BaseApiServices _apiServices = NetworkApiServices();
  Future<StudentModel> fetchStudentsList() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.studentsUrl);
      return StudentModel.fromJson(response.map((e) => e));
    } catch (e) {
      rethrow;
    }
  }
}
