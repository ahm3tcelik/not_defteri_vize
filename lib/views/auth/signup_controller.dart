import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:not_defteri_vize/app_pages.dart';
import '../../extensions/loading_extensions.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final formMessage = ''.obs;
  final mailController = TextEditingController();
  final pwController = TextEditingController();
  final pwConfirmController = TextEditingController();
  final authService = FirebaseAuth.instance;

  @override
  void onClose() {
    super.onClose();
    mailController.dispose();
    pwController.dispose();
    pwConfirmController.dispose();
  }

  void signUp() async {
    if (formKey.currentState!.validate()) {
      try {
        Get.context?.loadingDialogOpen();
        await authService.createUserWithEmailAndPassword(
            email: mailController.text,
            password: pwController.text
        );
        Get.context?.loadingDialogClose();
        // ignore: unawaited_futures
        Get.offNamed(AppRoutes.HOME);
      } on FirebaseException catch (e) {
        formMessage.value =  e.message ?? 'Kayıt esnasında bir hata meydana geldi';
        Get.context?.loadingDialogClose();
      } catch (e) {
        Get.context?.loadingDialogClose();
        formMessage.value = 'Kayıt esnasında bir hata meydana geldi';
        debugPrint(e.toString());
      }
    }
  }
}

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}
