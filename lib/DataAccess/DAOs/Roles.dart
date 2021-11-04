// ignore_for_file: always_specify_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy_web/Common/CallContext.dart';
import 'package:fleezy_web/Common/Constants.dart';
import 'package:fleezy_web/DataModels/ModelUser.dart';

class Roles {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  CallContext callContext = CallContext();

  Future<CallContext> addRole(ModelUser user) async {
    final DocumentSnapshot<Map<String, dynamic>> snapShot =
        await fireStore.collection(Constants.USERS).doc(user.phoneNumber).get();
    if (snapShot.exists) {
      callContext.setError('User already exists');
      return callContext;
    }
    await fireStore
        .collection(Constants.USERS)
        .doc(user.phoneNumber)
        .set(user.toJson())
        .then((dynamic value) => callContext
            .setSuccess('User Added')) // check this if unknown error is thrown
        .catchError((dynamic error) =>
            callContext.setError('Error Adding User $error'));
    return callContext;
  }

  Future<CallContext> updateRole(ModelUser? user) async {
    if (user == null) {
      callContext.setError('User is null');
      return callContext;
    }
    await fireStore
        .collection(Constants.USERS)
        .doc(user.phoneNumber)
        .update(user.toJson())
        .then((dynamic value) => callContext.setSuccess('User updated'))
        .catchError((dynamic error) =>
            callContext.setError('Error Updating User $error'));
    return callContext;
  }

  Future<void> deleteUser(String docid) async {
    await fireStore.collection(Constants.USERS).doc(docid).delete();
  }

  Future<ModelUser?> verifyUser(String phoneNumber) async {
    return getUser(phoneNumber);
  }

  Future<ModelUser?> getUser(String? phoneNumber) async {
    final DocumentSnapshot<ModelUser> snapShot = await fireStore
        .collection(Constants.USERS)
        .doc(phoneNumber)
        .withConverter<ModelUser>(
            fromFirestore: (snapshots, _) =>
                ModelUser.fromJson(snapshots.data()!),
            toFirestore: (modelUser, _) => modelUser.toJson())
        .get();
    return snapShot.data();
  }

  Future<List<ModelUser>> getUsersByStatus(
      String companyId, String status) async {
    final QuerySnapshot<ModelUser> snapshot = await fireStore
        .collection(Constants.USERS)
        .where('CompanyId', arrayContains: companyId)
        .where('State', isEqualTo: status)
        .withConverter<ModelUser>(
          fromFirestore: (snapshots, _) =>
              ModelUser.fromJson(snapshots.data()!),
          toFirestore: (modelUser, _) => modelUser.toJson(),
        )
        .get();

    return ModelUser.getUsersFrom(snapshot);
  }
}
