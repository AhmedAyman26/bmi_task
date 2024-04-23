import 'package:bmi_task/features/bmi/domain/models/bmi_entries_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BMIRepository {
  Future<void> addBmiEntriesToFireStore(BMIEntriesModel bmiEntriesModel);
  Stream<List<BMIEntriesModel>> getBmiEntriesFromFireStore({required int limit, required BMIEntriesModel? last});
  // Stream<List<BMIEntriesModel>> fetchMoreEntries(BMIEntriesModel? lastEntry);
}