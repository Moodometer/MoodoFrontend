import 'package:moodometer/data/provider/user.provider.dart';

class UserRepository {
  late final UserDataProvider userDataProvider = UserDataProvider();

  /* Future<List<UserModel>> getDatafromServer() async {
    final rawData = await userDataProvider.getUser();
    List<UserModel> userData = List<UserModel>.from(
        json.decode(rawData).map((x) => UserModel.fromMap(x)));


    return userData;
  } */
}
