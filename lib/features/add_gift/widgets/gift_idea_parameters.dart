import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gift_tracker_new/core/widgets/custom_text_field.dart';

class AddGiftIdeaParameters extends StatelessWidget {
  final TextEditingController giftIdeaController;
  final TextEditingController recipientController;
  final TextEditingController occasionController;
  const AddGiftIdeaParameters({
    super.key,
    required this.giftIdeaController,
    required this.recipientController,
    required this.occasionController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Add New Gift Idea',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF4B0082),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(Icons.close, size: 24.sp, color: Colors.grey),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        CustomTextField(
          controller: giftIdeaController,
          label: 'Gift Idea',
          hint: 'e.g., Wireless Headphones',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a gift idea';
            }
            return null;
          },
        ),
        SizedBox(height: 16.h),
        CustomTextField(
          controller: recipientController,
          label: 'For whom?',
          hint: 'e.g., Sarah, Mom, Dad',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter recipient name';
            }
            return null;
          },
        ),
        SizedBox(height: 16.h),
        CustomTextField(
          controller: occasionController,
          label: 'Occasion',
          hint: 'e.g., Birthday, Christmas',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter occasion';
            }
            return null;
          },
        ),
      ],
    );
  }
}
