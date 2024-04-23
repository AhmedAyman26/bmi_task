import 'package:bmi_task/core/utils/network_info.dart';
import 'package:bmi_task/features/bmi/domain/models/bmi_entries_model.dart';
import 'package:bmi_task/features/bmi/domain/repository/bmi_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BMIRepositoryImpl extends BMIRepository {
  final NetworkInfo networkInfo;
  final bmiCollectionReference = FirebaseFirestore.instance.collection('bmi');

  BMIRepositoryImpl(this.networkInfo);

  @override
  Future<void> addBmiEntriesToFireStore(BMIEntriesModel bmiEntriesModel) async {
    if (!(await networkInfo.isConnected)) {
      throw Exception('No Internet Connection');
    } else {
      await bmiCollectionReference.add(bmiEntriesModel.toJson());
    }
  }

  @override
  Stream<List<BMIEntriesModel>> getBmiEntriesFromFireStore({required int limit, required BMIEntriesModel? last}) {

    final query = bmiCollectionReference
        .orderBy('dateTime', descending: true)
        .limit(limit);

    if (last != null) {
      return query.startAfter([last.dateTime]).snapshots().map((snapshot) {
        return snapshot.docs.map((doc) => BMIEntriesModel.fromJson(doc.data())).toList();
      });
    } else {
      return query.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) => BMIEntriesModel.fromJson(doc.data())).toList();
      });
    }
  }

  // @override
  // Stream<List<BMIEntriesModel>> fetchMoreEntries(BMIEntriesModel? lastEntry) {
  //   return FirebaseFirestore.instance.collection('bmi')
  //       .orderBy('dateTime', descending: true)
  //       .limit(10).startAfter([lastEntry?.dateTime])
  //       .snapshots()
  //       .map((event) {
  //     List<BMIEntriesModel> entries = [];
  //     for (var document in event.docs) {
  //       entries.add(BMIEntriesModel.fromJson(document.data()));
  //     }
  //     return entries;
  //   });
  // }
}
