import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';

class RemoteWipeScreen extends StatefulWidget {
  const RemoteWipeScreen({super.key});

  @override
  State<RemoteWipeScreen> createState() => _RemoteWipeScreenState();
}

class _RemoteWipeScreenState extends State<RemoteWipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();

  String? _hexPin; // Stores the generated hexadecimal PIN

  // Function to generate a Hexadecimal PIN
  String _generateHexPin() {
    final random = Random();
    final bytes = List<int>.generate(4, (_) => random.nextInt(256));
    return base64Encode(bytes).substring(0, 8).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 1000, // Bigger box size
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 12, spreadRadius: 3),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            const Text(
              "🔴 Remote Wipe Request",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.redAccent),
            ),
            const SizedBox(height: 25),

            // Main Content: Reason and Form
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left: Bigger Writing Box
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade400, width: 1.2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "📝 Type the reason for doing?",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _reasonController,
                          maxLines: 7, // Bigger writing box
                          style: const TextStyle(fontSize: 16, color: Colors.black87),
                          decoration: InputDecoration(
                            hintText: "Enter your reason...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 25),

                // Right: User Details Form
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade400, width: 1.2),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildInputField(_nameController, "Full Name"),
                          _buildInputField(_addressController, "Address"),
                          _buildInputField(_companyController, "Mobile Company"),
                          _buildInputField(_phoneController, "Phone Number"),
                          _buildInputField(_pinCodeController, "Pin Code"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Bottom Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Remote Wipe Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Remote Wipe Request Sent!")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                  ),
                  child: const Text(
                    "🚨 Remote Wipe",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                // Block Button
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _hexPin = _generateHexPin(); // Generate PIN when block is pressed
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                  ),
                  child: const Text(
                    "🔒 Block Device",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            // Show Hexadecimal PIN if generated
            if (_hexPin != null) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade900,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Generated PIN: $_hexPin",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Helper method to build input fields
  Widget _buildInputField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) => value!.isEmpty ? "Please enter $label" : null,
      ),
    );
  }
}
