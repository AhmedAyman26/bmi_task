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
      await bmiCollectionReference.add(bmiEntriesModel.toJson()).then((value)
      {
        bmiCollectionReference.doc(value.id).update({'id': value.id});
      });
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


  @override
  Future<void> deleteBmiEntriesFromFireStore(String id) async {
  await bmiCollectionReference.doc(id).delete();

  }

  @override
  Future<void> updateBmiEntriesInFireStore(String id, BMIEntriesModel bmiEntriesModel) async {
  await bmiCollectionReference.doc(id).update(bmiEntriesModel.toJson());

  }

}
