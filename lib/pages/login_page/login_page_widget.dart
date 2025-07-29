import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  static String routeName = 'LoginPage';
  static String routePath = '/login';

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
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
                  // Logo
                  Icon(Icons.lock_outline, size: 80, color: Colors.blueAccent),
                  SizedBox(height: 24),
                  // Email
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
                  SizedBox(height: 16),
                  // Senha
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite sua senha';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  // Esqueci a senha
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Navegar para tela de esqueci a senha
                      },
                      child: Text('Esqueci a senha?'),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Botão Login
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                // Fazer login
                              }
                            },
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('Entrar',
                              style: GoogleFonts.inter(fontSize: 18)),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Login com Google
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      icon:
                          Icon(Icons.g_mobiledata, color: Colors.red, size: 28),
                      label: Text('Entrar com Google',
                          style: GoogleFonts.inter(fontSize: 16)),
                      onPressed: () {
                        // Login Google
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  // Login com biometria
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      icon: Icon(Icons.fingerprint,
                          color: Colors.blueAccent, size: 28),
                      label: Text('Entrar com digital',
                          style: GoogleFonts.inter(fontSize: 16)),
                      onPressed: () {
                        // Login biometria
                      },
                    ),
                  ),
                  SizedBox(height: 24),
                  // Criar nova conta
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Não tem uma conta?'),
                      TextButton(
                        onPressed: () {
                          // Navegar para tela de cadastro
                        },
                        child: Text('Criar nova conta'),
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
