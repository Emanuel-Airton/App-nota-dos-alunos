import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuthPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _PhoneAuthPageState createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  bool verificado = false;
  String? _verificationId;

  void _verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: _phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieval or instant verification
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        debugPrint("Failed: ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          _verificationId = verificationId;
        });
      },
    );
  }

  void _signInWithPhoneNumber() async {
    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: _codeController.text,
    );

    try {
      await _auth.signInWithCredential(credential);
      final User? user = _auth.currentUser;
      if (user != null) {
        debugPrint('User signed in: ${user.uid}');
        // Aqui você pode atualizar o perfil do usuário
        updatePhoneNumber(credential);
        setState(() {
          verificado = true;
        });
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    }
  }

  updatePhoneNumber(PhoneAuthCredential credential) async {
    try {
      final User? user = _auth.currentUser;
      await user!.updatePhoneNumber(credential);
      debugPrint(
          'Phone number updated successfully for user: ${user.uid}, ${user.phoneNumber}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        debugPrint(e.code);
      } else if (e.code == 'invalid-verification-id') {
        debugPrint(e.code);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone number'),
            ),
            ElevatedButton(
              onPressed: _verifyPhoneNumber,
              child: const Text('Verify Phone Number'),
            ),
            TextField(
              controller: _codeController,
              decoration: const InputDecoration(labelText: 'Verification code'),
            ),
            ElevatedButton(
              onPressed: () {
                try {
                  _signInWithPhoneNumber();
                } catch (e) {
                  debugPrint(e.toString());
                }
              },
              child: const Text('Sign in'),
            ),
          ],
        ),
      ),
    );
  }
}
