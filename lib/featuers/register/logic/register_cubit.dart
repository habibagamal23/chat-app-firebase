import 'package:bloc/bloc.dart';
import 'package:chattest/core/firebase_service/firebase_Auth.dart';
import 'package:chattest/featuers/register/model/registerbody.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  /// object for class firebase auth to get register fun
  FirebaseAuthontion firebaseAuth = FirebaseAuthontion();

  /// controller  of my regisetr screen
  TextEditingController emailcon = TextEditingController();
  TextEditingController passcon = TextEditingController();
  TextEditingController usernamecon = TextEditingController();
  TextEditingController phoneecon = TextEditingController();

  /// formkey for my register screen
  final GlobalKey<FormState>  keyform = GlobalKey<FormState>();

  /// To toggle password visibility
  bool isPasswordVisible = false;

  /// Toggles password visibility
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(RegisterPasswordVisibilityToggled(isPasswordVisible));
  }

  /// function register
  Future register() async {
    if (!keyform.currentState!.validate()) {
      emit(RegisterFeliuer("user Not valdiate all data "));
      return;
    }
    emit(RegisterLoading());
    try {
      var registerbody = RegisterBody(
          email: emailcon.text,
          pass: passcon.text,
          username: usernamecon.text,
          phone: phoneecon.text);

      final user = await firebaseAuth.register(registerbody);
      if (user != null) {
        emit(RegisterSuccess());
      } else {
        emit(RegisterFeliuer("user is null"));
      }
    } catch (e) {
      emit(RegisterFeliuer("Error register func $e"));
    }
  }

  @override
  Future<void> close() {
    emailcon.dispose();
    usernamecon.dispose();
    phoneecon.dispose();
    phoneecon.dispose();
    // TODO: implement close
    return super.close();
  }
}
