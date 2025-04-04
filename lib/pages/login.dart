import 'package:flutter/material.dart';
import 'package:frontend/pages/dashboard_admin.dart';
import 'package:frontend/pages/dashboard_user.dart';
import 'package:frontend/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  String _selectedRole = "User"; // Default role

  // Handle Login
  Future<void> handleLogin() async { 
    setState(() => _isLoading = true);

    // AuthService.login now returns a Map<String, dynamic>?, not just a String
    Map<String, dynamic>? result = await AuthService.login(
      usernameController.text.trim(),
      passwordController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (result != null && result.containsKey("token")) {
      String token = result["token"];
      String role = result["role"]; // If you want to use the role

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login Successful!")),
      );

      // Navigate based on role
      if (role == "Admin") {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminDashboard()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserDashboard()));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid Credentials")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            "b2.jpg",
            fit: BoxFit.cover,
          ),

          // Dark overlay for better contrast
          Container(color: Colors.black.withOpacity(0.5)),

          // Login UI
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: 1120,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1), // Transparent White Box
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    // Left Info Box
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                "Welcome to SafeApp DashBoard",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "Your financial apps contain sensitive data, and online fraud is rising every day. "
                              "SafeApp is here to protect your transactions, safeguard your OTPs, and secure your digital banking experience.",
                              style: const TextStyle(fontSize: 14, color: Colors.white70),
                            ),
                            const SizedBox(height: 20),
                            _buildFeature("Prevent OTP Theft", "OTPs are securely managed to block unauthorized access."),
                            _buildFeature("AI-Powered Fraud Monitoring", "Detects suspicious activities in real-time."),
                            _buildFeature("Remote Device Wipe", "Instantly erase data if your phone is lost or stolen."),
                            _buildFeature("Protects Banking & Wallet Apps", "Only whitelisted apps can access financial data."),
                            _buildFeature("Secure & Trusted", "Built with advanced security standards to keep you safe."),
                            const SizedBox(height: 20),
                            Text(
                              "📢 Your security, our priority! Stay ahead of cyber threats and keep your financial assets protected with SafeApp.",
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Right Login Box
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.lock, size: 50, color: Colors.white),
                            const SizedBox(height: 15),
                            const Text(
                              "SAFE APP LOGIN",
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            const SizedBox(height: 20),

                            // Role Selection
                            SizedBox(
                              width: double.infinity, // Controls input box width
                              child: DropdownButtonFormField<String>(
                                value: _selectedRole,
                                dropdownColor: Colors.black87,
                                decoration: InputDecoration(
                                  labelText: "Role",
                                  prefixIcon: const Icon(Icons.person_outline, color: Colors.white),
                                  filled: true,
                                  fillColor: Colors.white24,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                                items: ["User", "Admin"].map((role) {
                                  return DropdownMenuItem(
                                    value: role,
                                    child: Text(role, style: const TextStyle(color: Colors.white)),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedRole = value!;
                                  });
                                },
                                menuMaxHeight: 150, // Limits menu height
                                isDense: true, // Makes the dropdown button compact
                                style: const TextStyle(color: Colors.white),
                                borderRadius: BorderRadius.circular(10), // Round edges for dropdown
                              ),
                            ),
                            const SizedBox(height: 15),

                            // Username Field
                            TextField(
                              controller: usernameController,
                              decoration: InputDecoration(
                                labelText: "Username",
                                prefixIcon: const Icon(Icons.person),
                                filled: true,
                                fillColor: Colors.white24,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            const SizedBox(height: 15),

                            // Password Field
                            TextField(
                              controller: passwordController,
                              obscureText: !_isPasswordVisible,
                              decoration: InputDecoration(
                                labelText: "Password",
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                ),
                                filled: true,
                                fillColor: Colors.white24,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            const SizedBox(height: 20),

                            _isLoading
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: handleLogin,
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                                      backgroundColor: Colors.blueAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Text("Login as $_selectedRole",
                                        style: const TextStyle(fontSize: 18, color: Colors.white)),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper function for features
  Widget _buildFeature(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.blueAccent, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 14, color: Colors.white),
                children: [
                  TextSpan(
                    text: "$title: ",
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  TextSpan(text: description, style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
