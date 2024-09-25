import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_management/common_widgets/custom_button.dart';
import 'package:tasks_management/common_widgets/custom_loading_button.dart';
import 'package:tasks_management/common_widgets/custom_text_field.dart';

import 'package:tasks_management/features/tasks/cubit/tasks_cubit.dart';
import 'package:tasks_management/features/tasks/models/tasks_model.dart';
import 'package:tasks_management/features/tasks/presentation/widget/custom_card.dart';
import 'package:tasks_management/theme_manager/font_family_manager.dart';
import 'package:tasks_management/theme_manager/space_manager.dart';
import 'package:tasks_management/theme_manager/value_manager.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key, required this.tab});
  final int tab;

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  int taskId = 0;
  String titleTasks = '';
  String descTasks = '';
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController descController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController(text: titleTasks);
    descController = TextEditingController(text: descTasks);
    context.read<TasksCubit>().getTasks();
  }

  @override
  void didUpdateWidget(covariant TasksScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    deleteItem(taskId);
    _showBottomSheet(context, taskId);
    _formWidget(taskId);
    titleController = TextEditingController(text: titleTasks);
    descController = TextEditingController(text: descTasks);
  }

  void deleteItem(int id) {
    context.read<TasksCubit>().deleteTask(id);
  }

  Widget _formWidget(int id) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 45),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.0.spaceY,
              const Text(
                "CRUD",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              48.0.spaceY,
              CustomTextField(
                  keyboardType: TextInputType.text,
                  controller: titleController,
                  title: "Title"),
              16.0.spaceY,
              CustomTextField(
                  keyboardType: TextInputType.text,
                  controller: descController,
                  title: "Description"),
              38.0.spaceY,
              BlocBuilder<TasksCubit, TasksState>(
                builder: (context, state) {
                  if (state is TasksLoading) {
                    return const Center(child: CustomLoadingButton());
                  }
                  if (state is TasksFailed) {
                    final message = state.message;
                    if (message.isNotEmpty) {
                      ValueManager.customToast(message);
                    }
                  }

                  return CustomButton(
                      onPressed: () {
                        context.read<TasksCubit>().updateTask(
                            id,
                            TasksModel(
                              title: titleController.text,
                              description: descController.text,
                            ));
                        Navigator.pop(context);
                        context.read<TasksCubit>().getTasks();
                      },
                      title: "Update");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // BottomSheet content
  void _showBottomSheet(BuildContext context, int id) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.65,
          maxChildSize: 1.0,
          minChildSize: 0.3,
          expand: false,
          builder: (context, scrollController) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 1.0,
              child: _formWidget(id),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Tasks Lists",
            style: blackExtraBoldTextStyle.copyWith(fontSize: 16),
          ),
        ),
        body: BlocBuilder<TasksCubit, TasksState>(
          builder: (context, state) {
            if (state is TasksLoading) {
              return const Center(
                child: CustomLoadingButton(),
              );
            }
            if (state is TasksFailed) {
              String message = state.message;

              if (message.isNotEmpty) {
                ValueManager.customToast(message);
              }
            }
            if (state is TasksSuccess) {
              final data = state.tasks;
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    taskId = data[index].id!;
                    titleTasks = data[index].title;
                    descTasks = data[index].description;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: CustomCard(
                          title: data[index].title,
                          desc: data[index].description,
                          onPressDel: () {
                            deleteItem(taskId);
                            context.read<TasksCubit>().getTasks();
                          },
                          onPressEdt: () {
                            _showBottomSheet(context, data[index].id!);
                            titleController =
                                TextEditingController(text: data[index].title);
                            descController = TextEditingController(
                                text: data[index].description);
                          }),
                    );
                  });
            }
            return Container();
          },
        ));
  }
}
