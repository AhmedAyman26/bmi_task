import 'package:bmi_task/features/bmi/domain/repository/bmi_repository.dart';

class DeleteBmiEntryUseCase {
  final BMIRepository _bmiRepository;

  DeleteBmiEntryUseCase(this._bmiRepository);

  Future<void> call(String id) async {
    await _bmiRepository.deleteBmiEntriesFromFireStore(id);
  }
}