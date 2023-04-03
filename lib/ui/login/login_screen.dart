import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:htf_artesanos/services/api/api_artisan_service.dart';

import 'package:htf_artesanos/ui/router/router.gr.dart';
import 'package:htf_artesanos/utils/custom_snackbar.dart';
import 'package:htf_artesanos/ui/layouts/base_layout.dart';
import 'package:htf_artesanos/utils/connectivity_helper.dart';
import 'package:htf_artesanos/utils/constants/constants.dart';
import 'package:htf_artesanos/domain/user_type/user_type.dart';
import 'package:htf_artesanos/ui/widgets/custom_dropdown.dart';
import 'package:htf_artesanos/ui/login/widgets/login_button.dart';
import 'package:htf_artesanos/ui/widgets/custom_text_form_field.dart';
import 'package:htf_artesanos/utils/extensions/string_extensions.dart';
import 'package:htf_artesanos/ui/login/widgets/signup_text_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  String? _userType;
  bool _isLoading = false;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var scSize = MediaQuery.of(context).size;

    return BaseLayout(
      body: Center(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                width: scSize.width,
                height: scSize.height * .65,
                child: Stack(
                  children: [
                    Positioned(
                      top: 35.h,
                      left: 20.w,
                      right: 20.w,
                      child: Container(
                        height: scSize.height * .56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: customGrey,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(3, 3),
                              color: Colors.black.withAlpha(60),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              SizedBox(height: 25.h),
                              Text(
                                '¡Bienvenido!',
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.bold,
                                  color: customBrown,
                                ),
                              ),
                              Text(
                                'Inicia sesión para continuar',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: customBrown,
                                ),
                              ),
                              _loginForm(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 45.w,
                      left: 45.w,
                      child: LoginButton(
                        onPressed: _login,
                        isLoading: _isLoading,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.sp),
                child: SignupTextButton(
                  onPressed: () => context.router.push(const Signup()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomDropdown(
            value: _userType,
            label: 'Selecciona tu tipo de usuario',
            items: _getUserTypes(),
            validatorFunction: (value) =>
                (value == null) ? 'Seleccione una opción' : null,
            setOnChangedValue: (value) => _userType = value,
          ),
          SizedBox(height: 10.h),
          CustomTextFormField(
            keyboardType: TextInputType.text,
            hintText: 'Usuario',
            textController: _usernameController,
            icon: Icons.person,
            validator: (value) => value!.validateEmpty(context),
          ),
          SizedBox(height: 10.h),
          CustomTextFormField(
            keyboardType: TextInputType.text,
            hintText: 'Contraseña',
            textController: _passwordController,
            last: true,
            obscured: true,
            icon: Icons.lock_outline,
            validator: (value) => value!.validateEmpty(context),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> _getUserTypes() {
    List<DropdownMenuItem<String>> list = [];
    for (UserType userType in UserType.defaultTypes()) {
      list.add(DropdownMenuItem(
        value: userType.id.toString(),
        child: Text(userType.description),
      ));
    }
    return list;
  }

  void setLoadState(bool state) {
    setState(() => _isLoading = state);
  }

  Future<void> _login() async {
    if (_isLoading) return;
    setLoadState(true);
    if (!await Connectivity().checkConnection) {
      if (context.mounted) {
        showMsnSnackbar('Verifique su conexión a internet e intente de nuevo.');
      }
      setLoadState(false);
      return;
    }
    if (!_formKey.currentState!.validate()) {
      showMsnSnackbar('Por favor llene los campos requeridos');
      setLoadState(false);
      return;
    }

    var username = _usernameController.text.trim();
    var password = _passwordController.text.trim();

    var response = await ApiArtisanService.instance.login(
      username: username,
      password: password,
      userType: int.parse(_userType!),
    );

    setLoadState(false);
    if (!response) {
      showMsnSnackbar(
        'Por favor revisa tus credenciales e intenta de nuevo',
      );
    } else {
      if (mounted) {
        context.router.pushAndPopUntil(const Dashboard(),
            predicate: (Route<dynamic> route) => false);
      }
    }
  }
}
