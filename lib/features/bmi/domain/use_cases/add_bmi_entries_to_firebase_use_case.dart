import 'package:bmi_task/features/bmi/domain/models/bmi_entries_model.dart';
import 'package:bmi_task/features/bmi/domain/repository/bmi_repository.dart';

class AddBmiEntriesToFirebaseUseCase {
  final BMIRepository _bmiRepository;

  AddBmiEntriesToFirebaseUseCase(this._bmiRepository);

  Future<void> call(BMIEntriesModel bmiEntriesModel) async {
    await _bmiRepository.addBmiEntriesToFireStore(bmiEntriesModel);
  }
}
