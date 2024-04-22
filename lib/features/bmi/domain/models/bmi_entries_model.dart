import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class BMIEntriesModel extends Equatable {
  final double age;
  final double height;
  final double weight;
  final double bmi;
  final String dateTime;

  const BMIEntriesModel({
    required this.age,
    required this.height,
    required this.weight,
    required this.bmi,
    required this.dateTime,
  });

  factory BMIEntriesModel.fromJson(Map<String, dynamic> json) => BMIEntriesModel(
    age: json['age'],
    height: json['height'],
    weight: json['weight'],
    bmi: json['bmi'],
    dateTime: json['dateTime'],
  );
  Map<String, dynamic> toJson() =>
      <String, dynamic>
      {
        'age': age,
        'height': height,
        'weight': weight,
        'bmi': bmi,
        'dateTime': dateTime
      };


@override
List<Object?> get props => [age, height, weight, bmi, dateTime];

}

enum BmiStatus
{
  underWeight,
  normal,
  overWeight,
  obesity,
}