import 'package:fleezy_web/Common/UiConstants.dart';
import 'package:fleezy_web/Components/cards/BaseCard.dart';
import 'package:fleezy_web/DataModels/ModelVehicle.dart';
import 'package:flutter/material.dart';

class VehicleCard extends StatelessWidget {
  const VehicleCard({
    this.color,
    this.message,
    required this.vehicle,
  });
  static const TextStyle _kRegistrationNumberTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: kTextColor);
  static const TextStyle _kDriverTextStyle =
      TextStyle(fontSize: 17, color: kTextColor, fontWeight: FontWeight.bold);
  static const TextStyle _kMessagesTextStyle =
      TextStyle(color: Colors.red, fontWeight: FontWeight.bold);
  final Color? color;
  final String? message;
  final ModelVehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      cardChild: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: SizedBox(
              width: 150,
              height: 100,
              child: Image.asset(
                'assets/images/startPageImage.jpg',
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(vehicle.registrationNo,
                  style: _kRegistrationNumberTextStyle),
              Text(vehicle.vehicleName ?? '', style: _kDriverTextStyle),
              Text('Driver: ${vehicle.currentDriver ?? ''}',
                  style: _kDriverTextStyle),
              SizedBox(
                  width: 200,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(message ?? '', style: _kMessagesTextStyle)))
            ],
          )
        ],
      ),
      elevation: 4,
      color: color,
    );
  }
}
