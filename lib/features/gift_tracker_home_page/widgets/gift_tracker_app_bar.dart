import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GiftTrackerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GiftTrackerAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF7F7F7),
      elevation: 0,
      title: Row(
        children: [
          Icon(
            Icons.card_giftcard,
            color: const Color(0xFF4B0082),
            size: 28.sp,
          ),
          SizedBox(width: 8.w),
          Text(
            'GiftTracker',
            style: TextStyle(
              fontFamily: 'Arial',
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4B0082),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications_outlined,
            color: const Color(0xFF4B0082),
            size: 24.sp,
          ),
          onPressed: () {
            // Show notifications
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}