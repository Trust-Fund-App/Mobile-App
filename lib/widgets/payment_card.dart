import 'package:flutter/material.dart';

class PaymentCard extends StatefulWidget {
  const PaymentCard({super.key});

  @override
  State<PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  final TextEditingController amount = TextEditingController();
  final TextEditingController recipient = TextEditingController();

  String _dropdownCurrency = "GHS";
  String _dropdownAccount = "MTN";

  void dropdownCurrency(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownCurrency = selectedValue;
      });
    }
  }

  void dropdownAccount(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownAccount = selectedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'You Pay',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                DropdownButton(
                  items: const [
                    DropdownMenuItem(value: 'GHS', child: Text('₵ Cedis')),
                    DropdownMenuItem(value: 'NGN', child: Text('₦ Naira'))
                  ],
                  elevation: 15,
                  value: _dropdownCurrency,
                  onChanged: dropdownCurrency,
                  iconSize: 42,
                  iconEnabledColor: Colors.red,
                )
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: amount,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                hintText: "Pay Amount in $_dropdownCurrency",
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text("\$1 = ${_dropdownCurrency}16.00 "),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recipient',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                DropdownButton(
                  items: const [
                    DropdownMenuItem(value: 'MTN', child: Text('MTN MoMo')),
                    DropdownMenuItem(
                        value: 'Telecel', child: Text('Telecel Cash'))
                  ],
                  value: _dropdownAccount,
                  onChanged: dropdownAccount,
                  iconSize: 42,
                  iconEnabledColor: Colors.green,
                )
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: recipient,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                hintText: "Enter Recipient $_dropdownAccount Number",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
