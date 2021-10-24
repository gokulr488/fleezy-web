// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy_web/Common/CallContext.dart';
import 'package:fleezy_web/Common/Constants.dart';
import 'package:fleezy_web/DataAccess/DAOs/Roles.dart';
import 'package:fleezy_web/DataModels/ModelCompany.dart';

class Company {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  CallContext callContext = CallContext();

  Future<CallContext> addCompany(ModelCompany company) async {
    final DocumentSnapshot<Map<String, dynamic>> snapShot = await fireStore
        .collection(Constants.COMPANIES)
        .doc(company.companyEmail)
        .get();
    if (snapShot.exists) {
      callContext.setError('Company already exists');
      return callContext;
    }

    await fireStore
        .collection(Constants.COMPANIES)
        .doc(company.companyEmail)
        .set(ModelCompany.getDocOf(company))
        .then((dynamic value) => print('Company Added'))
        .catchError((dynamic error) {
      callContext.setError('Failed to add company: $error');
    });
    if (callContext.isError) {
      return callContext;
    }

    return Roles().addRole(company.users!.values.first);
  }

  Future<void> updateCompany(ModelCompany company) async {
    return fireStore
        .collection(Constants.COMPANIES)
        .doc(company.companyEmail)
        .update(<String, String>{
          'CompanyName': company.companyName,
          'CompanyEmail': company.companyEmail,
          'PhoneNumber': company.phoneNumber,
        })
        .then((dynamic value) => print('Company details updated'))
        .catchError(
            (dynamic error) => print('Failed to update company: $error'));
  }
}
