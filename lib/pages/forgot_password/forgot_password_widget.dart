import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordWidget extends StatefulWidget {
  const ForgotPasswordWidget({Key? key}) : super(key: key);

  static String routeName = 'ForgotPassword';
  static String routePath = '/forgot-password';

  @override
  State<ForgotPasswordWidget> createState() => _ForgotPasswordWidgetState();
}

class _ForgotPasswordWidgetState extends State<ForgotPasswordWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock_reset, size: 80, color: Colors.blueAccent),
                  SizedBox(height: 24),
                  Text(
                    'Recuperar senha',
                    style: GoogleFonts.inter(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite seu e-mail';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                // Enviar instrução de redefinição
                              }
                            },
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('Enviar instrução',
                              style: GoogleFonts.inter(fontSize: 18)),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Lembrou a senha?'),
                      TextButton(
                        onPressed: () {
                          // Navegar para tela de login
                        },
                        child: Text('Entrar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
