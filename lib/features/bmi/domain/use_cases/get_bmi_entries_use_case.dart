import 'package:bmi_task/features/bmi/domain/models/bmi_entries_model.dart';
import 'package:bmi_task/features/bmi/domain/repository/bmi_repository.dart';

class GetBmiEntriesUseCase {
  final BMIRepository _bmiRepository;

  const GetBmiEntriesUseCase(this._bmiRepository);

  Stream<List<BMIEntriesModel>> call()  {
     return _bmiRepository.getBmiEntriesFromFireStore();
  }
}