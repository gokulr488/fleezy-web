import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy_web/DataModels/ModelExpense.dart';
import 'package:fleezy_web/DataModels/ModelTrip.dart';
import 'package:fleezy_web/DataModels/ModelUser.dart';
import 'package:fleezy_web/DataModels/ModelVehicle.dart';

class ModelCompany {
  ModelCompany(
      {this.trip,
      this.users,
      this.expense,
      required this.companyName,
      required this.companyEmail,
      this.password,
      required this.phoneNumber,
      this.vehicles});

  String companyName;
  String companyEmail;
  String? password;
  String phoneNumber;
  Map<String, ModelVehicle>? vehicles;
  Map<String, ModelUser>? users;
  Map<String, ModelExpense>? expense;
  Map<String, ModelTrip>? trip;

  static Map<String, dynamic> getDocOf(ModelCompany company) {
    return <String, dynamic>{
      'CompanyName': company.companyName,
      'CompanyEmail': company.companyEmail,
      'Password': company.password,
      //'Vehicles': company.vehicles,
      'PhoneNumber': company.phoneNumber,
      'Users': _getListOfUsers(company.users),
      //'Expense': company.expense,
      //'Trip': company.trip
    };
  }

  static List<String>? _getListOfUsers(Map<String, ModelUser>? users) {
    if (users == null) return null;
    final List<String> userList = <String>[];
    for (final ModelUser user in users.values) {
      userList.add(user.phoneNumber);
    }
    return userList;
  }

  static ModelCompany fromDoc(DocumentSnapshot<dynamic> doc) {
    final Map<String, dynamic> json = doc.data() as Map<String, dynamic>;

    return ModelCompany(
      companyName: (json['CompanyName'] ?? '') as String,
      companyEmail: (json['CompanyEmail'] ?? '') as String,
      password: (json['Password'] ?? '') as String,
      //vehicles: data['Vehicles'] ?? '',
      phoneNumber: (json['PhoneNumber'] ?? '') as String,
      //users: data['Users'] ?? '',
      //expense: data['Expense'] ?? '',
      //trip: data['Trip'] ?? '',
    );
  }

  static List<ModelCompany> getCompanyFrom(QuerySnapshot<String> snapshot) {
    final List<ModelCompany> users = <ModelCompany>[];
    for (final DocumentSnapshot<String> doc in snapshot.docs) {
      users.add(fromDoc(doc));
    }
    return users;
  }

  static ModelCompany getUserFromSnapshot(QuerySnapshot<String> snapshot) {
    final DocumentSnapshot<String> doc = snapshot.docs.first;
    return fromDoc(doc);
  }
}
