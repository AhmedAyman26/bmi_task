import 'package:bmi_task/core/utils/request_status.dart';
import 'package:bmi_task/features/bmi/domain/models/bmi_entries_model.dart';
import 'package:equatable/equatable.dart';

class BmiStates extends Equatable {
  final RequestStatus? addBmiEntriesStatus;
  final double? bmi;
  final String? errorMessage;
  final RequestStatus getBmiEntriesState;
  final List<BMIEntriesModel>? bmiEntries;
  final RequestStatus? deleteBmiEntryState;
  final RequestStatus? updateBmiEntryState;

  const BmiStates(
      {this.bmi,
      this.addBmiEntriesStatus = RequestStatus.initial,
      this.errorMessage = '',
      this.getBmiEntriesState = RequestStatus.initial,
      this.bmiEntries,
        this.deleteBmiEntryState,
        this.updateBmiEntryState
      });

  BmiStates copyWith(
      {double? bmi,
        RequestStatus? deleteBmiEntryState,
         RequestStatus? updateBmiEntryState,
      RequestStatus? addBmiEntriesStatus,
      String? errorMessage,
      RequestStatus? getBmiEntriesState,
      List<BMIEntriesModel>? bmiEntries}) {
    return BmiStates(
        bmi: bmi ?? this.bmi,
        addBmiEntriesStatus: addBmiEntriesStatus ?? this.addBmiEntriesStatus,
        errorMessage: errorMessage ?? this.errorMessage,
        getBmiEntriesState: getBmiEntriesState ?? this.getBmiEntriesState,
        bmiEntries: bmiEntries ?? this.bmiEntries);
  }

  @override
  List<Object?> get props =>
      [bmi, addBmiEntriesStatus, errorMessage, getBmiEntriesState, bmiEntries, deleteBmiEntryState, updateBmiEntryState];
}
