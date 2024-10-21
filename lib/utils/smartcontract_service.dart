import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:particle_base/particle_base.dart';
import 'package:particle_connect/particle_connect.dart';
import 'package:trustfund_app/abi/smartcontract_abi.dart';

class SmartcontractService {
  String message = '';

  Future<String> saveFlexContract({
    required WalletType wallet,
    required String publicAddress,
    required int savingsPlanType,
    required int frequency,
    required BigInt duration,
    required BigInt amount,
  }) async {
    String contractAddress = SmartcontractAbi.contractAddress;
    String methodName = "createFlexSavePlan";

    //String savingsPlanTypeHex = intToHex(savingsPlanType);
    String frequencyHex = intToHex(frequency);
    String durationHex = bigIntToHex(duration);
    String amountHex = bigIntToHex(amount);

    // this is the method params.
    List<Object> params = <Object>[
      frequencyHex,
      durationHex,
      amountHex,
    ];
    final jsonABI = jsonEncode(SmartcontractAbi.contractABI);
    final result = await EvmService.writeContract(
      publicAddress,
      amount,
      contractAddress,
      methodName,
      params,
      jsonABI,
      //gasFeeLevel: GasFeeLevel.high,
    );
    final signature = await ParticleConnect.signAndSendTransaction(
        wallet, publicAddress, result);
    // final signature = await Evm.sendTransaction(result);
    // print('Test123 $signature');
    // List<dynamic> transaction =
    //     await EvmService.getTransactionsByAddress(publicAddress);
    // print('Test0 ${transaction[0]['hash']}');
    message = signature;
    // print('Test123 $message');
    return result;
  }

  Future<String> secureSaveContract({
    required WalletType wallet,
    required String publicAddress,
    required int savingsPlanType,
    required BigInt duration,
    required BigInt amount,
  }) async {
    String contractAddress = SmartcontractAbi.contractAddress;
    String methodName = "createSecureSavePlan";

    String durationHex = bigIntToHex(duration);
    String amountHex = bigIntToHex(amount);

    // this is the method params.
    List<Object> params = <Object>[
      durationHex,
      amountHex,
    ];
    final jsonABI = jsonEncode(SmartcontractAbi.contractABI);
    final result = await EvmService.writeContract(
      publicAddress,
      amount,
      contractAddress,
      methodName,
      params,
      jsonABI,
      //gasFeeLevel: GasFeeLevel.high,
    );
    final signature = await ParticleConnect.signAndSendTransaction(
        wallet, publicAddress, result);
    // final signature = await Evm.sendTransaction(result);
    // print('Test123 $signature');
    // List<dynamic> transaction =
    //     await EvmService.getTransactionsByAddress(publicAddress);
    // print('Test0 ${transaction[0]['hash']}');
    message = signature;
    // print('Test123 $message');
    return result;
  }

  Future<String> goalSaveContract({
    required WalletType wallet,
    required String publicAddress,
    // required int savingsPlanType,
    required int frequency,
    // required BigInt duration,
    required BigInt amount,
    required BigInt targetAmount,
    required String savingsPurpose,
  }) async {
    String contractAddress = SmartcontractAbi.contractAddress;
    String methodName = "createGoalSavePlan";

    //String savingsPlanTypeHex = intToHex(savingsPlanType);
    String frequencyHex = intToHex(frequency);
    // String durationHex = bigIntToHex(duration);
    String amountHex = bigIntToHex(amount);
    String targetAmountHex = bigIntToHex(targetAmount);
    String savingsPurposeHex = stringToHex(savingsPurpose);
    // this is the method params.
    List<Object> params = <Object>[
      frequencyHex,
      amountHex,
      targetAmountHex,
      savingsPurposeHex,
    ];
    final jsonABI = jsonEncode(SmartcontractAbi.contractABI);
    final result = await EvmService.writeContract(
      publicAddress,
      amount,
      contractAddress,
      methodName,
      params,
      jsonABI,
      //gasFeeLevel: GasFeeLevel.high,
    );
    final signature = await ParticleConnect.signAndSendTransaction(
        wallet, publicAddress, result);
    // final signature = await Evm.sendTransaction(result);
    // print('Test123 $signature');
    // List<dynamic> transaction =
    //     await EvmService.getTransactionsByAddress(publicAddress);
    // print('Test0 ${transaction[0]['hash']}');
    message = signature;
    // print('Test123 $message');
    return result;
  }

  Future<String> addToFlexSaveContract({
    required WalletType wallet,
    required String publicAddress,
    required BigInt planId,
    required BigInt amount,
  }) async {
    String contractAddress = SmartcontractAbi.contractAddress;
    String methodName = "addToFlexSave";

    String planIdHex = bigIntToHex(planId);
    String amountHex = bigIntToHex(amount);

    // this is the method params.
    List<Object> params = <Object>[
      planIdHex,
      amountHex,
    ];
    final jsonABI = jsonEncode(SmartcontractAbi.contractABI);
    final result = await EvmService.writeContract(
      publicAddress,
      amount,
      contractAddress,
      methodName,
      params,
      jsonABI,
      //gasFeeLevel: GasFeeLevel.high,
    );
    final signature = await ParticleConnect.signAndSendTransaction(
        wallet, publicAddress, result);
    // final signature = await Evm.sendTransaction(result);
    // print('Test123 $signature');
    // List<dynamic> transaction =
    //     await EvmService.getTransactionsByAddress(publicAddress);
    // print('Test0 ${transaction[0]['hash']}');
    message = signature;
    // print('Test123 $message');
    return result;
  }

  Future<String> addToGoalSaveContract({
    required WalletType wallet,
    required String publicAddress,
    required BigInt planId,
    required BigInt amount,
  }) async {
    String contractAddress = SmartcontractAbi.contractAddress;
    String methodName = "addToGoalSave";

    String planIdHex = bigIntToHex(planId);
    String amountHex = bigIntToHex(amount);

    // this is the method params.
    List<Object> params = <Object>[
      planIdHex,
      amountHex,
    ];
    final jsonABI = jsonEncode(SmartcontractAbi.contractABI);
    final result = await EvmService.writeContract(
      publicAddress,
      amount,
      contractAddress,
      methodName,
      params,
      jsonABI,
      //gasFeeLevel: GasFeeLevel.high,
    );
    final signature = await ParticleConnect.signAndSendTransaction(
        wallet, publicAddress, result);
    // final signature = await Evm.sendTransaction(result);
    // print('Test123 $signature');
    // List<dynamic> transaction =
    //     await EvmService.getTransactionsByAddress(publicAddress);
    // print('Test0 ${transaction[0]['hash']}');
    message = signature;
    // print('Test123 $message');
    return result;
  }

  // Future<String> evmSendNative({
  //   required WalletType wallet,
  //   required String publicAddress,
  //   required BigInt amount,
  // }) async {
  //   String from = publicAddress;
  //   String receiver = SmartcontractAbi.contractAddress;
  //   BigInt value = amount;
  //   String to = receiver;
  //   const data = "0x";
  //   final transaction = await EvmService.createTransaction(
  //     from,
  //     data,
  //     value,
  //     to,
  //     // gasFeeLevel: GasFeeLevel.high,
  //   );
  //   final sign = await ParticleConnect.signAndSendTransaction(
  //       wallet, publicAddress, transaction);
  //   message = sign;
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

  // Helper to convert int to hex
  String intToHex(int value) {
    return '0x${value.toRadixString(16)}';
  }

  // Helper to convert String to hex
  String stringToHex(String value) {
    return value.runes
        .map((rune) => rune.toRadixString(16).padLeft(2, '0'))
        .join();
  }
}
