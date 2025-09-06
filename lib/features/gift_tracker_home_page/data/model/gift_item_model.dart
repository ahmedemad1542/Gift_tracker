class GiftItem {
  final String id;
  final String recipientName;
  final String giftIdea;
  final String occasion;
  final DateTime? reminderDate;
  final bool isReminderSet;

  const GiftItem({
    required this.id,
    required this.recipientName,
    required this.giftIdea,
    required this.occasion,
    this.reminderDate,
    this.isReminderSet = false,
  });

  GiftItem copyWith({
    String? id,
    String? recipientName,
    String? giftIdea,
    String? occasion,
    DateTime? reminderDate,
    bool? isReminderSet,
  }) {
    return GiftItem(
      id: id ?? this.id,
      recipientName: recipientName ?? this.recipientName,
      giftIdea: giftIdea ?? this.giftIdea,
      occasion: occasion ?? this.occasion,
      reminderDate: reminderDate ?? this.reminderDate,
      isReminderSet: isReminderSet ?? this.isReminderSet,
    );
  }
}