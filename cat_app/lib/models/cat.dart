import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'dart:io';
part 'cat.g.dart';

@JsonSerializable()
class Cat {
  Cat(String name, String location, String description,
      [String imageUrl, int rating]) {
    this.name = name;
    this.location = location;
    this.description = description;
    this.imageUrl = imageUrl ?? null;
    this.rating = rating ?? 0;
  }

  String name;
  String location;
  String description;
  String imageUrl;
  int rating;

  factory Cat.fromJson(Map<String, dynamic> json) => _$CatFromJson(json);
  Map<String, dynamic> toJson() => _$CatToJson(this);
}
