// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleezy_web/Common/Authentication.dart';
import 'package:fleezy_web/Common/CallContext.dart';
import 'package:fleezy_web/Common/Constants.dart';
import 'package:fleezy_web/DataAccess/DAOs/Company.dart';
import 'package:fleezy_web/DataModels/ModelCompany.dart';
import 'package:fleezy_web/DataModels/ModelUser.dart';

class UserManagement {
  CallContext callContext = CallContext();
  User? user;

  Future<CallContext> addNewCompany(ModelCompany modelCompany) async {
    try {
      user = Authentication().getUser();
      if (user != null) {
        print('Adding Company to Database with default Admin user');
        final ModelUser adminUser = ModelUser(
            fullName: Constants.ADMIN,
            companyId: <String>[modelCompany.companyEmail],
            phoneNumber: modelCompany.phoneNumber,
            userEmailId: modelCompany.companyEmail,
            roleName: Constants.ADMIN,
            state: Constants.ACTIVE,
            uid: user?.uid);
        modelCompany.users = <String, ModelUser>{
          adminUser.phoneNumber: adminUser
        };
        await Company().addCompany(modelCompany);

        callContext.setSuccess('Company & Admin user added to DB');
      }
      return callContext;
    } catch (e) {
      callContext.setError('Unable to Create Company');
      await Authentication().deleteUser();
      print(e);
      return callContext;
    }
  }

  Future<CallContext> addUserToCompany(ModelUser user) async {
    return callContext;
  }
}
