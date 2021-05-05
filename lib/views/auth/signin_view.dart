import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_pages.dart';
import '../../helpers/validator.dart';
import 'signin_controller.dart';

class SignInView extends GetView<SignInController> with Validator {
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
          ).paddingAll(16),
        ),
      ),
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
        Text('Giriş Yap', style: Get.textTheme.subtitle2),
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
          const SizedBox(height: 8),
          _buildForgotPw,
          _buildFormMessage,
          const SizedBox(height: 16),
          _buildBtnSignIn,
          const SizedBox(height: 8),
          _buildCreateAccount,
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
        validator: (value) => validateEmail(value),
        decoration: InputDecoration(
          prefixIcon: Icon(CupertinoIcons.mail),
          labelText: 'E-Posta',
        ),
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
        validator: (value) => validateDefault(value),
      ),
    );
  }

  Widget get _buildForgotPw {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onClickForgotPw,
        child: Text(
          'Parolamı Unuttum',
        ),
      ),
    );
  }

  void onClickForgotPw() {
    Get.defaultDialog(
      title: 'Parolamı Unuttum',
      content: TextField(
        onChanged: (value) => controller.forgotMail = value,
      ),
      cancel: TextButton(onPressed: () => Get.back(), child: Text('Vazgeç')),
      confirm: TextButton(onPressed: () async {
        await controller.submitForgotPw();
        Get.back();
      }, child: Text('Gönder'))
    );
  }

  Widget get _buildFormMessage {
    return Obx(() => Text(
          controller.formMessage.value,
          style: Get.textTheme.bodyText2!
              .copyWith(color: Get.theme.colorScheme.error),
        ));
  }

  Widget get _buildBtnSignIn {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: () => controller.login(),
        child: Text('GİRİŞ YAP'),
      ),
    );
  }

  Widget get _buildCreateAccount {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Bir hesabın yok mu?'),
        const SizedBox(width: 4),
        TextButton(
          onPressed: () => Get.offNamed(AppRoutes.SIGN_UP),
          child: Text(
            'Kayıt Ol',
            style: Get.textTheme.bodyText2!
                .copyWith(color: Get.theme.colorScheme.primary),
          ),
        )
      ],
    );
  }
}
