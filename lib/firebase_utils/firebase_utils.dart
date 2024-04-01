import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/WatchListModel.dart';

class FirebaseUtils {
  static CollectionReference<WatchListModel> getWatchListCollectionRef() {
    return FirebaseFirestore.instance
        .collection('watchList')
        .withConverter<WatchListModel>(
          fromFirestore: (snapshot, options) =>
              WatchListModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  static Future<void> addWatchListToFirebase(WatchListModel model) {
    var collection = getWatchListCollectionRef();
    var docRef = collection.doc(model.id.toString());
    return docRef.set(model);
  }

  static Stream<QuerySnapshot<WatchListModel>> getWatchListFromFirebase() {
    return getWatchListCollectionRef().snapshots();
  }

  static Future<void> deleteWatchListFromFirebase(int movieId) async {
    return await getWatchListCollectionRef().doc(movieId.toString()).delete();
  }

  static Future<bool> isInWatchList(int id) async {
    var querySnapShot = await getWatchListCollectionRef().get();
    var movieIDList = querySnapShot.docs.map((e) => e.data().id).toList();
    return movieIDList.contains(id);
  }
}
