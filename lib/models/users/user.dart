// Collection Name /alcoholics/{alcoholicId}

import '../converter.dart';
import '../locations/supported_area.dart';
import 'abstract_user.dart';

// Collection Name /alcoholics/alcoholicId
// groups_crud -> group_resources_crud ->  create_group_resources_front_end
class User extends AbstractUser {
  SupportedArea area;
  String username;

  User({
    required userId,
    required phoneNumber,
    required profileImageURL,
    required this.area,
    required this.username,
    required password,
  }) : super(
         userId: userId,
         phoneNumber: phoneNumber,
         profileImageURL: profileImageURL,
         password: password,
       );

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = super.toJson();

    map.addAll({'area': area.toJson(), 'username': username});

    return map;
  }

  String myAreaAsString() {
    return Converter.asString(area.sectionName);
  }

  factory User.fromJson(dynamic json) => User(
    userId: json['userId'],
    profileImageURL: json['profileImageURL'],
    phoneNumber: json['phoneNumber'],
    area: SupportedArea.fromJson(json['area']),
    username: json['username'],
    password: json['password'],
  );
}
