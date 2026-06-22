class Favorite {
  final String idMeal;
  final String name;
  final String thumbnail;

  Favorite({
    required this.idMeal,
    required this.name,
    required this.thumbnail,
  });

  Map<String, dynamic> toJson() {
    return {
      'idMeal': idMeal,
      'name': name,
      'thumbnail': thumbnail,
    };
  }

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      idMeal: json['idMeal'],
      name: json['name'],
      thumbnail: json['thumbnail'],
    );
  }
}