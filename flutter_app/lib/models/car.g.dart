// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Car _$CarFromJson(Map<String, dynamic> json) => Car(
      id: (json['id'] as num).toInt(),
      model: json['model'] as String,
      price: json['price'] as String,
      description: json['description'] as String,
      image1: json['image1'] as String,
      image2: json['image2'] as String,
      image3: json['image3'] as String,
      stars: (json['stars'] as num).toDouble(),
      reviews: (json['reviews'] as num).toInt(),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$CarToJson(Car instance) => <String, dynamic>{
      'id': instance.id,
      'model': instance.model,
      'price': instance.price,
      'description': instance.description,
      'image1': instance.image1,
      'image2': instance.image2,
      'image3': instance.image3,
      'stars': instance.stars,
      'reviews': instance.reviews,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
