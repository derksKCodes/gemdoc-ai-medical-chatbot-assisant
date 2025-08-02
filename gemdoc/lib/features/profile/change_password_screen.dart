import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gemdoc/core/constants/app_colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;


Future<void> _changePassword() async {
  if (!_formKey.currentState!.validate()) return;

  final user = FirebaseAuth.instance.currentUser;

  if (user == null) return;

  // Prevent social login users from changing password
  if (user.providerData.any((info) => info.providerId != 'password')) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("This action is not supported for social logins")),
    );
    return;
  }

  final cred = EmailAuthProvider.credential(
    email: user.email!,
    password: _currentPasswordController.text.trim(),
  );

  setState(() => _isLoading = true);

  try {
    await user.reauthenticateWithCredential(cred);

    if (!mounted) return;

    await user.updatePassword(_newPasswordController.text.trim());

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password changed successfully')),
    );
    Navigator.pop(context);
  } on FirebaseAuthException catch (e) {

    if (!mounted) return;
    String msg = switch (e.code) {
      'wrong-password' => 'Current password is incorrect.',
      'too-many-requests' => 'Too many attempts. Try again later.',
      _ => e.message ?? 'Error updating password',
    };
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  } finally {
    if (!mounted) setState(() => _isLoading = false);
  }
}


  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        backgroundColor: AppColors.primary,
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _currentPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Current Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your current password.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'New Password'),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Password must be at least 6 characters.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration:
                    const InputDecoration(labelText: 'Confirm Password'),
                validator: (value) {
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                icon: const Icon(Icons.lock_reset),
                label: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Update Password'),
                onPressed: _isLoading ? null : _changePassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
