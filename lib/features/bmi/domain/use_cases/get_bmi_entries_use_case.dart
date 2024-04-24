import 'package:bmi_task/features/bmi/domain/models/bmi_entries_model.dart';
import 'package:bmi_task/features/bmi/domain/repository/bmi_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetBmiEntriesUseCase {
  final BMIRepository _bmiRepository;

  const GetBmiEntriesUseCase(this._bmiRepository);

  Stream<List<BMIEntriesModel>> call({required int limit,  DocumentSnapshot? last})  {
     return _bmiRepository.getBmiEntriesFromFireStore(limit: limit, last: last);
  }
}