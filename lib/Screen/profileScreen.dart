import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_yuk/Screen/loginScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  DocumentSnapshot? userProfileData;

  @override
  void initState() {
    super.initState();
    if (user != null) {
      _fetchUserProfile();
    }
  }

  Future<void> _fetchUserProfile() async {
    try {
      userProfileData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection("User Information")
          .doc("user_info")
          .get();
      // Update the UI only if the widget is still mounted
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print(e.toString());
      // Handle errors here
    }
  }

  // Menambahkan fungsi untuk logout
  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Redirect ke halaman login setelah logout
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      print(e.toString());
      // Handle errors here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          // Menambahkan tombol logout ke AppBar
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _logout();
            },
          ),
        ],
      ),
      body: user != null ? _buildProfileView() : _buildLoginButton(),
    );
  }

  Widget _buildLoginButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        },
        child: const Text('Login'),
      ),
    );
  }

  Widget _buildProfileView() {
    if (userProfileData != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user?.photoURL ?? ''),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(height: 20),
            Text(
              userProfileData?['fullName'] ?? 'Name Not Available',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              userProfileData?['email'] ?? 'Email Not Available',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add action for editing profile
              },
              child: const Text('Edit Profile'),
            ),
            // Add more profile options here
          ],
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
