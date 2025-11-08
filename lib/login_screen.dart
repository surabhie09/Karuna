import 'package:flutter/material.dart';
import 'services/auth_service.dart';
import 'services/firestore_service.dart';
import 'models.dart';

// --- LOGIN SCREEN (For Donor or NGO Login based on navigation) ---

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _userType;
  late String _title;
  late String _route;
  late String _message;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    _userType = args['userType']!;
    if (_userType == 'donor') {
      _title = 'Donor Login';
      _route = '/donorHome';
      _message = 'Donor logged in successfully!';
    } else {
      _title = 'NGO Login';
      _route = '/ngoHome';
      _message = 'NGO logged in successfully!';
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        // Sign in with Firebase Auth
        final userCredential = await _authService.signIn(
          _emailController.text.trim(),
          _passwordController.text,
        );

        // Fetch user data from Firestore to verify user type
        final userDoc = await _firestoreService.getUser(userCredential.user!.uid);
        if (userDoc != null && userDoc['userType'] == _userType) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(_message)),
            );
            // Navigate to respective Home
            Navigator.pushNamedAndRemoveUntil(context, _route, (route) => false);
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid user type for this login.')),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed: ${e.toString()}')),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildTextField(context, 'Email Address', Icons.mail, keyboardType: TextInputType.emailAddress, controller: _emailController),
              const SizedBox(height: 15),
              _buildPasswordField(context, 'Password', _passwordController),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : _buildLoginButton(context, 'Login', _submitForm),
            ],
          ),
        ),
      ),
    );
  }

// --- GLOBAL HELPER WIDGETS ---

InputDecoration _inputDecoration(BuildContext context, String label, IconData icon) {
  return InputDecoration(
    labelText: label,
    prefixIcon: Icon(icon, color: Theme.of(context).primaryColor.withOpacity(0.7)),
    border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
  );
}

Widget _buildTextField(BuildContext context, String label, IconData icon, {TextInputType keyboardType = TextInputType.text, bool isPassword = false, TextEditingController? controller}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    obscureText: isPassword,
    decoration: _inputDecoration(context, label, icon),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your $label';
      }
      return null;
    },
  );
}

Widget _buildPasswordField(BuildContext context, String label, TextEditingController controller) {
  return TextFormField(
    controller: controller,
    obscureText: true,
    decoration: _inputDecoration(context, label, Icons.lock),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your $label';
      }
      if (value.length < 6) {
        return 'Password must be at least 6 characters';
      }
      return null;
    },
  );
}

Widget _buildLoginButton(BuildContext context, String label, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).primaryColor,
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
    ),
    child: Text(label, style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
  );
}
}
