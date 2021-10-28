import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy_web/Common/AppData.dart';
import 'package:fleezy_web/Common/CallContext.dart';
import 'package:fleezy_web/Common/Constants.dart';
import 'package:fleezy_web/Common/Utils.dart';
import 'package:fleezy_web/DataModels/ModelCompany.dart';
import 'package:fleezy_web/DataModels/ModelExpense.dart';
import 'package:fleezy_web/DataModels/ModelTrip.dart';
import 'package:fleezy_web/DataModels/ModelVehicle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseApis {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  CallContext callContext = CallContext();

  Future<CallContext> addNewExpense(
      ModelExpense expense, ModelVehicle vehicle, BuildContext context) async {
    final ModelCompany company =
        Provider.of<AppData>(context, listen: false).selectedCompany!;
    final WriteBatch batch = fireStore.batch();
    final DocumentReference<Map<String, dynamic>> expenseRef = fireStore
        .collection(Constants.COMPANIES)
        .doc(company.companyEmail)
        .collection(Constants.EXPENSE)
        .doc();
    expense.id = expenseRef.id;
    batch.set(expenseRef, expense.toJson());

    final DocumentReference<Map<String, dynamic>> vehicleRef =
        fireStore.collection(Constants.VEHICLES).doc(vehicle.registrationNo);
    vehicle.latestOdometerReading = expense.odometerReading;
    batch.update(vehicleRef, vehicle.toJson());
    callContext.data = expense.id;
    await batch
        .commit()
        .then((dynamic value) => callContext.setSuccess('Expense added'))
        .catchError((dynamic error) => callContext.setError('$error'));
    return callContext;
  }

  Future<CallContext> getExpensesInTrip(
      ModelTrip trip, BuildContext context) async {
    final ModelCompany company =
        Provider.of<AppData>(context, listen: false).selectedCompany!;
    final QuerySnapshot<Map<String, dynamic>> snapShot = await fireStore
        .collection(Constants.COMPANIES)
        .doc(company.companyEmail)
        .collection(Constants.EXPENSE)
        .where('tripNo', isEqualTo: trip.id)
        .get();
    callContext.data = ModelExpense.fromDocs(snapShot);
    return callContext;
  }

  Future<CallContext> filterExpense(BuildContext context, int? limit,
      {String? regNo, DateTime? from, DateTime? to}) async {
    final ModelCompany company =
        Provider.of<AppData>(context, listen: false).selectedCompany!;
    Query<Map<String, dynamic>> reference = fireStore
        .collection(Constants.COMPANIES)
        .doc(company.companyEmail)
        .collection(Constants.EXPENSE);
    if (regNo != null) {
      reference = reference.where('vehicleRegNo', isEqualTo: regNo);
    }
    if (from != null && to != null) {
      reference = reference.where('timestamp',
          isGreaterThan: Utils.getStartOfDay(from));
      reference =
          reference.where('timestamp', isLessThan: Utils.getEndOfDay(to));
    }

    QuerySnapshot<Map<String, dynamic>> snapShot;
    if (limit == null && from != null && to != null) {
      snapShot = await reference.orderBy('timestamp', descending: true).get();
    } else {
      snapShot = await reference
          .orderBy('timestamp', descending: true)
          .limit(limit!)
          .get();
    }

    callContext.data = ModelExpense.fromDocs(snapShot);
    return callContext;
  }
}
