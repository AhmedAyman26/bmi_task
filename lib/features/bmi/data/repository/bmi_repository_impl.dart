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
  Stream<List<BMIEntriesModel>> getBmiEntriesFromFireStore() {
    print("edf;jds;jfsdf");
    try {
      return bmiCollectionReference
          .snapshots()
          .map((event) {
        List<BMIEntriesModel> entries = [];
        print("ldjsfhjsdjfhdsf${event.docs.length}");
        for (var document in event.docs) {
          print("ahmed${document.data()}");
          entries.add(BMIEntriesModel.fromJson(document.data()));
          print("dhdhfdshfhjdkshfksdfsd");
        }
        print("#@^54%${entries.length}");
        return entries;
      });
    }
    catch (error) {
      print("ewrewrewrwerwerewr${error.toString()}");
      throw Exception(error);}
  }
}
