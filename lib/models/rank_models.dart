enum Trend { up, down, neutral }

class RankModels {
  final int id;
  final String name;
  final String icon;
  final String location;
  final int points;
  final String flag;

  RankModels({
    required this.id,
    required this.name,
    required this.icon,
    required this.location,
    required this.points,
    required this.flag,
  });

  factory RankModels.fromJson(Map<String, dynamic> json) {
    return RankModels(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      location: json['location'],
      points: json['points'],
      flag: json['flag'],
    );
  }
}