import 'package:flutter/material.dart';
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/radius.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/widgets/buttons/bidButtonSendRequest.dart';
import 'package:liveasy/widgets/buttons/cancelButton.dart';

enum RadioButtonOptions { PER_TON, PER_TRUCK }

// ignore: must_be_immutable
class BidButtonAlertDialog extends StatefulWidget {
  String? loadId;

  BidButtonAlertDialog({this.loadId});

  @override
  _BidButtonAlertDialogState createState() => _BidButtonAlertDialogState();
}

class _BidButtonAlertDialogState extends State<BidButtonAlertDialog> {
  final formKey = GlobalKey<FormState>();
  TextEditingController rate = TextEditingController();
  RadioButtonOptions unit = RadioButtonOptions.PER_TON;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.only(left: space_4, right: space_4),
      title: Text(
        "Please enter your rate",
        style: TextStyle(fontSize: size_9, fontWeight: normalWeight),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Radio<RadioButtonOptions>(
                      value: RadioButtonOptions.PER_TON,
                      activeColor: darkBlueColor,
                      groupValue: unit,
                      onChanged: (value) {
                        setState(() {
                          unit = value!;
                        });
                      }),
                  Text(
                    "Per Tonne",
                    style: TextStyle(
                        fontWeight: mediumBoldWeight,
                        fontSize: size_7,
                        color: darkBlueColor),
                  ),
                ],
              ),
              Row(
                children: [
                  Radio<RadioButtonOptions>(
                      value: RadioButtonOptions.PER_TRUCK,
                      activeColor: darkBlueColor,
                      groupValue: unit,
                      onChanged: (value) {
                        setState(() {
                          unit = value!;
                        });
                      }),
                  Text(
                    "Per Truck",
                    style: TextStyle(
                        fontWeight: mediumBoldWeight,
                        fontSize: size_7,
                        color: darkBlueColor),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: darkGreyColor)),
            child: Padding(
              padding: EdgeInsets.only(
                left: space_2 - 2,
                right: space_2 - 2,
              ),
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: rate,
                decoration: InputDecoration(
                  hintText: "Eg 4000",
                  hintStyle: TextStyle(color: textLightColor),
                  border: InputBorder.none,
                ),
                validator: (value) => value!.isEmpty
                    ? 'Enter Rate'
                    : RegExp(r'^\d+(?:\.\d+)?$').hasMatch(value)
                        ? 'Enter a Valid Name'
                        : value.length < 3
                            ? 'Name must contain more than 3 characters'
                            : null,
              ),
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(top: space_16 + 6, bottom: space_4 + 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BidButtonSendRequest(
                  widget.loadId.toString(), rate.text, unit.toString()),
              CancelButton()
            ],
          ),
        )
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius_2 - 2)),
      ),
    );
  }
}
