import 'package:bmi_task/features/bmi/domain/models/bmi_entries_model.dart';

abstract class BMIRepository {
  Future<void> addBmiEntriesToFireStore(BMIEntriesModel bmiEntriesModel);
  Stream<List<BMIEntriesModel>> getBmiEntriesFromFireStore();
}