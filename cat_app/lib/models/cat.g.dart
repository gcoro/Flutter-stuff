// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cat _$CatFromJson(Map<String, dynamic> json) {
  var cat = Cat(json['name'] as String, json['location'] as String,
      json['description'] as String);
  return cat
    ..id = json['id'] as String
    ..imageUrl = json['imageUrl'] == null ? null : json['imageUrl'] as String
    ..rating = json['rating'] == null ? null : json['rating'] as num;
}

Map<String, dynamic> _$CatToJson(Cat instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'location': instance.location,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'rating': instance.rating
    };
