import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tawelti/models/user.dart';
import 'package:tawelti/screens/authentification/SignInPage.dart';
import 'package:http/http.dart'as http;

void main() {

  test('empty email returns error string', () {

    final result = EmailFieldValidator.validate('');
    expect(result, 'Email can\'t be empty');
  });

  test('non-empty email returns null', () {

    final result = EmailFieldValidator.validate('email');
    expect(result, null);
  });

  test('empty password returns error string', () {

    final result = PasswordFieldValidator.validate('');
    expect(result, 'Password can\'t be empty');
  });

  test('non-empty password returns null', () {

    final result = PasswordFieldValidator.validate('password');
    expect(result, null);
  });
  
}