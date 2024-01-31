class NotesModel {
  late String title;
  late String subtitle;

  NotesModel({
    required this.title,
    required this.subtitle,
  });

  NotesModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'subtitle': subtitle,
      };
}
