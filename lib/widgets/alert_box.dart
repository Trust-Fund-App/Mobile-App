import 'package:flutter/material.dart';
import 'package:trustfund_app/styles/colors.dart';

class CustomAlert extends StatefulWidget {
  const CustomAlert({Key? key}) : super(key: key);

  @override
  CustomAlertState createState() => CustomAlertState();
}

class CustomAlertState extends State<CustomAlert> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SizedBox(
        width: 160,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          color: Colors.white,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Wrap(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                color: AppColor.white,
                child: Column(
                  children: <Widget>[
                    Container(height: 10),
                    Icon(
                      Icons.verified,
                      color: AppColor.primaryColor,
                      size: 60,
                    ),
                    Container(height: 10),
                    Text("Thanks for your interest",
                        style: TextStyle(
                          color: AppColor.black.withOpacity(0.7),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        )),
                    Container(height: 10),
                  ],
                ),
              ),
              Container(
                color: AppColor.white,
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                child: Column(
                  children: [
                    Text("This feature will be available for you soon!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: AppColor.black,
                        )),
                    Container(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.black,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                      ),
                      child: Text(
                        "Understood",
                        style: TextStyle(
                          color: AppColor.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        // MyToast.show("Get Started clicked", context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
