import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_pages.dart';
import '../../extensions/loading_extensions.dart';

class SignInController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final formMessage = ''.obs;
  final mailController = TextEditingController();
  final pwController = TextEditingController();
  final authService = FirebaseAuth.instance;

  String forgotMail = '';

  @override
  void onClose() {
    super.onClose();
    mailController.dispose();
    pwController.dispose();
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      try {
        Get.context?.loadingDialogOpen();
        await authService.signInWithEmailAndPassword(
            email: mailController.text, password: pwController.text);
        Get.context?.loadingDialogClose();
        Get.offNamed(AppRoutes.HOME); // ignore: unawaited_futures
      } on FirebaseAuthException catch (e) {
        Get.context?.loadingDialogClose();
        formMessage.value = e.message ?? 'Giriş yapılamadı';
        debugPrint(e.message);
      } catch (e) {
        Get.context?.loadingDialogClose();
        formMessage.value = 'Giriş yapılamadı';
      }
    }
  }

  Future<void> submitForgotPw() async {
    if (forgotMail.isEmail) {
      Get.context?.loadingDialogOpen();
      await authService.sendPasswordResetEmail(email: forgotMail);
      Get.context?.loadingDialogClose();
    }
  }
}

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(
      () => SignInController(),
    );
  }
}