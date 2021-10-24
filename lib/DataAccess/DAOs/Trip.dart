import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy_web/Common/CallContext.dart';
import 'package:fleezy_web/Common/Constants.dart';
import 'package:fleezy_web/DataModels/ModelTrip.dart';

class Trip {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  CallContext callContext = CallContext();

  Future<CallContext> updateTrip(ModelTrip trip, String companyId) async {
    await fireStore
        .collection(Constants.COMPANIES)
        .doc(companyId)
        .collection(Constants.TRIP)
        .doc(trip.id)
        .update(trip.toJson())
        .then((dynamic value) => callContext.setSuccess('Trip updated'))
        .catchError((dynamic error) =>
            callContext.setError('Error Updating Trip ${error.toString()}'));
    return callContext;
  }

  Future<void> deleteTrip(String companyId, String docid) async {
    return fireStore
        .collection(Constants.COMPANIES)
        .doc(companyId)
        .collection(Constants.TRIP)
        .doc(docid)
        .delete();
  }
}
