import 'package:bmi_task/core/utils/request_status.dart';
import 'package:bmi_task/features/bmi/domain/models/bmi_entries_model.dart';
import 'package:bmi_task/features/bmi/domain/use_cases/add_bmi_entries_to_firebase_use_case.dart';
import 'package:bmi_task/features/bmi/domain/use_cases/get_bmi_entries_use_case.dart';
import 'package:bmi_task/features/bmi/presentation/pages/bmi_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BmiCubit extends Cubit<BmiStates> {
  final AddBmiEntriesToFirebaseUseCase _addBmiEntriesToFirebaseUseCase;
  final GetBmiEntriesUseCase _getBmiEntriesUseCase;

  BmiCubit(this._addBmiEntriesToFirebaseUseCase, this._getBmiEntriesUseCase)
      : super(const BmiStates());

  void calculateBmi(BMIEntriesModel bmiEntriesModel) {
    final bmi = (bmiEntriesModel.weight /
        (bmiEntriesModel.height * bmiEntriesModel.height));
    print(bmi);
    emit(state.copyWith(bmi: bmi));
  }

  void addBmiEntries(BMIEntriesModel bmiEntriesModel) async {
    emit(state.copyWith(addBmiEntriesStatus: RequestStatus.loading));
    try {
      await _addBmiEntriesToFirebaseUseCase.call(bmiEntriesModel);
      emit(state.copyWith(addBmiEntriesStatus: RequestStatus.success));
    } catch (error) {
      emit(state.copyWith(
          addBmiEntriesStatus: RequestStatus.failure,
          errorMessage: error.toString()));
    }
  }

  void getBmiEntries() {
    emit(state.copyWith(getBmiEntriesState: RequestStatus.loading));
    try {
      final bmiEntriesStream = _getBmiEntriesUseCase.call();
      emit(state.copyWith(
          getBmiEntriesState: RequestStatus.success,
          bmiEntries: bmiEntriesStream));
    } catch (error) {
      print("errrrrror${error.toString()}");
      emit(state.copyWith(
          getBmiEntriesState: RequestStatus.failure,
          errorMessage: error.toString()));
    }
  }
}
