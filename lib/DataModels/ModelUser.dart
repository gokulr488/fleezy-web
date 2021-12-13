import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:json_annotation/json_annotation.dart';
part 'ModelUser.g.dart';

@JsonSerializable()
class ModelUser {
  ModelUser(
      {this.uid,
      required this.roleName,
      this.fullName,
      this.userEmailId,
      required this.phoneNumber,
      this.password,
      required this.companyId,
      required this.state,
      this.tripId});

  String? uid;
  String roleName; //Avaiable roles Driver,Admin
  String? fullName;
  String? userEmailId;
  String phoneNumber; // Never allow modification of Number
  String? password;
  List<String> companyId;
  String state;
  String? tripId;

  @override
  String toString() => '$fullName  $phoneNumber';
}

@Collection<ModelUser>('/Users/')
final usersRef = ModelUserCollectionReference();
