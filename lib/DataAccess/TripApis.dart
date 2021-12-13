import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy_web/Common/AppData.dart';
import 'package:fleezy_web/Common/CallContext.dart';
import 'package:fleezy_web/Common/Constants.dart';
import 'package:fleezy_web/Common/Utils.dart';
import 'package:fleezy_web/DataModels/ModelCompany.dart';
import 'package:fleezy_web/DataModels/ModelTrip.dart';
import 'package:fleezy_web/DataModels/ModelUser.dart';
import 'package:fleezy_web/DataModels/ModelVehicle.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripApis {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  CallContext callContext = CallContext();

  Future<CallContext> saveTrip(
      ModelTrip trip, ModelVehicle vehicle, BuildContext context) async {
    final ModelCompany company =
        Provider.of<AppData>(context, listen: false).selectedCompany!;
    final WriteBatch batch = fireStore.batch();
    final DocumentReference<Map<String, dynamic>> tripRef = fireStore
        .collection(Constants.COMPANIES)
        .doc(company.companyEmail)
        .collection(Constants.TRIP)
        .doc();
    trip.id = tripRef.id;
    batch.set(tripRef, trip.toJson());

    final DocumentReference<Map<String, dynamic>> vehicleRef =
        fireStore.collection(Constants.VEHICLES).doc(vehicle.registrationNo);
    vehicle.latestOdometerReading = trip.endReading!;
    vehicle.currentDriver = trip.driverName;
    batch.update(vehicleRef, vehicle.toJson());
    await batch
        .commit()
        .then((dynamic value) => callContext.setSuccess('Trip Added'))
        .catchError((dynamic error) => callContext.setError('$error'));
    return callContext;
  }

  Future<CallContext> startNewTrip(
      ModelTrip trip, ModelVehicle vehicle, BuildContext context) async {
    final ModelUser user = Provider.of<AppData>(context, listen: false).user!;
    final ModelCompany company =
        Provider.of<AppData>(context, listen: false).selectedCompany!;
    final WriteBatch batch = fireStore.batch();
    final DocumentReference<Map<String, dynamic>> tripRef = fireStore
        .collection(Constants.COMPANIES)
        .doc(company.companyEmail)
        .collection(Constants.TRIP)
        .doc();
    trip.id = tripRef.id;
    trip.status = Constants.STARTED;
    batch.set(tripRef, trip.toJson());

    final DocumentReference<Map<String, dynamic>> vehicleRef =
        fireStore.collection(Constants.VEHICLES).doc(vehicle.registrationNo);
    vehicle.isInTrip = true;
    vehicle.latestOdometerReading = trip.startReading;
    vehicle.currentDriver = user.fullName ?? user.phoneNumber;
    batch.update(vehicleRef, vehicle.toJson());

    final DocumentReference<Map<String, dynamic>> driverRef =
        fireStore.collection(Constants.USERS).doc(user.phoneNumber);
    user.tripId = tripRef.id;
    batch.update(driverRef, user.toJson());

    await batch
        .commit()
        .then((dynamic value) => callContext.setSuccess('Trip STarted'))
        .catchError((dynamic error) => callContext.setError('$error'));
    return callContext;
  }

  Future<CallContext> endTrip(ModelTrip trip, BuildContext context) async {
    final ModelCompany company =
        Provider.of<AppData>(context, listen: false).selectedCompany!;
    final ModelUser user = Provider.of<AppData>(context, listen: false).user!;
    try {
      final WriteBatch batch = fireStore.batch();

      final DocumentReference<Map<String, dynamic>> tripRef = fireStore
          .collection(Constants.COMPANIES)
          .doc(company.companyEmail)
          .collection(Constants.TRIP)
          .doc(trip.id);
      trip.status = Constants.ENDED;
      batch.update(tripRef, trip.toJson());

      final DocumentReference<Map<String, dynamic>> vehicleRef =
          fireStore.collection(Constants.VEHICLES).doc(trip.vehicleRegNo);
      final ModelVehicle vehicle = ModelVehicle.fromDoc(await vehicleRef.get());
      vehicle.isInTrip = false;
      vehicle.latestOdometerReading =
          trip.endReading ?? vehicle.latestOdometerReading;
      batch.update(vehicleRef, vehicle.toJson());

      final DocumentReference<Map<String, dynamic>> driverRef =
          fireStore.collection(Constants.USERS).doc(user.phoneNumber);
      user.tripId = null;
      batch.update(driverRef, user.toJson());

      await batch.commit();
      callContext.setSuccess('Trip Ended');
      return callContext;
    } catch (e) {
      callContext.setError(e.toString());
      return callContext;
    }
  }

  Future<ModelTrip> getTripById(String id, String companyId) async {
    final DocumentSnapshot<Map<String, dynamic>> tripDoc = await fireStore
        .collection(Constants.COMPANIES)
        .doc(companyId)
        .collection(Constants.TRIP)
        .doc(id)
        .get();
    return ModelTrip.fromDoc(tripDoc);
  }

  Future<CallContext> cancelTrip(ModelTrip trip, BuildContext context) async {
    final ModelCompany company =
        Provider.of<AppData>(context, listen: false).selectedCompany!;
    final ModelUser user = Provider.of<AppData>(context, listen: false).user!;
    try {
      final WriteBatch batch = fireStore.batch();

      final DocumentReference<Map<String, dynamic>> tripRef = fireStore
          .collection(Constants.COMPANIES)
          .doc(company.companyEmail)
          .collection(Constants.TRIP)
          .doc(trip.id);
      trip.status = Constants.CANCELLED;
      trip.endDate = Timestamp.now();
      batch.update(tripRef, trip.toJson());

      final DocumentReference<Map<String, dynamic>> vehicleRef =
          fireStore.collection(Constants.VEHICLES).doc(trip.vehicleRegNo);
      final ModelVehicle vehicle = ModelVehicle.fromDoc(await vehicleRef.get());
      vehicle.isInTrip = false;
      batch.update(vehicleRef, vehicle.toJson());

      final DocumentReference<Map<String, dynamic>> driverRef =
          fireStore.collection(Constants.USERS).doc(user.phoneNumber);
      user.tripId = null;

      batch.update(
          driverRef, ModelUserCollectionReference.toFirestore(user, null));

      await batch.commit();
      callContext.setSuccess('Trip Cancelled');
      return callContext;
    } catch (e) {
      callContext.setError(e.toString());
      return callContext;
    }
  }

  Future<CallContext> filterTrips(BuildContext context, int? limit,
      {String? regNo, DateTime? from, DateTime? to}) async {
    final ModelCompany company =
        Provider.of<AppData>(context, listen: false).selectedCompany!;
    Query<Map<String, dynamic>> reference = fireStore
        .collection(Constants.COMPANIES)
        .doc(company.companyEmail)
        .collection(Constants.TRIP);
    if (regNo != null) {
      reference = reference.where('VehicleRegNo', isEqualTo: regNo);
    }
    if (from != null && to != null) {
      reference = reference.where('StartDate',
          isGreaterThan: Utils.getStartOfDay(from));
      reference =
          reference.where('StartDate', isLessThan: Utils.getEndOfDay(to));
    }

    QuerySnapshot<Map<String, dynamic>> snapShot;
    if (limit == null && from != null && to != null) {
      snapShot = await reference.orderBy('StartDate', descending: true).get();
    } else {
      snapShot = await reference
          .orderBy('StartDate', descending: true)
          .limit(limit!)
          .get();
    }

    callContext.data = ModelTrip.fromDocs(snapShot);
    return callContext;
  }

  Future<CallContext> getPendingBalanceTrips(BuildContext context,
      String? regNo, DocumentSnapshot<Object>? page) async {
    try {
      final ModelCompany company =
          Provider.of<AppData>(context, listen: false).selectedCompany!;
      Query<Map<String, dynamic>> reference = fireStore
          .collection(Constants.COMPANIES)
          .doc(company.companyEmail)
          .collection(Constants.TRIP);
      if (regNo != null) {
        reference = reference.where('VehicleRegNo', isEqualTo: regNo);
      }

      reference = reference.where('BalanceAmount', isGreaterThan: 0);
      QuerySnapshot<Map<String, dynamic>> snapShot;
      if (page != null) {
        snapShot = await reference
            .orderBy('BalanceAmount')
            .startAfterDocument(page)
            .limit(8)
            .get();
      } else {
        snapShot = await reference.limit(8).get();
      }
      if (snapShot.docs.isNotEmpty) {
        callContext.pageInfo = snapShot.docs[snapShot.docs.length - 1];
      }

      callContext.data = ModelTrip.fromDocs(snapShot);
    } catch (e) {
      callContext.setError(e.toString());
    }
    return callContext;
  }
}
