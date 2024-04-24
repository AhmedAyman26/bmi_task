import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class BMIEntriesModel extends Equatable {
  final String? id;
  final String age;
  final double height;
  final double weight;
  final double? bmi;
  final String dateTime;
  final DocumentSnapshot? documentSnapshot;

  const BMIEntriesModel({
     this.id,
    required this.age,
    required this.height,
    required this.weight,
     this.bmi,
    required this.dateTime,
    this.documentSnapshot
  });

  BMIEntriesModel modify({ final String? id,
   String? age,
   double? height,
   double? weight,
   double? bmi,
   String? dateTime,
   DocumentSnapshot? documentSnapshot})
{
  return BMIEntriesModel(
    id: id ?? this.id,
    age: age ?? this.age,
    height: height ?? this.height,
    weight: weight ?? this.weight,
    bmi: bmi ?? this.bmi,
    dateTime: dateTime ?? this.dateTime,
    documentSnapshot: documentSnapshot ?? this.documentSnapshot
  );
}
  factory BMIEntriesModel.fromJson(Map<String, dynamic> json) => BMIEntriesModel(
    id: json['id'],
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
List<Object?> get props => [id,age, height, weight, bmi, dateTime,documentSnapshot];

}