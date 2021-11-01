// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy_web/Common/AppData.dart';
import 'package:fleezy_web/Common/CallContext.dart';
import 'package:fleezy_web/Common/Constants.dart';
import 'package:fleezy_web/DataModels/ModelCompany.dart';
import 'package:fleezy_web/DataModels/ModelVehicle.dart';

class Vehicle {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  CallContext callContext = CallContext();

  Future<CallContext> addVehicle(ModelVehicle vehicle) async {
    final DocumentSnapshot<Map<String, dynamic>> docSnap = await fireStore
        .collection(Constants.VEHICLES)
        .doc(vehicle.registrationNo)
        .get();
    if (docSnap.exists) {
      callContext.setError('Vehicle already exists');
      return callContext;
    }

    await fireStore
        .collection(Constants.VEHICLES)
        .doc(vehicle.registrationNo)
        .set(vehicle.toJson())
        .then((dynamic value) => callContext.setSuccess('Vehicle added'))
        .catchError((dynamic error) => callContext.setError('$error'));

    return callContext;
  }

  Future<String> deleteVehicle(ModelVehicle vehicle) async {
    try {
      await fireStore
          .collection(Constants.VEHICLES)
          .doc(vehicle.registrationNo)
          .delete();
      return 'Deleted ${vehicle.registrationNo} from company';
    } catch (e) {
      print('Unable to delete ${vehicle.registrationNo}');
      print(e);
      return 'Unable to delete ${vehicle.registrationNo}';
    }
  }

  Future<CallContext> updateVehicle(ModelVehicle vehicle) async {
    await fireStore
        .collection(Constants.VEHICLES)
        .doc(vehicle.registrationNo)
        .update(vehicle.toJson())
        .then((dynamic value) => callContext.setSuccess('Vehicle Updated'))
        .catchError((dynamic error) =>
            callContext.setError('Error Updating Vehicle $error'));

    return callContext;
  }

  Future<List<ModelVehicle>> _getVehiclesInCompany(
      ModelCompany? selectedCompany) async {
    QuerySnapshot<Map<String, dynamic>> snapShot;
    snapShot = await fireStore
        .collection(Constants.VEHICLES)
        .where('CompanyId', isEqualTo: selectedCompany?.companyEmail)
        .get();
    return ModelVehicle.fromDocs(snapShot);
  }

  Future<void> getVehicleList(AppData appData) async {
    final List<ModelVehicle> vehiclesData =
        await _getVehiclesInCompany(appData.selectedCompany);
    if (vehiclesData.isNotEmpty) {
      appData.setAvailableVehicles(vehiclesData);
    }
  }

  Future<CallContext> getVehicleByRegNo(String regNo) async {
    final DocumentSnapshot<Map<String, dynamic>> doc =
        await fireStore.collection(Constants.VEHICLES).doc(regNo).get();
    if (!doc.exists) {
      callContext.setError('Vehicle not found');
      return callContext;
    }
    callContext.data = ModelVehicle.fromDoc(doc);
    return callContext;
  }
}
