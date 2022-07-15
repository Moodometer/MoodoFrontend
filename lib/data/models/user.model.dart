class UserModel {
  final int id;
  late String? deviceId;
  late String phonenumber;
  late int mood;

  UserModel({
    required this.id,
    required this.deviceId,
    required this.phonenumber,
    required this.mood,
  });
}
