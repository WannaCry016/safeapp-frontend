import 'package:flutter/material.dart';
import 'package:frontend/user/app_security.dart';
import 'package:frontend/user/complaint.dart';
import 'package:frontend/user/home.dart';
import 'package:frontend/user/remote_wipe.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  int _selectedIndex = 0;
  String _username = "User"; // Default username

  // Fetch user info
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString("username") ?? "User";
    });
  }

  final List<String> _tabs = [
    "Home",
    "App Security",
    "Remote Wipe",
    "Complaint",
  ];

  final List<IconData> _tabIcons = [
    Icons.home,
    Icons.shield,
    Icons.delete_forever,
    Icons.report_problem,
  ];
  
  final List<Widget> _tabScreens = [ 
    HomeScreen(),
    AppSecurity(),
    RemoteWipeScreen(), 
    Complaint(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar with user profile
          Container(
            width: 250,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 1, blurRadius: 5),
              ],
            ),
            child: Column(
              children: [
                // User Profile
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("b4.jpg"), // Replace with actual image
                  backgroundColor: Colors.white,
                ),
                const SizedBox(height: 10),
                Text(
                  "Hey, $_username 👋",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 20),
                const Divider(color: Colors.white54, thickness: 1, indent: 20, endIndent: 20),

                // Navigation Tabs
                Expanded(
                  child: ListView.builder(
                    itemCount: _tabs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: Material(
                          color: _selectedIndex == index ? Colors.white24 : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          child: ListTile(
                            leading: Icon(_tabIcons[index], color: Colors.white),
                            title: Text(_tabs[index], style: const TextStyle(color: Colors.white)),
                            onTap: () {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const Divider(color: Colors.white54, thickness: 1, indent: 20, endIndent: 20),

                // Logout Button
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.white),
                  title: const Text("Logout", style: TextStyle(color: Colors.white)),
                  onTap: () {
                    // Implement logout functionality
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // Right Content Area (Dynamic)
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: _tabScreens[_selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}