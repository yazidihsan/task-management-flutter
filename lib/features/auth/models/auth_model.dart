import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  final String? name;
  final String email;
  final String password;

  const AuthModel({this.name, required this.email, required this.password});

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
      name: json['name'], email: json['email'], password: json['password']);

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'password': password};
  }

  @override
  // TODO: implement props
  List<Object?> get props => [name, email, password];
}
