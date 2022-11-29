import 'package:boarding_group/app/model/admin_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/user_model.dart';

class Auth {
  static var user = StateProvider<UserModel>((ref) => UserModel());
  static var admin = StateProvider<AdminModel>((ref) => AdminModel());
  static var device = StateProvider<String>((ref) => '');
}
