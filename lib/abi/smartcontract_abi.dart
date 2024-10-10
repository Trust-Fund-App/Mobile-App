class SmartcontractAbi {
  static const contractAddress = '0x27752B90fb4a315959B76237B31562B63DB22aA7';

  static const contractABI = [
    {
      "inputs": [
        {
          "internalType": "enum SavingsPlan.SavingsPlanType",
          "name": "savingsPlanType",
          "type": "uint8"
        },
        {
          "internalType": "enum SavingsPlan.Frequency",
          "name": "frequency",
          "type": "uint8"
        },
        {"internalType": "uint256", "name": "duration", "type": "uint256"},
        {"internalType": "uint256", "name": "amount", "type": "uint256"}
      ],
      "name": "createSavingsPlan",
      "outputs": [],
      "stateMutability": "payable",
      "type": "function"
    },
    {"inputs": [], "stateMutability": "nonpayable", "type": "constructor"},
    {
      "inputs": [
        {"internalType": "address", "name": "owner", "type": "address"}
      ],
      "name": "OwnableInvalidOwner",
      "type": "error"
    },
    {
      "inputs": [
        {"internalType": "address", "name": "account", "type": "address"}
      ],
      "name": "OwnableUnauthorizedAccount",
      "type": "error"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "internalType": "address",
          "name": "user",
          "type": "address"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "amount",
          "type": "uint256"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "timestamp",
          "type": "uint256"
        }
      ],
      "name": "FundClaimed",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "internalType": "address",
          "name": "previousOwner",
          "type": "address"
        },
        {
          "indexed": true,
          "internalType": "address",
          "name": "newOwner",
          "type": "address"
        }
      ],
      "name": "OwnershipTransferred",
      "type": "event"
    },
    {
      "inputs": [],
      "name": "renounceOwnership",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "internalType": "uint256",
          "name": "savingsPlanId",
          "type": "uint256"
        },
        {
          "indexed": false,
          "internalType": "enum SavingsPlan.SavingsPlanType",
          "name": "savingsPlanType",
          "type": "uint8"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "startDate",
          "type": "uint256"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "maturityDate",
          "type": "uint256"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "interestRate",
          "type": "uint256"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "duration",
          "type": "uint256"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "amount",
          "type": "uint256"
        },
        {
          "indexed": true,
          "internalType": "address",
          "name": "creator",
          "type": "address"
        }
      ],
      "name": "SavingsPlanCreated",
      "type": "event"
    },
    {
      "inputs": [
        {"internalType": "address", "name": "newOwner", "type": "address"}
      ],
      "name": "transferOwnership",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [
        {"internalType": "uint256", "name": "planId", "type": "uint256"}
      ],
      "name": "withdrawSavings",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {"stateMutability": "payable", "type": "receive"},
    {
      "inputs": [],
      "name": "getCreditScore",
      "outputs": [
        {"internalType": "uint256", "name": "", "type": "uint256"}
      ],
      "stateMutability": "pure",
      "type": "function"
    },
    {
      "inputs": [
        {"internalType": "uint256", "name": "planId", "type": "uint256"}
      ],
      "name": "getSavingsPlanDetails",
      "outputs": [
        {
          "components": [
            {
              "internalType": "uint256",
              "name": "savingsPlanId",
              "type": "uint256"
            },
            {
              "internalType": "enum SavingsPlan.SavingsPlanType",
              "name": "savingsPlanType",
              "type": "uint8"
            },
            {"internalType": "uint256", "name": "startDate", "type": "uint256"},
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
              "internalType": "enum SavingsPlan.Frequency",
              "name": "frequency",
              "type": "uint8"
            },
            {"internalType": "uint256", "name": "duration", "type": "uint256"},
            {"internalType": "uint256", "name": "amount", "type": "uint256"},
            {"internalType": "uint256", "name": "timestamp", "type": "uint256"}
          ],
          "internalType": "struct SavingsPlan.SavingsPlanInfo",
          "name": "",
          "type": "tuple"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
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
              "internalType": "enum SavingsPlan.SavingsPlanType",
              "name": "savingsPlanType",
              "type": "uint8"
            },
            {"internalType": "uint256", "name": "startDate", "type": "uint256"},
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
              "internalType": "enum SavingsPlan.Frequency",
              "name": "frequency",
              "type": "uint8"
            },
            {"internalType": "uint256", "name": "duration", "type": "uint256"},
            {"internalType": "uint256", "name": "amount", "type": "uint256"},
            {"internalType": "uint256", "name": "timestamp", "type": "uint256"}
          ],
          "internalType": "struct SavingsPlan.SavingsPlanInfo[]",
          "name": "",
          "type": "tuple[]"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "getTotalAmountSaved",
      "outputs": [
        {"internalType": "uint256", "name": "", "type": "uint256"}
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "getWalletBalance",
      "outputs": [
        {"internalType": "uint256", "name": "", "type": "uint256"}
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "owner",
      "outputs": [
        {"internalType": "address", "name": "", "type": "address"}
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "PLATFORM_FEE_PERCENT",
      "outputs": [
        {"internalType": "uint256", "name": "", "type": "uint256"}
      ],
      "stateMutability": "view",
      "type": "function"
    }
  ];
}
