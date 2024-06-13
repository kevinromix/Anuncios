import 'package:json_annotation/json_annotation.dart';

part 'car.g.dart';

@JsonSerializable()
class Car {
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

  Car({
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

  factory Car.fromJson(Map<String, dynamic> json) => _$CarFromJson(json);
  Map<String, dynamic> toJson() => _$CarToJson(this);
}
