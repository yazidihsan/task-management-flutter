import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String name;
  final String email;

  const UserModel({required this.name, required this.email});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(name: json['name'], email: json['email']);

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email};
  }

  @override
  // TODO: implement props
  List<Object?> get props => [name, email];
}
