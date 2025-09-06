import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddGiftFAB extends StatelessWidget {
  final VoidCallback onPressed;

  const AddGiftFAB({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      backgroundColor: const Color(0xFF4B0082),
      foregroundColor: Colors.white,
      icon: Icon(Icons.add, size: 24.sp),
      label: Text(
        'Add Gift',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
        ),
      ),
    );
  }
}
