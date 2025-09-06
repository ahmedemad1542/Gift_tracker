import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:gift_tracker_new/features/gift_tracker_home_page/data/model/gift_item_model.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}