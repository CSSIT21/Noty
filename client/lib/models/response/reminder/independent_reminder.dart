class IndependentReminder {
  String reminderId;
  String title;
  String description;
  String? remindDate;

  IndependentReminder({
    required this.reminderId,
    required this.title,
    required this.description,
    this.remindDate,
  });

  factory IndependentReminder.fromJson(Map<String, dynamic> json) {
    return IndependentReminder(
      reminderId: json['reminder_id'],
      title: json['title'],
      description: json['description'],
      remindDate: json['remind_date'],
    );
  }
}
