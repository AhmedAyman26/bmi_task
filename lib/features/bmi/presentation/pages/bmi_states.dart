import 'package:bmi_task/core/utils/request_status.dart';
import 'package:bmi_task/features/bmi/domain/models/bmi_entries_model.dart';
import 'package:equatable/equatable.dart';

class BmiStates extends Equatable {
  final RequestStatus? addBmiEntriesStatus;
  final double? bmi;
  final String? errorMessage;
  final RequestStatus getBmiEntriesState;
  final Stream<List<BMIEntriesModel>>? bmiEntries;

  const BmiStates(
      {this.bmi,
      this.addBmiEntriesStatus = RequestStatus.initial,
      this.errorMessage = '',
      this.getBmiEntriesState = RequestStatus.initial,
      this.bmiEntries});

  BmiStates copyWith(
      {double? bmi,
      RequestStatus? addBmiEntriesStatus,
      String? errorMessage,
      RequestStatus? getBmiEntriesState,
      Stream<List<BMIEntriesModel>>? bmiEntries}) {
    return BmiStates(
        bmi: bmi ?? this.bmi,
        addBmiEntriesStatus: addBmiEntriesStatus ?? this.addBmiEntriesStatus,
        errorMessage: errorMessage ?? this.errorMessage,
        getBmiEntriesState: getBmiEntriesState ?? this.getBmiEntriesState,
        bmiEntries: bmiEntries ?? this.bmiEntries);
  }

  @override
  List<Object?> get props =>
      [bmi, addBmiEntriesStatus, errorMessage, getBmiEntriesState, bmiEntries];
}