import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  List<PlatformFile>? selectedAudioFiles;
  bool isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String serverUrl =
      'http://192.168.1.82:5000/login'; // Replace with your server URL

  Future<void> loginUser(String userId, String email, String password,
      List<PlatformFile>? audioFiles) async {
    setState(() {
      isLoading = true;
    });

    try {
      // Authenticate with Firebase
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Fetch the user document from Firestore
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        String storedUserId = userDoc.get('userId');

        if (storedUserId == userId) {
          // User ID matches, proceed with audio verification
          if (audioFiles != null && audioFiles.isNotEmpty) {
            var request = http.MultipartRequest('POST', Uri.parse(serverUrl));
            request.fields['test_speaker'] = userId; // Send user ID to server

            for (var file in audioFiles) {
              Uint8List fileBytes;
              if (file.bytes != null) {
                fileBytes = file.bytes!;
              } else if (file.path != null) {
                fileBytes = await File(file.path!).readAsBytes();
              } else {
                throw Exception('File has no bytes or path: ${file.name}');
              }

              request.files.add(
                http.MultipartFile.fromBytes(
                  'file',
                  fileBytes,
                  filename: file.name,
                  contentType: MediaType('audio', 'wav'),
                ),
              );
            }

            var response = await request.send();
            if (response.statusCode == 200) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Login successful')),
              );
              Navigator.pushReplacementNamed(context, '/welcome');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        'Voice verification failed: ${response.statusCode}')),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login successful (without audio)')),
            );
            Navigator.pushReplacementNamed(context, '/welcome');
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User ID does not match')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not found in Firestore')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error logging in: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> pickAudioFiles() async {
    List<PlatformFile> audioFiles = [];

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['wav'],
      allowMultiple: true,
    );

    if (result != null) {
      audioFiles = result.files;
      setState(() {
        selectedAudioFiles = audioFiles;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${audioFiles.length} files selected')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No audio files selected')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Smart_Health'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: userIdController,
              decoration: const InputDecoration(
                labelText:
                    'User ID', // Optional: Only if you want to display the User ID input
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await pickAudioFiles();
              },
              child: const Text('Pick Audio Files'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String userId =
                    userIdController.text.trim(); // Get user ID from text field
                String email = emailController.text.trim();
                String password = passwordController.text.trim();
                loginUser(userId, email, password, selectedAudioFiles);
              },
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Login'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/signup');
              },
              child: const Text('Don\'t have an account? Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
