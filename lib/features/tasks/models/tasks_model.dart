import 'package:equatable/equatable.dart';

class TasksModel extends Equatable {
  final int? id;
  final String title;
  final String description;

  const TasksModel({this.id, required this.title, required this.description});

  factory TasksModel.fromJson(Map<String, dynamic> json) => TasksModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description};
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, description];
}
