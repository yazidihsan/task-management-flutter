import 'package:flutter/material.dart';
import 'package:tasks_management/theme_manager/color_manager.dart';
import 'package:tasks_management/theme_manager/space_manager.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {super.key,
      required this.title,
      required this.desc,
      required this.onPressDel,
      required this.onPressEdt});
  final String title;
  final String desc;
  final VoidCallback onPressDel;
  final VoidCallback onPressEdt;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        width: double.infinity,
        height: 180,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Icon(
                        Icons.person,
                        color: ColorManager.blackBold,
                      ),
                    ),
                    4.0.spaceX,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "title",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: onPressEdt,
                        child: Icon(
                          Icons.edit,
                          color: ColorManager.blackBold,
                        )),
                    TextButton(
                        onPressed: onPressDel,
                        child: Icon(
                          Icons.remove,
                          color: ColorManager.blackBold,
                        ))
                  ],
                )
              ],
            ),
            10.0.spaceY,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "description",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  desc,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
