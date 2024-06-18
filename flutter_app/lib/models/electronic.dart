import 'package:json_annotation/json_annotation.dart';

part 'electronic.g.dart';

@JsonSerializable()
class Electronic {
  int id;
  String model;
  String price;
  String description;
  String image1;
  String image2;
  String image3;
  double stars;
  int reviews;
  double latitude;
  double longitude;

  Electronic({
    required this.id,
    required this.model,
    required this.price,
    required this.description,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.stars,
    required this.reviews,
    required this.latitude,
    required this.longitude,
  });

  factory Electronic.fromJson(Map<String, dynamic> json) =>
      _$ElectronicFromJson(json);
  Map<String, dynamic> toJson() => _$ElectronicToJson(this);
}
