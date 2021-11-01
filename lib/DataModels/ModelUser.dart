import 'package:cloud_firestore/cloud_firestore.dart';

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

  ModelUser.fromJson(Map<String, dynamic> json)
      : this(
          uid: json['Uid'] as String,
          roleName: (json['RoleName'] ?? '') as String,
          fullName: (json['FullName'] ?? '') as String,
          userEmailId: (json['EmailId'] ?? '') as String,
          phoneNumber: (json['PhoneNumber'] ?? '') as String,
          companyId: List<String>.from(json['CompanyId'] as List<dynamic>),
          state: (json['State'] ?? '') as String,
          tripId: json['TripId'],
        );

  String? uid;
  String roleName; //Avaiable roles Driver,Admin
  String? fullName;
  String? userEmailId;
  String phoneNumber; // Never allow modification of Number
  String? password;
  List<String> companyId;
  String state;
  String? tripId;

  Map<String, Object> toJson() {
    return <String, Object>{
      'Uid': uid!,
      'RoleName': roleName,
      'FullName': fullName ?? '',
      'EmailId': userEmailId ?? '',
      'PhoneNumber': phoneNumber,
      'CompanyId': companyId,
      'State': state,
      'TripId': tripId!
    };
  }

  static List<ModelUser> getUsersFrom(QuerySnapshot<ModelUser> snapshot) {
    final List<ModelUser> users = <ModelUser>[];
    for (final QueryDocumentSnapshot<ModelUser> doc in snapshot.docs) {
      users.add(doc.data());
    }
    return users;
  }

  @override
  String toString() => '$fullName - $phoneNumber';
}
