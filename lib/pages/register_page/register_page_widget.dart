import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPageWidget extends StatefulWidget {
  const RegisterPageWidget({Key? key}) : super(key: key);

  static String routeName = 'RegisterPage';
  static String routePath = '/register';

  @override
  State<RegisterPageWidget> createState() => _RegisterPageWidgetState();
}

class _RegisterPageWidgetState extends State<RegisterPageWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  // String? _profileImagePath;

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
                  // Foto de perfil
                  GestureDetector(
                    onTap: () {
                      // Selecionar foto de perfil
                    },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.camera_alt,
                          size: 36, color: Colors.grey[700]),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Nome
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Nome completo',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite seu nome';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
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
                        return 'Digite uma senha';
                      }
                      if (value.length < 6) {
                        return 'A senha deve ter pelo menos 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  // Confirmar senha
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      labelText: 'Confirmar senha',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirme sua senha';
                      }
                      if (value != _passwordController.text) {
                        return 'As senhas não coincidem';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  // Botão cadastrar
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                // Cadastrar usuário
                              }
                            },
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('Cadastrar',
                              style: GoogleFonts.inter(fontSize: 18)),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Voltar para login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Já tem uma conta?'),
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
