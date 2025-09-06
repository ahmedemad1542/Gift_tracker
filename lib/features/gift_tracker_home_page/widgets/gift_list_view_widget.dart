import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gift_tracker_new/features/gift_tracker_home_page/data/model/gift_item_model.dart';
import 'package:gift_tracker_new/features/gift_tracker_home_page/widgets/gift_item_card_widget.dart';


class GiftListView extends StatelessWidget {
  final List<GiftItem> giftItems;
  final Function(String) onToggleReminder;
  final Function(String) onDeleteGift;
  final Function(String, GiftItem) onUpdateGift;

  const GiftListView({
    super.key,
    required this.giftItems,
    required this.onToggleReminder,
    required this.onDeleteGift,
    required this.onUpdateGift,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: giftItems.length,
      itemBuilder: (context, index) {
        return GiftItemCard(
          giftItem: giftItems[index],
          onToggleReminder: onToggleReminder,
          onDeleteGift: onDeleteGift,
          onUpdateGift: onUpdateGift,
        );
      },
    );
  }
}