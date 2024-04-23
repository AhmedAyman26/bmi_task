import 'dart:async';
import 'package:bmi_task/core/network/exceptions.dart';
import 'package:bmi_task/core/utils/request_status.dart';
import 'package:bmi_task/features/bmi/domain/models/bmi_entries_model.dart';
import 'package:bmi_task/features/bmi/domain/use_cases/add_bmi_entries_to_firebase_use_case.dart';
import 'package:bmi_task/features/bmi/domain/use_cases/get_bmi_entries_use_case.dart';
import 'package:bmi_task/features/bmi/presentation/pages/bmi_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BmiCubit extends Cubit<BmiStates> {
  final AddBmiEntriesToFirebaseUseCase _addBmiEntriesToFirebaseUseCase;
  final GetBmiEntriesUseCase _getBmiEntriesUseCase;
  StreamSubscription<List<BMIEntriesModel>>? _entriesSubscription;

  BmiCubit(this._addBmiEntriesToFirebaseUseCase, this._getBmiEntriesUseCase, )
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
    _entriesSubscription?.cancel();
    emit(state.copyWith(getBmiEntriesState: RequestStatus.loading));
    try {
       _getBmiEntriesUseCase.call(limit: 10).listen((event)
      {
        emit(state.copyWith(
            getBmiEntriesState: RequestStatus.success,
            bmiEntries: event));
      });

    } on FirebaseException catch (error) {
      emit(state.copyWith(
          getBmiEntriesState: RequestStatus.failure,
          errorMessage: error.toString()));
    }
    on OfflineException catch(error) {
      emit(state.copyWith(
          getBmiEntriesState: RequestStatus.failure,
          errorMessage: error.toString()));

    }
    on Exception catch(error) {
      emit(state.copyWith(
          getBmiEntriesState: RequestStatus.failure,
          errorMessage: error.toString()));
    }
  }


  void loadMoreEntries(BMIEntriesModel? last) async {
    emit(state.copyWith(getBmiEntriesState: RequestStatus.loading));
    final entries = await _getBmiEntriesUseCase.call(limit: 10, last: last).first;
    emit(state.copyWith(bmiEntries: state.bmiEntries! + entries));
  }


  @override
  void emit(BmiStates state) {
   if(!isClosed) {
     super.emit(state);
   }
  }
}
