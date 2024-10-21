class SmartcontractAbi {
  static const contractAddress = '0xfdA3e91fe4a5f17bd7Dd47f6B0Fd72663af73a8c';

  static const contractABI = [
    {"type": "constructor", "inputs": [], "stateMutability": "nonpayable"},
    {"type": "receive", "stateMutability": "payable"},
    {
      "type": "function",
      "name": "PLATFORM_FEE_PERCENT",
      "inputs": [],
      "outputs": [
        {"name": "", "type": "uint256", "internalType": "uint256"}
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "addToFlexSave",
      "inputs": [
        {"name": "planId", "type": "uint256", "internalType": "uint256"},
        {"name": "amount", "type": "uint256", "internalType": "uint256"}
      ],
      "outputs": [],
      "stateMutability": "payable"
    },
    {
      "type": "function",
      "name": "addToGoalSave",
      "inputs": [
        {"name": "planId", "type": "uint256", "internalType": "uint256"},
        {"name": "amount", "type": "uint256", "internalType": "uint256"}
      ],
      "outputs": [],
      "stateMutability": "payable"
    },
    {
      "type": "function",
      "name": "canDepositNow",
      "inputs": [
        {"name": "planId", "type": "uint256", "internalType": "uint256"}
      ],
      "outputs": [
        {"name": "", "type": "bool", "internalType": "bool"},
        {"name": "reason", "type": "string", "internalType": "string"}
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "createFlexSavePlan",
      "inputs": [
        {
          "name": "frequency",
          "type": "uint8",
          "internalType": "enum TrustFund.Frequency"
        },
        {"name": "duration", "type": "uint256", "internalType": "uint256"},
        {"name": "amount", "type": "uint256", "internalType": "uint256"}
      ],
      "outputs": [
        {"name": "", "type": "uint256", "internalType": "uint256"}
      ],
      "stateMutability": "payable"
    },
    {
      "type": "function",
      "name": "createGoalSavePlan",
      "inputs": [
        {
          "name": "frequency",
          "type": "uint8",
          "internalType": "enum TrustFund.Frequency"
        },
        {"name": "amount", "type": "uint256", "internalType": "uint256"},
        {"name": "targetAmount", "type": "uint256", "internalType": "uint256"},
        {"name": "savingsPurpose", "type": "string", "internalType": "string"}
      ],
      "outputs": [
        {"name": "", "type": "uint256", "internalType": "uint256"}
      ],
      "stateMutability": "payable"
    },
    {
      "type": "function",
      "name": "createSecureSavePlan",
      "inputs": [
        {"name": "duration", "type": "uint256", "internalType": "uint256"},
        {"name": "amount", "type": "uint256", "internalType": "uint256"}
      ],
      "outputs": [
        {"name": "", "type": "uint256", "internalType": "uint256"}
      ],
      "stateMutability": "payable"
    },
    {
      "type": "function",
      "name": "getCreditScore",
      "inputs": [],
      "outputs": [
        {"name": "", "type": "uint256", "internalType": "uint256"}
      ],
      "stateMutability": "nonpayable"
    },
    {
      "type": "function",
      "name": "getMissedDeposits",
      "inputs": [],
      "outputs": [
        {"name": "", "type": "uint256", "internalType": "uint256"}
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "getNextDepositDueTime",
      "inputs": [
        {"name": "planId", "type": "uint256", "internalType": "uint256"}
      ],
      "outputs": [
        {"name": "", "type": "uint256", "internalType": "uint256"}
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "getRemainingGoalAmount",
      "inputs": [
        {"name": "planId", "type": "uint256", "internalType": "uint256"}
      ],
      "outputs": [
        {"name": "", "type": "uint256", "internalType": "uint256"}
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "getSavingsPlanDetails",
      "inputs": [
        {"name": "planId", "type": "uint256", "internalType": "uint256"}
      ],
      "outputs": [
        {
          "name": "",
          "type": "tuple",
          "internalType": "struct TrustFund.SavingsPlanInfo",
          "components": [
            {
              "name": "savingsPlanId",
              "type": "uint256",
              "internalType": "uint256"
            },
            {
              "name": "savingsPlanType",
              "type": "uint8",
              "internalType": "enum TrustFund.SavingsPlanType"
            },
            {"name": "startDate", "type": "uint256", "internalType": "uint256"},
            {
              "name": "maturityDate",
              "type": "uint256",
              "internalType": "uint256"
            },
            {
              "name": "interestRate",
              "type": "uint256",
              "internalType": "uint256"
            },
            {
              "name": "interestEarned",
              "type": "uint256",
              "internalType": "uint256"
            },
            {
              "name": "frequency",
              "type": "uint8",
              "internalType": "enum TrustFund.Frequency"
            },
            {"name": "duration", "type": "uint256", "internalType": "uint256"},
            {"name": "amount", "type": "uint256", "internalType": "uint256"},
            {
              "name": "targetAmount",
              "type": "uint256",
              "internalType": "uint256"
            },
            {
              "name": "savingsPurpose",
              "type": "string",
              "internalType": "string"
            },
            {"name": "timestamp", "type": "uint256", "internalType": "uint256"},
            {
              "name": "totalDeposited",
              "type": "uint256",
              "internalType": "uint256"
            },
            {
              "name": "hasReceivedSingleDeposit",
              "type": "bool",
              "internalType": "bool"
            },
            {
              "name": "lastDepositTime",
              "type": "uint256",
              "internalType": "uint256"
            },
            {
              "name": "nextDepositDue",
              "type": "uint256",
              "internalType": "uint256"
            }
          ]
        }
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "getSavingsPlans",
      "inputs": [],
      "outputs": [
        {
          "name": "",
          "type": "tuple[]",
          "internalType": "struct TrustFund.SavingsPlanInfo[]",
          "components": [
            {
              "name": "savingsPlanId",
              "type": "uint256",
              "internalType": "uint256"
            },
            {
              "name": "savingsPlanType",
              "type": "uint8",
              "internalType": "enum TrustFund.SavingsPlanType"
            },
            {"name": "startDate", "type": "uint256", "internalType": "uint256"},
            {
              "name": "maturityDate",
              "type": "uint256",
              "internalType": "uint256"
            },
            {
              "name": "interestRate",
              "type": "uint256",
              "internalType": "uint256"
            },
            {
              "name": "interestEarned",
              "type": "uint256",
              "internalType": "uint256"
            },
            {
              "name": "frequency",
              "type": "uint8",
              "internalType": "enum TrustFund.Frequency"
            },
            {"name": "duration", "type": "uint256", "internalType": "uint256"},
            {"name": "amount", "type": "uint256", "internalType": "uint256"},
            {
              "name": "targetAmount",
              "type": "uint256",
              "internalType": "uint256"
            },
            {
              "name": "savingsPurpose",
              "type": "string",
              "internalType": "string"
            },
            {"name": "timestamp", "type": "uint256", "internalType": "uint256"},
            {
              "name": "totalDeposited",
              "type": "uint256",
              "internalType": "uint256"
            },
            {
              "name": "hasReceivedSingleDeposit",
              "type": "bool",
              "internalType": "bool"
            },
            {
              "name": "lastDepositTime",
              "type": "uint256",
              "internalType": "uint256"
            },
            {
              "name": "nextDepositDue",
              "type": "uint256",
              "internalType": "uint256"
            }
          ]
        }
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "getTotalAmountSaved",
      "inputs": [],
      "outputs": [
        {"name": "", "type": "uint256", "internalType": "uint256"}
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "getWalletBalance",
      "inputs": [],
      "outputs": [
        {"name": "", "type": "uint256", "internalType": "uint256"}
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "owner",
      "inputs": [],
      "outputs": [
        {"name": "", "type": "address", "internalType": "address"}
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "renounceOwnership",
      "inputs": [],
      "outputs": [],
      "stateMutability": "nonpayable"
    },
    {
      "type": "function",
      "name": "transferOwnership",
      "inputs": [
        {"name": "newOwner", "type": "address", "internalType": "address"}
      ],
      "outputs": [],
      "stateMutability": "nonpayable"
    },
    {
      "type": "function",
      "name": "viewCreditScore",
      "inputs": [],
      "outputs": [
        {"name": "", "type": "uint256", "internalType": "uint256"}
      ],
      "stateMutability": "view"
    },
    {
      "type": "function",
      "name": "withdrawSavings",
      "inputs": [
        {"name": "planId", "type": "uint256", "internalType": "uint256"}
      ],
      "outputs": [],
      "stateMutability": "nonpayable"
    },
    {
      "type": "event",
      "name": "AdditionalDeposit",
      "inputs": [
        {
          "name": "savingsPlanId",
          "type": "uint256",
          "indexed": true,
          "internalType": "uint256"
        },
        {
          "name": "amount",
          "type": "uint256",
          "indexed": false,
          "internalType": "uint256"
        },
        {
          "name": "totalDeposited",
          "type": "uint256",
          "indexed": false,
          "internalType": "uint256"
        },
        {
          "name": "timestamp",
          "type": "uint256",
          "indexed": false,
          "internalType": "uint256"
        }
      ],
      "anonymous": false
    },
    {
      "type": "event",
      "name": "CreditScoreUpdated",
      "inputs": [
        {
          "name": "user",
          "type": "address",
          "indexed": true,
          "internalType": "address"
        },
        {
          "name": "newScore",
          "type": "uint256",
          "indexed": false,
          "internalType": "uint256"
        },
        {
          "name": "reason",
          "type": "string",
          "indexed": false,
          "internalType": "string"
        }
      ],
      "anonymous": false
    },
    {
      "type": "event",
      "name": "FundClaimed",
      "inputs": [
        {
          "name": "user",
          "type": "address",
          "indexed": true,
          "internalType": "address"
        },
        {
          "name": "amount",
          "type": "uint256",
          "indexed": false,
          "internalType": "uint256"
        },
        {
          "name": "timestamp",
          "type": "uint256",
          "indexed": false,
          "internalType": "uint256"
        }
      ],
      "anonymous": false
    },
    {
      "type": "event",
      "name": "OwnershipTransferred",
      "inputs": [
        {
          "name": "previousOwner",
          "type": "address",
          "indexed": true,
          "internalType": "address"
        },
        {
          "name": "newOwner",
          "type": "address",
          "indexed": true,
          "internalType": "address"
        }
      ],
      "anonymous": false
    },
    {
      "type": "event",
      "name": "SavingsPlanCreated",
      "inputs": [
        {
          "name": "savingsPlanId",
          "type": "uint256",
          "indexed": true,
          "internalType": "uint256"
        },
        {
          "name": "savingsPlanType",
          "type": "uint8",
          "indexed": false,
          "internalType": "enum TrustFund.SavingsPlanType"
        },
        {
          "name": "startDate",
          "type": "uint256",
          "indexed": false,
          "internalType": "uint256"
        },
        {
          "name": "maturityDate",
          "type": "uint256",
          "indexed": false,
          "internalType": "uint256"
        },
        {
          "name": "interestRate",
          "type": "uint256",
          "indexed": false,
          "internalType": "uint256"
        },
        {
          "name": "amount",
          "type": "uint256",
          "indexed": false,
          "internalType": "uint256"
        }
      ],
      "anonymous": false
    },
    {"type": "error", "name": "FrequencyNotAllowed", "inputs": []},
    {
      "type": "error",
      "name": "OwnableInvalidOwner",
      "inputs": [
        {"name": "owner", "type": "address", "internalType": "address"}
      ]
    },
    {
      "type": "error",
      "name": "OwnableUnauthorizedAccount",
      "inputs": [
        {"name": "account", "type": "address", "internalType": "address"}
      ]
    },
    {"type": "error", "name": "ReentrancyGuardReentrantCall", "inputs": []},
    {
      "type": "error",
      "name": "TooEarlyForDeposit",
      "inputs": [
        {"name": "timeRemaining", "type": "uint256", "internalType": "uint256"}
      ]
    }
  ];
}
