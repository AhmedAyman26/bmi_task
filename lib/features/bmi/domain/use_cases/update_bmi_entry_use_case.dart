import 'package:bmi_task/features/bmi/domain/models/bmi_entries_model.dart';
import 'package:bmi_task/features/bmi/domain/repository/bmi_repository.dart';

class UpdateBmiEntryUseCase
{
  final BMIRepository _bmiRepository;

  UpdateBmiEntryUseCase(this._bmiRepository);

  Future<void> call(String id, BMIEntriesModel bmiEntriesModel) async
  {
    await _bmiRepository.updateBmiEntriesInFireStore(id, bmiEntriesModel);
  }
}