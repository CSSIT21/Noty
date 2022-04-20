class JsonViewModel {
  final String name;
  final double salary;

  JsonViewModel({
    required this.name,
    required this.salary,
  });

  Map toJson() {
    return {'name': name, 'salary': salary};
  }

  factory JsonViewModel.fromJson(Map<String, dynamic> json) {
    return JsonViewModel(
      name: json['name'] as String,
      salary: double.parse(json['salary']),
    );
  }

  factory JsonViewModel.fromJsonFile(Map<String, dynamic> json) {
    return JsonViewModel(
      name: json['name'] as String,
      salary: json['salary'] as double,
    );
  }
}
