import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:trustfund_app/styles/colors.dart';

class AddressQrWid extends StatelessWidget {
  const AddressQrWid({
    Key? key,
    required this.address,
    required this.icon,
    required this.name,
  }) : super(key: key);

  final String address;
  final String icon;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      // height: 340,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            height: 250,
            width: 250,
            decoration: BoxDecoration(
              color: AppColor.white,
              border: Border.all(color: AppColor.black),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: QrImageView(
                embeddedImage: NetworkImage(icon),
                data: address,
                version: QrVersions.auto,
                gapless: false,
                embeddedImageStyle: const QrEmbeddedImageStyle(
                  size: Size(40, 40),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => FlutterClipboard.copy(address).then((value) => null
                // showSnacky("Address Copied", true, context),
                ),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              height: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$name Address',
                        style: TextStyle(
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${address.substring(0, 10)}...${address.substring(address.length - 6, address.length)}",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                        child: Row(
                          children: [
                            SizedBox(
                              child: Icon(
                                Icons.copy_all,
                                color: AppColor.primaryColor,
                                size: 25.0,
                              ),
                            ),
                            Text(
                              "Copy",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColor.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
