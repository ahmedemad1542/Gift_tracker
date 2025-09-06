import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gift_tracker_new/features/gift_tracker_home_page/data/model/gift_item_model.dart';
import 'package:gift_tracker_new/features/gift_tracker_home_page/widgets/add_gift_bottom_sheet.dart';
import 'package:gift_tracker_new/features/gift_tracker_home_page/widgets/add_gift_fap_widget.dart';
import 'package:gift_tracker_new/features/gift_tracker_home_page/widgets/empty_gift_list_widget.dart';
import 'package:gift_tracker_new/features/gift_tracker_home_page/widgets/gift_list_view_widget.dart';
import 'package:gift_tracker_new/features/gift_tracker_home_page/widgets/gift_tracker_app_bar.dart';
import 'package:gift_tracker_new/features/gift_tracker_home_page/widgets/git_summary_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GiftTrackerHomePage extends StatefulWidget {
  const GiftTrackerHomePage({super.key});

  @override
  State<GiftTrackerHomePage> createState() => _GiftTrackerHomePageState();
}

class _GiftTrackerHomePageState extends State<GiftTrackerHomePage> {
  List<GiftItem> giftItems = []; // Start with empty list
  static const String _storageKey = 'gift_items';

  @override
  void initState() {
    super.initState();
    _loadGiftItems();
  }

  // Load gift items from SharedPreferences
  Future<void> _loadGiftItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? giftItemsJson = prefs.getString(_storageKey);
      
      if (giftItemsJson != null) {
        final List<dynamic> giftItemsList = json.decode(giftItemsJson);
        setState(() {
          giftItems = giftItemsList.map((item) => GiftItem.fromJson(item)).toList();
        });
      }
    } catch (e) {
      print('Error loading gift items: $e');
    }
  }

  // Save gift items to SharedPreferences
  Future<void> _saveGiftItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String giftItemsJson = json.encode(
        giftItems.map((item) => item.toJson()).toList(),
      );
      await prefs.setString(_storageKey, giftItemsJson);
    } catch (e) {
      print('Error saving gift items: $e');
    }
  }

  void _addNewGift() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddGiftBottomSheet(
        onAddGift: (giftItem) {
          setState(() {
            giftItems.add(giftItem);
          });
          _saveGiftItems(); // Save after adding
        },
      ),
    );
  }

  void _toggleReminder(String id) {
    setState(() {
      final index = giftItems.indexWhere((item) => item.id == id);
      if (index != -1) {
        giftItems[index] = giftItems[index].copyWith(
          isReminderSet: !giftItems[index].isReminderSet,
        );
      }
    });
    _saveGiftItems(); // Save after toggling
  }

  void _deleteGift(String id) {
    setState(() {
      giftItems.removeWhere((item) => item.id == id);
    });
    _saveGiftItems(); // Save after deleting
  }

  void _updateGift(String id, GiftItem updatedGift) {
    setState(() {
      final index = giftItems.indexWhere((item) => item.id == id);
      if (index != -1) {
        giftItems[index] = updatedGift;
      }
    });
    _saveGiftItems(); // Save after updating
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GiftTrackerAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            GiftSummaryCard(totalGifts: giftItems.length),
            Expanded(
              child: giftItems.isEmpty
                  ? const EmptyGiftList()
                  : GiftListView(
                      giftItems: giftItems,
                      onToggleReminder: _toggleReminder,
                      onDeleteGift: _deleteGift,
                      onUpdateGift: _updateGift,
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: AddGiftFAB(onPressed: _addNewGift),
    );
  }
}