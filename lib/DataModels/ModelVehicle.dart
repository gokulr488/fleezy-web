import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy_web/Common/UiConstants.dart';
import 'package:fleezy_web/Common/Utils.dart';

class ModelVehicle {
  ModelVehicle(
      {this.vehicleName,
      required this.registrationNo,
      this.brand,
      required this.taxExpiryDate,
      required this.insuranceExpiryDate,
      required this.latestOdometerReading,
      required this.isInTrip,
      this.allowedDrivers,
      this.currentDriver,
      required this.companyId,
      this.avgMileage});

  String? vehicleName;
  String registrationNo;
  String? brand;
  String? currentDriver;
  Timestamp taxExpiryDate;
  Timestamp insuranceExpiryDate;
  int latestOdometerReading;
  String companyId;
  bool isInTrip;
  List<String>? allowedDrivers;
  double? avgMileage;

  Map<String, Object> toJson() {
    return <String, Object>{
      'VehicleName': vehicleName!,
      'RegistrationNo': registrationNo,
      'Brand': brand!,
      'TaxExpiryDate': taxExpiryDate,
      'InsuranceExpiryDate': insuranceExpiryDate,
      'LatestOdometerReading': latestOdometerReading,
      'IsInTrip': isInTrip,
      'CurrentDriver': currentDriver!,
      'AllowedDrivers': allowedDrivers!,
      'CompanyId': companyId,
      'AvgMileage': avgMileage!
    };
  }

  static ModelVehicle fromDoc(DocumentSnapshot<Object> doc) {
    final Map<String, dynamic> json = doc.data() as Map<String, dynamic>;

    return ModelVehicle(
      vehicleName: (json['VehicleName'] ?? '') as String,
      registrationNo: (json['RegistrationNo'] ?? '') as String,
      brand: (json['Brand'] ?? '') as String,
      taxExpiryDate: json['TaxExpiryDate'] as Timestamp,
      insuranceExpiryDate: json['InsuranceExpiryDate'] as Timestamp,
      latestOdometerReading: (json['LatestOdometerReading'] ?? 0) as int,
      isInTrip: (json['IsInTrip'] ?? false) as bool,
      currentDriver: (json['CurrentDriver'] ?? '') as String,
      allowedDrivers:
          List<String>.from(json['AllowedDrivers'] as List<dynamic>),
      companyId: (json['CompanyId'] ?? '') as String,
      avgMileage: (json['AvgMileage'] ?? 0) as double,
    );
  }

  static List<ModelVehicle> fromDocs(QuerySnapshot<Object> snapshot) {
    final List<ModelVehicle> vehicles = <ModelVehicle>[];
    for (final QueryDocumentSnapshot<Object> doc in snapshot.docs) {
      vehicles.add(fromDoc(doc));
    }
    return vehicles;
  }

  static ModelVehicle firstFromDocs(QuerySnapshot<Object> snapshot) {
    final DocumentSnapshot<Object> doc = snapshot.docs.first;
    return fromDoc(doc);
  }

  String getWarningMessage() {
    String warning = '';
    if (Utils.isWarningPeriod(insuranceExpiryDate)) {
      warning =
          'Insurance Expires on ${Utils.getFormattedTimeStamp(insuranceExpiryDate, kDateFormat)}. ';
    }
    if (Utils.isWarningPeriod(taxExpiryDate)) {
      warning =
          '${warning}Tax Expires on ${Utils.getFormattedTimeStamp(taxExpiryDate, kDateFormat)}';
    }
    return warning;
  }

  @override
  String toString() => '$registrationNo - $vehicleName';
}
