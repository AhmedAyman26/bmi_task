import 'dart:async';
import 'package:bmi_task/core/di/app_injector.dart';
import 'package:bmi_task/core/network/exceptions.dart';
import 'package:bmi_task/core/utils/request_status.dart';
import 'package:bmi_task/features/bmi/domain/models/bmi_entries_model.dart';
import 'package:bmi_task/features/bmi/domain/use_cases/add_bmi_entries_to_firebase_use_case.dart';
import 'package:bmi_task/features/bmi/domain/use_cases/delete_bmi_entry_use_case.dart';
import 'package:bmi_task/features/bmi/domain/use_cases/get_bmi_entries_use_case.dart';
import 'package:bmi_task/features/bmi/domain/use_cases/update_bmi_entry_use_case.dart';
import 'package:bmi_task/features/bmi/presentation/pages/bmi_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BmiCubit extends Cubit<BmiStates> {
  late final AddBmiEntriesToFirebaseUseCase _addBmiEntriesToFirebaseUseCase;
  late final GetBmiEntriesUseCase _getBmiEntriesUseCase;
  late final UpdateBmiEntryUseCase _updateBmiEntryUseCase;
  late final DeleteBmiEntryUseCase _deleteBmiEntryUseCase;
  StreamSubscription<List<BMIEntriesModel>>? _entriesSubscription;

  BmiCubit()
      : super(const BmiStates())
  {
    _addBmiEntriesToFirebaseUseCase= injector();
    _getBmiEntriesUseCase= injector();
    _updateBmiEntryUseCase= injector();
    _deleteBmiEntryUseCase= injector();
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


  void loadMoreEntries(DocumentSnapshot? last) async {
    final entries = await _getBmiEntriesUseCase.call(limit: 10, last: last).first;
    emit(state.copyWith(bmiEntries: state.bmiEntries! + entries, getBmiEntriesState: RequestStatus.success));
  }

  void deleteEntry(String id) async {
    emit(state.copyWith(deleteBmiEntryState: RequestStatus.loading));
    try {
      await _deleteBmiEntryUseCase.call(id);
      final newEntries = state.bmiEntries!.where((element) => element.id != id).toList();
      emit(state.copyWith(bmiEntries: newEntries));
    }catch (error) {
      emit(state.copyWith(
          deleteBmiEntryState: RequestStatus.failure,
          errorMessage: error.toString()));
    }
  }

  void updateEntry(String id, BMIEntriesModel bmiEntriesModel) async {
    emit(state.copyWith(updateBmiEntryState: RequestStatus.loading));
    try {
      await _updateBmiEntryUseCase.call(id, bmiEntriesModel);
      emit(state.copyWith(updateBmiEntryState: RequestStatus.success));
    }catch (error) {
      emit(state.copyWith(updateBmiEntryState: RequestStatus.failure, errorMessage: error.toString()));
    }
  }

  @override
  void emit(BmiStates state) {
   if(!isClosed) {
     super.emit(state);
   }
  }
}
