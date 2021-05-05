import 'package:get/get.dart';

class Validator {
  String? validateEmail(String? value) {
    if (value?.isEmail ?? false) {
      return null;
    }
    return 'Lütfen geçerli bir e-posta adresi girin';
  }

  String? validateDefault(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Bu alan boş bırakılamaz';
    }
    return null;
  }

  String? validateCompareFields(String? value1, String? value2) {
    if (value1?.isEmpty ?? true) {
      return 'Bu alan boş bırakılamaz';
    }
    if (value1 != value2) {
      return 'Parolalar birbiriyle uyuşmuyor';
    }
    return null;
  }
}