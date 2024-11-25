import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../core/firebase_service/firebase_Auth.dart';
import '../model/loginBody.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  FirebaseAuthontion firebaseAuth = FirebaseAuthontion();

  /// Text controllers for email and password input fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  /// GlobalKey to validate the login form
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// To toggle password visibility
  bool isPasswordVisible = false;

  /// Toggles password visibility
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(LoginPasswordVisibilityToggled(isPasswordVisible));
  }

  ///  the login operation
  Future<void> login() async {
    /// Check if form is valid
    if (!formKey.currentState!.validate()) {
      emit(LoginFailure('Please fill in all fields correctly.'));
      return;
    }

    emit(LoginLoading());

    try {
      /// Create a login  body
      final LoginBody loginRequestBody = LoginBody(
        email: emailController.text,
        pass: passwordController.text.trim(),
      );

      /// Call the login service
      final user = await firebaseAuth.login(loginRequestBody);

      if (user != null) {
        emit(LoginSuccess(user));
      } else {
        emit(LoginFailure('Login failed. Please try again.'));
      }
    } catch (e) {
      emit(LoginFailure('An error occurred: $e'));
    }
  }

  /// Dispose all
  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
