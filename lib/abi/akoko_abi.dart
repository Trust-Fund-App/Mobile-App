class AkokoAbi {
  static const contractAddress = '0x10846782C728a193102A7cf3a7c40E2071Ebc958';

  static const contractABI = [
    {"inputs": [], "stateMutability": "nonpayable", "type": "constructor"},
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "internalType": "bytes32",
          "name": "uuid",
          "type": "bytes32"
        },
        {
          "indexed": true,
          "internalType": "uint256",
          "name": "amount",
          "type": "uint256"
        },
        {
          "indexed": true,
          "internalType": "uint256",
          "name": "recipient",
          "type": "uint256"
        }
      ],
      "name": "OrderPlaced",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": true,
          "internalType": "bytes32",
          "name": "uuid",
          "type": "bytes32"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "amount",
          "type": "uint256"
        }
      ],
      "name": "Payout",
      "type": "event"
    },
    {"stateMutability": "payable", "type": "fallback"},
    {
      "inputs": [
        {"internalType": "uint256", "name": "", "type": "uint256"}
      ],
      "name": "escrowBalances",
      "outputs": [
        {"internalType": "uint256", "name": "", "type": "uint256"}
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {"internalType": "uint256", "name": "", "type": "uint256"}
      ],
      "name": "orders",
      "outputs": [
        {"internalType": "bytes32", "name": "uuid", "type": "bytes32"},
        {
          "internalType": "enum Akoko.Status",
          "name": "status",
          "type": "uint8"
        },
        {"internalType": "uint256", "name": "amount", "type": "uint256"},
        {"internalType": "uint256", "name": "recipient", "type": "uint256"}
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
      "inputs": [
        {"internalType": "bytes32", "name": "_uuid", "type": "bytes32"}
      ],
      "name": "payout",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [
        {"internalType": "bytes32", "name": "_uuid", "type": "bytes32"},
        {"internalType": "uint256", "name": "_recipient", "type": "uint256"}
      ],
      "name": "placeOrder",
      "outputs": [],
      "stateMutability": "payable",
      "type": "function"
    },
    {"stateMutability": "payable", "type": "receive"}
  ];
}
