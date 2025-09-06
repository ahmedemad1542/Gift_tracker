import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gift_tracker_new/core/widgets/custom_text_field.dart';
import 'package:gift_tracker_new/features/gift_tracker_home_page/data/model/gift_item_model.dart';


class AddGiftBottomSheet extends StatefulWidget {
  final Function(GiftItem) onAddGift;

  const AddGiftBottomSheet({super.key, required this.onAddGift});

  @override
  State<AddGiftBottomSheet> createState() => _AddGiftBottomSheetState();
}

class _AddGiftBottomSheetState extends State<AddGiftBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _giftIdeaController = TextEditingController();
  final _recipientController = TextEditingController();
  final _occasionController = TextEditingController();
  DateTime? _selectedDate;
  bool _setReminder = false;

  @override
  void dispose() {
    _giftIdeaController.dispose();
    _recipientController.dispose();
    _occasionController.dispose();
    super.dispose();
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveGift() {
    if (_formKey.currentState!.validate()) {
      final newGift = GiftItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        recipientName: _recipientController.text,
        giftIdea: _giftIdeaController.text,
        occasion: _occasionController.text,
        reminderDate: _selectedDate,
        isReminderSet: _setReminder,
      );

      widget.onAddGift(newGift);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
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
                    child: Icon(
                      Icons.close,
                      size: 24.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              CustomTextField(
                controller: _giftIdeaController,
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
                controller: _recipientController,
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
                controller: _occasionController,
                label: 'Occasion',
                hint: 'e.g., Birthday, Christmas',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter occasion';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Switch(
                    value: _setReminder,
                    onChanged: (value) {
                      setState(() {
                        _setReminder = value;
                        if (!value) _selectedDate = null;
                      });
                    },
                    activeColor: const Color(0xFFFF4500),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Set Reminder',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              if (_setReminder) ...[
                SizedBox(height: 16.h),
                GestureDetector(
                  onTap: _selectDate,
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: const Color(0xFFFF4500),
                          size: 20.sp,
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          _selectedDate == null
                              ? 'Select reminder date'
                              : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: _selectedDate == null ? Colors.grey : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: _saveGift,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4B0082),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Save Gift Idea',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}