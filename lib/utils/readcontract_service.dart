import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:particle_base/particle_base.dart';
import 'package:trustfund_app/abi/smartcontract_abi.dart';
import 'package:web3dart/web3dart.dart';

class ReadcontractService extends ChangeNotifier {
  final List<dynamic> _savingsPlans = [];
  bool isloading = true;
  List<dynamic> get savingsPlans => _savingsPlans;

  Future<List<dynamic>> readSavingsPlansContract(String publicAddress) async {
    String contractAddress = SmartcontractAbi.contractAddress;
    String methodName = "getSavingsPlans";
    List<Object> parameters = <Object>[]; // this is the method params.

    // ABI for the getSavingsPlans function
    final abi = ContractAbi.fromJson(
        jsonEncode([
          {
            "inputs": [],
            "name": "getSavingsPlans",
            "outputs": [
              {
                "components": [
                  {
                    "internalType": "uint256",
                    "name": "savingsPlanId",
                    "type": "uint256"
                  },
                  {
                    "internalType": "uint8",
                    "name": "savingsPlanType",
                    "type": "uint8"
                  },
                  {
                    "internalType": "uint256",
                    "name": "startDate",
                    "type": "uint256"
                  },
                  {
                    "internalType": "uint256",
                    "name": "maturityDate",
                    "type": "uint256"
                  },
                  {
                    "internalType": "uint256",
                    "name": "interestRate",
                    "type": "uint256"
                  },
                  {
                    "internalType": "uint256",
                    "name": "interestEarned",
                    "type": "uint256"
                  },
                  {
                    "internalType": "uint8",
                    "name": "frequency",
                    "type": "uint8"
                  },
                  {
                    "internalType": "uint256",
                    "name": "duration",
                    "type": "uint256"
                  },
                  {
                    "internalType": "uint256",
                    "name": "amount",
                    "type": "uint256"
                  },
                  {
                    "internalType": "uint256",
                    "name": "timestamp",
                    "type": "uint256"
                  }
                ],
                "internalType": "tuple[]",
                "name": "",
                "type": "tuple[]"
              }
            ],
            "stateMutability": "view",
            "type": "function"
          }
        ]),
        'SavingsPlan');

    // Example ABI-encoded response from the contract (replace with actual response)
    final abiJsonString = jsonEncode(SmartcontractAbi.contractABI);
    final result = await EvmService.readContract(publicAddress, BigInt.zero,
        contractAddress, methodName, parameters, abiJsonString);

    final encodedResponse = result; // Truncated for brevity

    // Define the function
    final function =
        abi.functions.firstWhere((fn) => fn.name == "getSavingsPlans");

    // Decode the ABI-encoded response
    final decoded = function.decodeReturnValues(encodedResponse);

    decoded.map((m) => _savingsPlans.add(decoded[0])).toList();
    //  print('Old $savingsPlans');
    isloading = false;
    notifyListeners();
    return decoded;
  }

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
}
