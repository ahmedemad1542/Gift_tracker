import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gift_tracker_new/core/widgets/custom_text_field.dart';

class EditGiftParameters extends StatelessWidget {
  final TextEditingController giftIdeaController;
  final TextEditingController recipientController;
  final TextEditingController occasionController;
  final bool setReminder;
  final ValueChanged<bool> onToggleReminder;

  const EditGiftParameters({
    super.key,
    required this.giftIdeaController,
    required this.recipientController,
    required this.occasionController,
    required this.setReminder,
    required this.onToggleReminder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: giftIdeaController,
          label: 'Gift Idea',
          hint: 'e.g., Wireless Headphones',
          validator: (value) => value == null || value.isEmpty
              ? 'Please enter a gift idea'
              : null,
        ),
        CustomTextField(
          controller: recipientController,
          label: 'For whom?',
          hint: 'e.g., Sarah, Mom, Dad',
          validator: (value) => value == null || value.isEmpty
              ? 'Please enter recipient name'
              : null,
        ),
        CustomTextField(
          controller: occasionController,
          label: 'Occasion',
          hint: 'e.g., Birthday, Christmas',
          validator: (value) => value == null || value.isEmpty
              ? 'Please enter occasion'
              : null,
        ),
        Row(
          children: [
            Switch(
              value: setReminder,
              onChanged: onToggleReminder,
              activeColor: const Color(0xFFFF4500),
            ),
             SizedBox(width: 8.w),
            Text('Set Reminder'),
          ],
        ),
      ],
    );
  }
}
