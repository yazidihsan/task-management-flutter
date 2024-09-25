import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_management/common_widgets/bottom_nav_bar.dart';
import 'package:tasks_management/common_widgets/custom_button.dart';
import 'package:tasks_management/common_widgets/custom_loading_button.dart';
import 'package:tasks_management/common_widgets/custom_text_field.dart';
import 'package:tasks_management/features/auth/cubit/auth_cubit.dart';
import 'package:tasks_management/features/auth/presentation/screen/profile_screen.dart';
import 'package:tasks_management/features/tasks/cubit/tasks_cubit.dart';
import 'package:tasks_management/features/tasks/models/nav_model.dart';
import 'package:tasks_management/features/tasks/models/tasks_model.dart';
import 'package:tasks_management/features/tasks/presentation/screen/tasks_screen.dart';
import 'package:tasks_management/theme_manager/color_manager.dart';
import 'package:tasks_management/theme_manager/space_manager.dart';
import 'package:tasks_management/theme_manager/value_manager.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  final homeNavKey = GlobalKey<NavigatorState>();
  final profileNavKey = GlobalKey<NavigatorState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  int selectedTab = 0;
  List<NavModel> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AuthCubit>().user();
    context.read<TasksCubit>().getTasks();

    WidgetsBinding.instance.addObserver(this);
    items = [
      NavModel(
        page: const TasksScreen(tab: 1),
        navKey: homeNavKey,
      ),
      NavModel(
        page: const ProfileScreen(tab: 2),
        navKey: profileNavKey,
      ),
    ];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<bool> didPopRoute() async {
    if (items[selectedTab].navKey.currentState?.canPop() ?? false) {
      items[selectedTab].navKey.currentState?.pop();
      return true;
    }

    if (selectedTab > 0) {
      setState(() {
        selectedTab = 0;
      });
      return true;
    }

    return false;
  }

  Widget _formWidget() {
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
                        context.read<TasksCubit>().createTask(TasksModel(
                              title: titleController.text,
                              description: descController.text,
                            ));
                        Navigator.pop(context);
                        // context.read<TasksCubit>().getTasks();
                      },
                      title: "Create");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // BottomSheet content
  void _showBottomSheet(BuildContext context) {
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
              child: _formWidget(),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedTab,
        children: items
            .map((page) => Navigator(
                  key: page.navKey,
                  onGenerateInitialRoutes: (navigator, initialRoute) {
                    return [MaterialPageRoute(builder: (context) => page.page)];
                  },
                ))
            .toList(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 10),
        height: 70,
        width: 70,
        child: FloatingActionButton(
            backgroundColor: ColorManager.primary,
            elevation: 0,
            onPressed: () => _showBottomSheet(context),
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                  width: 7,
                  color: Colors.white,
                  strokeAlign: BorderSide.strokeAlignOutside),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(
              Icons.add,
              size: 24,
              color: Colors.white,
            )),
      ),
      bottomNavigationBar: BottomNavBar(
        pageIndex: selectedTab,
        onTap: (index) {
          if (index == selectedTab) {
            items[index]
                .navKey
                .currentState
                ?.popUntil((route) => route.isFirst);
          } else {
            setState(() {
              selectedTab = index;
            });
            // Navigator.popUntil(context, ModalRoute.withName('/home'));
          }
        },
      ),
    );
  }
}
