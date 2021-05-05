import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_pages.dart';
import '../../helpers/validator.dart';
import 'signup_controller.dart';

class SignUpView extends GetView<SignUpController> with Validator {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildHead,
              _buildBody,
            ],
          ),
        ),
      ).paddingAll(16),
    );
  }

  Widget get _buildHead {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          'assets/logo.png',
          width: 100,
          height: 100,
        ),
        const SizedBox(height: 4),
        Text('NOTEPAD', style: Get.textTheme.headline4),
        const SizedBox(height: 4),
        Text('Kayıt Ol', style: Get.textTheme.subtitle2),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget get _buildBody {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildMailField,
          const SizedBox(height: 8),
          _buildPwField,
          _buildPwConfirmField,
          _buildFormMessage,
          const SizedBox(height: 16),
          _buildSignUpBtn,
          const SizedBox(height: 8),
          _buildAlreadyHaveAccount
        ],
      ),
    );
  }

  Widget get _buildMailField {
    return Card(
      elevation: 2,
      child: TextFormField(
        controller: controller.mailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            prefixIcon: Icon(CupertinoIcons.mail), labelText: 'E-Posta'),
        validator: (value) => validateEmail(value),
      ),
    );
  }

  Widget get _buildPwField {
    return Card(
      elevation: 2,
      child: TextFormField(
        controller: controller.pwController,
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          prefixIcon: Icon(CupertinoIcons.lock),
          labelText: 'Parola',
        ),
        validator: (value) => validateCompareFields(
          value,
          controller.pwConfirmController.text,
        ),
      ),
    );
  }

  Widget get _buildPwConfirmField {
    return Card(
      elevation: 2,
      child: TextFormField(
        controller: controller.pwConfirmController,
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          prefixIcon: Icon(CupertinoIcons.lock),
          labelText: 'Parola (Tekrar)',
        ),
        validator: (value) => validateCompareFields(
          value,
          controller.pwController.text,
        ),
      ),
    );
  }

  Widget get _buildFormMessage {
    return Obx(() => Text(
          controller.formMessage.value,
          style: Get.textTheme.bodyText2!
              .copyWith(color: Get.theme.colorScheme.error),
        ));
  }

  Widget get _buildSignUpBtn {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: () => controller.signUp(),
        child: Text('KAYIT OL'),
      ),
    );
  }

  Widget get _buildAlreadyHaveAccount {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Zaten bir hesabın var mı?'),
        const SizedBox(width: 4),
        TextButton(
          onPressed: () => Get.offNamed(AppRoutes.SIGN_IN),
          child: Text(
            'Giriş Yap',
            style: Get.textTheme.bodyText2!
                .copyWith(color: Get.theme.colorScheme.primary),
          ),
        )
      ],
    );
  }
}
