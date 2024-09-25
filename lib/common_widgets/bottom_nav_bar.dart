import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasks_management/theme_manager/color_manager.dart';
import 'package:tasks_management/theme_manager/space_manager.dart';

class BottomNavBar extends StatelessWidget {
  final int pageIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.pageIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color.fromRGBO(0, 0, 0, 0),
      height: 75,
      padding: const EdgeInsets.all(0),
      elevation: 0.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 60,
          color: ColorManager.secondary300,
          child: Row(
            children: [
              navItem(
                Icons.home_outlined,
                "Home",
                pageIndex == 0,
                onTap: () => onTap(0),
              ),
              navItem(
                Icons.person_outline,
                "Profile",
                pageIndex == 1,
                onTap: () => onTap(1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget navItem(IconData icon, String title, bool selected,
      {Function()? onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              size: 28,
              icon,
              color: selected ? ColorManager.primary : ColorManager.grey300,
            ),
            5.0.spaceY,
            Text(
              title,
              style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color:
                      selected ? ColorManager.primary : ColorManager.grey300),
            )
          ],
        ),
      ),
    );
  }
}
