import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/category.dart';


class Event {
  String id;
  String UserId;
  Category category;
  String titel;
  String description;
  DateTime datetime;
  Event({
    this.id = '',
    required this.UserId,
    required this.category,
    required this.titel,
    required this.description,
    required this.datetime,
  });
  Event.fromjson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          UserId: json['UserId'], 
          category: Category.categories
              .firstWhere((category) => category.id == json['categoryId']),
          titel: json['titel'],
          description: json['description'],
          datetime: (json['datetime'] as Timestamp).toDate(),
        );

  Map<String, dynamic> tojson() => {
        'id': id,
        'UserId': UserId,
        'categoryId': category.id,
        'titel': titel,
        'description': description,
        'datetime': Timestamp.fromDate(datetime)
      };
}
