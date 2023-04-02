import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:htf_artesanos/utils/custom_snackbar.dart';
import 'package:htf_artesanos/ui/layouts/base_layout.dart';
import 'package:htf_artesanos/utils/connectivity_helper.dart';
import 'package:htf_artesanos/utils/constants/constants.dart';
import 'package:htf_artesanos/ui/widgets/custom_dropdown.dart';
import 'package:htf_artesanos/domain/user/create_user_dto.dart';
import 'package:htf_artesanos/ui/signup/widgets/signup_button.dart';
import 'package:htf_artesanos/services/api/api_artisan_service.dart';
import 'package:htf_artesanos/ui/widgets/custom_text_form_field.dart';
import 'package:htf_artesanos/utils/extensions/string_extensions.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _ageController;
  late TextEditingController _emailController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  String? _gender;
  final List<String> _genders = ['Hombre', 'Mujer'];
  bool _isLoading = false;

  @override
  void initState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _ageController = TextEditingController();
    _emailController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                Text(
                  'Llena el formulario para registrate',
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    color: customBrown,
                  ),
                ),
                SizedBox(height: 15.h),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        keyboardType: TextInputType.text,
                        hintText: 'Nombre',
                        textController: _firstNameController,
                        icon: Icons.contact_emergency_outlined,
                        validator: (value) => value!.validateEmpty(context),
                      ),
                      SizedBox(height: 10.h),
                      CustomTextFormField(
                        keyboardType: TextInputType.text,
                        hintText: 'Apellido',
                        textController: _lastNameController,
                        icon: Icons.contact_emergency_outlined,
                        validator: (value) => value!.validateEmpty(context),
                      ),
                      SizedBox(height: 10.h),
                      CustomTextFormField(
                        keyboardType: TextInputType.number,
                        hintText: 'Edad',
                        textController: _ageController,
                        icon: Icons.contact_emergency_outlined,
                        validator: (value) => value!.validateEmpty(context),
                        isNumber: true,
                      ),
                      SizedBox(height: 10.h),
                      CustomDropdown(
                        value: _gender,
                        label: 'Selecciona tu género',
                        items: _getGenders(),
                        validatorFunction: (value) =>
                            (value == null) ? 'Seleccione una opción' : null,
                        setOnChangedValue: (value) => _gender = value,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Correo',
                        textController: _emailController,
                        icon: Icons.email_outlined,
                        validator: (value) => value!.validateEmail(context),
                      ),
                      SizedBox(height: 10.h),
                      CustomTextFormField(
                        keyboardType: TextInputType.text,
                        hintText: 'Nombre de Usuario',
                        textController: _usernameController,
                        icon: Icons.person_outline,
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
                      SizedBox(height: 10.h),
                      SignupButton(onPressed: _signup, isLoading: _isLoading),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _getGenders() {
    List<DropdownMenuItem<String>> list = [];
    for (String gender in _genders) {
      list.add(DropdownMenuItem(
        value: gender,
        child: Text(gender),
      ));
    }
    return list;
  }

  void setLoadState(bool state) {
    setState(() => _isLoading = state);
  }

  void _signup() async {
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

    var newUser = CreateUserDTO(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      age: int.parse(_ageController.text.trim()),
      email: _emailController.text.trim(),
      username: _usernameController.text.trim(),
      password: _passwordController.text.trim(),
      gender: _gender!,
    );

    // api call
    var result = await ApiArtisanService.instance.signup(newUser: newUser);
    if (result) {
      showMsnSnackbar(
        'Usuario creado exitosamente, inicia sesión para continuar',
      );
      if (mounted) context.router.pop();
    } else {
      showMsnSnackbar(
        'Ha ocurrido un error en tu registro, por favor intenta de nuevo',
      );
    }
    setLoadState(false);
  }
}
