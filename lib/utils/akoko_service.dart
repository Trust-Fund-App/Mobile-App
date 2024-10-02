import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:particle_base/particle_base.dart';
import 'package:particle_connect/particle_connect.dart';
import 'package:trustfund_app/abi/akoko_abi.dart';

class AkokoService {
  Future<String> writeContract({
    required WalletType wallet,
    required String publicAddress,
    required Uint8List uuid,
    required BigInt recipient,
    required BigInt amount,
  }) async {
    String contractAddress = AkokoAbi.contractAddress;
    String methodName = "placeOrder";

    // Convert UUID and recipient to hexadecimal strings
    String uuidHex = uint8ListToHex(uuid);
    String recipientHex = bigIntToHex(recipient);

    // this is the method params.
    List<Object> params = <Object>[
      uuidHex,
      recipientHex,
    ];
    final jsonABI = jsonEncode(AkokoAbi.contractABI);
    final result = await EvmService.writeContract(
      publicAddress,
      amount,
      contractAddress,
      methodName,
      params,
      jsonABI,
      //gasFeeLevel: GasFeeLevel.high,
    );
    ParticleConnect.signAndSendTransaction(wallet, publicAddress, result);

    return result;
  }

  // Future<String> evmSendNative(String publicAddress) async {
  //   String from = publicAddress;
  //   String receiver = '0xe735e92D7cad4c59BD8A819Ac53d3b77843EF9ca';
  //   BigInt amount = BigInt.from(1000000000000000);
  //   String to = receiver;
  //   const data = "0x";
  //   final transaction = await EvmService.createTransaction(
  //       from, data, amount, to,
  //       gasFeeLevel: GasFeeLevel.high);
  //   ParticleConnect.signAndSendTransaction(
  //       WalletType.authCore, publicAddress, transaction);

  //   return transaction;
  // }

  // Helper to convert Uint8List to hex
  String uint8ListToHex(Uint8List bytes) {
    return '0x${bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join()}';
  }

  // Helper to convert BigInt to hex
  String bigIntToHex(BigInt value) {
    return '0x${value.toRadixString(16)}';
  }
}
