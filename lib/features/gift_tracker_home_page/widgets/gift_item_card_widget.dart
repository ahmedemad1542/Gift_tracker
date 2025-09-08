import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:gift_tracker_new/features/gift_tracker_home_page/data/model/gift_item_model.dart';
import 'package:gift_tracker_new/features/edit_gift/view/edit_gift_bottom_sheet.dart';

class GiftItemCard extends StatelessWidget {
  final GiftItem giftItem;
  final Function(String) onToggleReminder;
  final Function(String) onDeleteGift;
  final Function(String, GiftItem) onUpdateGift;

  const GiftItemCard({
    super.key,
    required this.giftItem,
    required this.onToggleReminder,
    required this.onDeleteGift,
    required this.onUpdateGift,
  });

  void _showOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(top: 8.h),
              height: 4.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  Text(
                    'Gift Options',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF4B0082),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ListTile(
                    leading: Icon(
                      Icons.edit,
                      color: const Color(0xFF4B0082),
                      size: 24.sp,
                    ),
                    title: Text(
                      'Edit Gift',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      _showEditBottomSheet(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 24.sp,
                    ),
                    title: Text(
                      'Delete Gift',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      _showDeleteConfirmation(context);
                    },
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EditGiftBottomSheet(
        giftItem: giftItem,
        onUpdateGift: (updatedGift) {
          onUpdateGift(giftItem.id, updatedGift);
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Delete Gift',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF4B0082),
          ),
        ),
        content: Text(
          'Are you sure you want to delete "${giftItem.giftIdea}" for ${giftItem.recipientName}?',
          style: TextStyle(fontSize: 16.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onDeleteGift(giftItem.id);
            },
            child: Text(
              'Delete',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _showOptionsBottomSheet(context),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Dismissible(
            key: Key(giftItem.id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Icon(
                Icons.delete,
                color: Colors.white,
                size: 24.sp,
              ),
            ),
            onDismissed: (direction) => onDeleteGift(giftItem.id),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              giftItem.giftIdea,
                              style: TextStyle(
                                fontFamily: 'Arial',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF4B0082),
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'For ${giftItem.recipientName}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => onToggleReminder(giftItem.id),
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: giftItem.isReminderSet
                                ? const Color(0xFFFF4500).withOpacity(0.1)
                                : Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            giftItem.isReminderSet
                                ? Icons.notifications_active
                                : Icons.notifications_off_outlined,
                            color: giftItem.isReminderSet
                                ? const Color(0xFFFF4500)
                                : Colors.grey,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Icon(
                        Icons.event,
                        size: 16.sp,
                        color: Colors.grey[600],
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        giftItem.occasion,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      if (giftItem.reminderDate != null) ...[
                        Icon(
                          Icons.schedule,
                          size: 16.sp,
                          color: const Color(0xFFFF4500),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${giftItem.reminderDate!.day}/${giftItem.reminderDate!.month}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFFFF4500),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}