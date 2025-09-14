class Bio {
  final String id;
  final String name;
  final int age;
  final String job;
  final String jobAt;
  final List<dynamic> imageUrls;
  Bio(
      {required this.id,
      required this.name,
      required this.age,
      required this.job,
      required this.jobAt,
      required this.imageUrls});

  Bio.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        age = json['age'],
        job = json['job'],
        jobAt = json['jobAt'],
        imageUrls = json['imageUrls'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'job': job,
        'jobAt': jobAt,
        'imageUrls': imageUrls
      };
}
