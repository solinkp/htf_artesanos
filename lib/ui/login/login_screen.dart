import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:htf_artesanos/utils/constants/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _isLoading = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var scHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: customMossGreen,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: customMossGreen,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                height: scHeight * 0.65,
                decoration: const BoxDecoration(
                  color: customMossGreen,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
