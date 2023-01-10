class StudentModel {
  String? id;
  String? studentName;
  String? studentEmail;
  StudentModel({
    this.id,
    this.studentName,
    this.studentEmail,
  });
  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        id: json["_id"] ?? "",
        studentName: json["studentName"] ?? "",
        studentEmail: json["studentEmail"] ?? "",
      );
}
