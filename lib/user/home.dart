import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 750, // Increased width for better readability
        padding: const EdgeInsets.all(30), // Increased padding
        decoration: BoxDecoration(
          color: Colors.white, // Clean white background
          borderRadius: BorderRadius.circular(20), // Rounded corners for modern look
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "🔒 Welcome to SafeApp Dashboard",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87, // Dark text for contrast
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Your security is our priority.\n"
              "Use the navigation tabs to explore features.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(
              color: Colors.black26,
              thickness: 0.5,
              indent: 30,
              endIndent: 30,
            ),
            const SizedBox(height: 15),

            /// 🔹 **Detailed Feature Descriptions**
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "🌟 SafeApp Features & Usage Guidelines",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 15),

            /// 🛡️ **App Security**
            _buildFeatureSection(
              "🛡️ App Security",
              "Secure your personal and financial data with real-time threat detection and alerts. "
              "Ensure your device remains protected from malware, phishing attempts, and unauthorized access.",
            ),

            /// 📲 **Remote Wipe**
            _buildFeatureSection(
              "📲 Remote Wipe",
              "In case of theft or loss, remotely erase all personal data from your device. "
              "Simply provide your details, enter the PIN, and wipe your data instantly to prevent misuse.",
            ),

            /// 🚨 **Complaint System**
            _buildFeatureSection(
              "🚨 Complaint System",
              "Easily report fraudulent activities, data breaches, or suspicious activities. "
              "Use this feature to submit complaints directly to security authorities for immediate action.",
            ),

            const SizedBox(height: 20),

            /// 🚀 **Explore Features Button**
            ElevatedButton(
              onPressed: () {}, // Placeholder action
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Text(
                  "Explore Features",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 **Reusable Widget for Features**
  static Widget _buildFeatureSection(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
