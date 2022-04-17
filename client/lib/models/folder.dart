class Folder {
  int id;
  String name;
  int count;

  Folder({
    required this.id,
    required this.name,
    required this.count,
  });

  factory Folder.fromJson(Map<String, dynamic> json) {
    return Folder(id: json["id"], name: json["name"], count: json["count"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "count": count,
    };
  }
}
