// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:math';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginPage());
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _emailLoginFocus = FocusNode();
  final FocusNode _mobileLoginFocus = FocusNode();

  late final Constant lc = Get.put(Constant());
  bool emailEnable = true;
  bool passwordEnable = true;
  bool mobileTextDisable = true;
  String labelResendOtp = 'Resend_OTP';
  bool enabled = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
              color: Colors.blueGrey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => Expanded(
                        child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(children: [
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(left: 15, right: 15, top: 15),
                          margin: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.teal),
                          child: Column(
                            children: [
                              SizedBox(height: 40),
                              Text("Login Screen",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 10,
                              ),
                              DefaultTabController(
                                  length: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      TabBar(
                                          indicatorColor: Colors.yellow,
                                          labelColor: Colors.black,
                                          unselectedLabelColor: Colors.black,
                                          // ignore: prefer_const_literals_to_create_immutables
                                          tabs: [
                                            Tab(text: 'Email'),
                                            Tab(
                                              text: 'Mobile Number',
                                            ),
                                          ]),
                                      SizedBox(
                                          height: 420,
                                          child: TabBarView(children: [
                                            //Email
                                            Container(
                                              margin: EdgeInsets.all(10),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        'Email',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  TextFormField(
                                                    //  obscureText: true,
                                                    enabled: emailEnable,
                                                    onChanged: (value) {
                                                      bool emailValid =
                                                          EmailValidator.validate(lc
                                                              .emailNameController!
                                                              .value
                                                              .text
                                                              .toString()
                                                              .trim());
                                                      lc.emailNameController!
                                                                  .value.text
                                                                  .toString()
                                                                  .trim() ==
                                                              ''
                                                          ? lc.validationEmailLogin
                                                              .value = true
                                                          : lc.validationEmailLogin
                                                              .value = false;
                                                      emailValid == true
                                                          ? lc.validationEmailCheck
                                                              .value = true
                                                          : lc.validationEmailCheck
                                                              .value = false;

                                                      if (emailValid) {
                                                        lc.validationEmail
                                                            .value = '';
                                                      } else {
                                                        lc.validationEmail
                                                                .value =
                                                            "Please enter valid email";
                                                      }
                                                    },

                                                    controller: lc
                                                        .emailNameController!
                                                        .value,
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.purple),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      errorText: lc
                                                              .validationEmailLogin
                                                              .value
                                                          ? lc.validationEmailCheck
                                                                  .value
                                                              ? null
                                                              : "Please enter email address"
                                                          : (lc.validationEmail
                                                                      .value ==
                                                                  '')
                                                              ? null
                                                              : lc.validationEmail
                                                                  .value,
                                                      hintText: 'Enter Email',
                                                    ),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    onEditingComplete: () =>
                                                        FocusScope.of(context)
                                                            .nextFocus(),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text('Password',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  TextFormField(
                                                    enabled: passwordEnable,
                                                    onChanged: (text) {
                                                      lc.passwordController!
                                                                  .value.text
                                                                  .toString()
                                                                  .trim() ==
                                                              ''
                                                          ? lc.validateLoginPass
                                                              .value = true
                                                          : lc.validateLoginPass
                                                              .value = false;
                                                      lc.passwordController!
                                                                  .value.text
                                                                  .toString()
                                                                  .trim()
                                                                  .length <
                                                              6
                                                          ? lc.validateLoginPassCheck
                                                              .value = false
                                                          : lc.validateLoginPassCheck
                                                              .value = true;

                                                      if (lc
                                                          .validateLoginPassCheck
                                                          .value) {
                                                        lc.validationPassword
                                                            .value = '';
                                                      } else {
                                                        lc.validationPassword
                                                                .value =
                                                            'Please enter minimum 6 alphanumeric letters';
                                                      }
                                                    },
                                                    controller: lc
                                                        .passwordController!
                                                        .value,
                                                    obscureText: true,
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.blue),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      errorText: lc
                                                              .validateLoginPass
                                                              .value
                                                          ? lc.validateLoginPassCheck
                                                                  .value
                                                              ? null
                                                              : "Please enter password"
                                                          : (lc.validationPassword
                                                                      .value ==
                                                                  '')
                                                              ? null
                                                              : lc.validationPassword
                                                                  .value,
                                                      hintText:
                                                          'Enter password',
                                                    ),
                                                    focusNode: _emailLoginFocus,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    onFieldSubmitted: (value) {
                                                      _emailLoginFocus
                                                          .unfocus();
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                      _checkEmailValidation();
                                                    },
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: TextButton(
                                                        onPressed: () {
                                                          lc.emailNameController!
                                                              .value
                                                              .clear();
                                                          lc.passwordController!
                                                              .value
                                                              .clear();
                                                          lc.phoneNumberController!
                                                              .value
                                                              .clear();
                                                          // ignore: avoid_single_cascade_in_expression_statements
                                                          lc
                                                            ..otpController!
                                                                .value
                                                                .clear();
                                                          lc.validationEmailLogin
                                                              .value = false;
                                                          lc.validateLoginPass
                                                              .value = false;
                                                          lc.validationOtpCheck
                                                              .value = false;
                                                          lc.validationPhoneCheck
                                                              .value = false;
                                                          lc.validationEmail
                                                              .value = '';
                                                          lc.validationPassword
                                                              .value = '';
                                                          lc.validationEnterOtp
                                                              .value = '';
                                                          lc.validationPhoneNumber
                                                              .value = '';
                                                          lc.visibleReq.value =
                                                              0;
                                                        },
                                                        child: Text(
                                                          'Forgot password?',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  ElevatedButton(
                                                    child: Text('Login'),
                                                    onPressed: () {
                                                      // Navigator.pushNamed(
                                                      //     context,
                                                      //     '/HomeScreen');
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();

                                                      _checkEmailValidation();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Mobile
                                            Container(
                                              margin: EdgeInsets.all(9),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text('Mobile Number',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  TextFormField(
                                                    enabled: mobileTextDisable,
                                                    onChanged: (value) {
                                                      String regexPattern =
                                                          r'^(?:[+0][1-9])?[0-9]{10,12}$';
                                                      // ignore: unnecessary_new
                                                      var regExp = new RegExp(
                                                          regexPattern);
                                                      lc.phoneNumberController!
                                                                  .value.text
                                                                  .toString()
                                                                  .trim() ==
                                                              ''
                                                          ? lc.validationPhoneLogin
                                                              .value = true
                                                          : lc.validationPhoneLogin
                                                              .value = false;
                                                      if (lc
                                                              .phoneNumberController!
                                                              .value
                                                              .text
                                                              .length !=
                                                          10) {
                                                        lc.validationPhoneCheck
                                                            .value = false;
                                                      } else {
                                                        lc.validationPhoneCheck
                                                            .value = true;
                                                      }
                                                      if (lc
                                                          .validationPhoneCheck
                                                          .value) {
                                                        lc.validationPhoneNumber
                                                            .value = '';
                                                      } else if (lc
                                                          .phoneNumberController!
                                                          .value
                                                          .text
                                                          .isEmpty) {
                                                        lc.validationPhoneNumber
                                                                .value =
                                                            'Please enter mobile number';
                                                      } else {
                                                        lc.validationPhoneNumber
                                                                .value =
                                                            'Please Enter 10 Digit Number';
                                                      }
                                                      lc.otpController!.value
                                                                  .text
                                                                  .toString()
                                                                  .trim()
                                                                  .length <
                                                              6
                                                          ? lc.validationPhoneLogin
                                                              .value = false
                                                          : lc.validationPhoneLogin
                                                              .value = true;
                                                    },
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    maxLength: 10,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    controller: lc
                                                        .phoneNumberController!
                                                        .value,
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.blue),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      hintText:
                                                          'Enter mobile number',
                                                      errorText: lc
                                                              .validationPhoneLogin
                                                              .value
                                                          ? lc.validationPhoneCheck
                                                                  .value
                                                              ? null
                                                              : 'Enter mobile number'
                                                          : (lc.validationPhoneNumber
                                                                      .value ==
                                                                  '')
                                                              ? null
                                                              : lc.validationPhoneNumber
                                                                  .value,
                                                    ),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    onEditingComplete: () =>
                                                        FocusScope.of(context)
                                                            .nextFocus(),
                                                    focusNode:
                                                        _mobileLoginFocus,
                                                    onFieldSubmitted: (_) {
                                                      _mobileLoginFocus
                                                          .unfocus();
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                      _checkOtpMobileValidation();
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Visibility(
                                                      visible: (lc.visibleReq
                                                                  .value ==
                                                              1)
                                                          ? true
                                                          : false,
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            InkWell(
                                                                onTap: () {
                                                                  lc.phoneNumberController!
                                                                      .value
                                                                      .clear();
                                                                  lc.otpController!
                                                                      .value
                                                                      .clear();
                                                                  mobileTextDisable =
                                                                      true;
                                                                  emailEnable =
                                                                      true;
                                                                  passwordEnable =
                                                                      true;

                                                                  lc.visibleReq
                                                                      .value = 0;
                                                                },
                                                                child: Text(
                                                                    'Change Number',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .yellow,
                                                                        fontWeight:
                                                                            FontWeight.bold)))
                                                          ])),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Visibility(
                                                    visible:
                                                        (lc.visibleReq.value ==
                                                                1)
                                                            ? true
                                                            : false,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      // ignore: prefer_const_literals_to_create_immutables
                                                      children: [
                                                        Text('OTP',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),

                                                  //OTP

                                                  Visibility(
                                                    visible:
                                                        (lc.visibleReq.value ==
                                                                1)
                                                            ? true
                                                            : false,
                                                    child: TextFormField(
                                                      maxLength: 6,
                                                      onChanged: (value) {
                                                        lc.otpController!.value
                                                                .text.isEmpty
                                                            ? lc.validPhoneOtp
                                                                .value = true
                                                            : lc.validPhoneOtp
                                                                .value = false;
                                                        lc.otpController!.value
                                                                    .text
                                                                    .toString()
                                                                    .trim()
                                                                    .length !=
                                                                6
                                                            ? lc.validationOtpCheck
                                                                .value = false
                                                            : lc.validationOtpCheck
                                                                .value = true;
                                                        if (lc
                                                            .validationOtpCheck
                                                            .value) {
                                                          lc.validationEnterOtp
                                                              .value = '';
                                                        } else {
                                                          lc.validationEnterOtp
                                                                  .value =
                                                              'Please enter minimum 6 letters';
                                                        }
                                                      },
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly
                                                      ],
                                                      obscureText: true,
                                                      //    maxLength: 6,
                                                      controller: lc
                                                          .otpController!.value,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .blue),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              hintText:
                                                                  'Enter otp',
                                                              errorText: lc
                                                                      .validPhoneOtp
                                                                      .value
                                                                  ? lc.validationOtpCheck
                                                                          .value
                                                                      ? null
                                                                      : "Please Enter OTP"
                                                                  : (lc.validationEnterOtp
                                                                              .value ==
                                                                          '')
                                                                      ? null
                                                                      : lc.validationEnterOtp
                                                                          .value),
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      focusNode:
                                                          _emailLoginFocus,
                                                      onFieldSubmitted:
                                                          (value) {
                                                        _emailLoginFocus
                                                            .unfocus();
                                                        FocusManager.instance
                                                            .primaryFocus
                                                            ?.unfocus();
                                                        _checkMobileValidation();
                                                      },
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Visibility(
                                                          visible: (lc.visibleReq
                                                                      .value ==
                                                                  0)
                                                              ? true
                                                              : false,
                                                          child: ElevatedButton(
                                                              child: Text(
                                                                  'Request OTP'),
                                                              onPressed: () {
                                                                if (lc.phoneNumberController!.value
                                                                            .text !=
                                                                        "" ||
                                                                    lc
                                                                            .phoneNumberController!
                                                                            .value
                                                                            .text
                                                                            .length ==
                                                                        10) {
                                                                  lc.visibleReq
                                                                      .value = 1;

                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      ?.unfocus();
                                                                  _checkOtpMobileValidation();
                                                                }
                                                              })),
                                                      Visibility(
                                                        visible: (lc.visibleReq
                                                                    .value ==
                                                                1)
                                                            ? true
                                                            : false,
                                                        child: ElevatedButton(
                                                          child: Text(
                                                              'Verify OTP'),
                                                          onPressed: () {
                                                            FocusManager
                                                                .instance
                                                                .primaryFocus
                                                                ?.unfocus();
                                                            _checkMobileValidation();
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ])),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ]),
                    )),
                  ),
                ],
              ))),
    );
  }

  void _checkEmailValidation() {
    bool emailValid = EmailValidator.validate(
        lc.emailNameController!.value.text.toString().trim());
    lc.emailNameController!.value.text.toString().trim() == ''
        ? lc.validationEmailLogin.value = true
        : lc.validationEmailLogin.value = false;
    emailValid == true
        ? lc.validationEmailCheck.value = true
        : lc.validationEmailCheck.value = false;

    lc.passwordController!.value.text.toString().trim() == ''
        ? lc.validateLoginPass.value = true
        : lc.validateLoginPass.value = false;
    lc.passwordController!.value.text.toString().trim().length < 6
        ? lc.validateLoginPassCheck.value = false
        : lc.validateLoginPassCheck.value = true;
    if (emailValid) {
      lc.validationEmail.value = '';
    } else {
      lc.validationEmail.value = "Please enter valid email";
    }
    if (lc.validateLoginPassCheck.value) {
      lc.validationPassword.value = '';
    } else {
      lc.validationPassword.value =
          'Please enter minimum 6 alphanumeric letters';
    }
    if (lc.validateLoginPass.value ||
        lc.validationEmailLogin.value ||
        lc.validateLoginPassCheck.value == false ||
        lc.validationEmailCheck.value == false) {
    } else {
      //Navigator.popAndPushNamed(context, '/HomeScreen');
      //     onLogin(context);
    }
  }

  void _checkMobileValidation() {
    lc.otpController!.value.text.isEmpty
        ? lc.validPhoneOtp.value = true
        : lc.validPhoneOtp.value = false;
    lc.otpController!.value.text.toString().trim().length != 6
        ? lc.validationOtpCheck.value = false
        : lc.validationOtpCheck.value = true;
    if (lc.validationOtpCheck.value) {
      lc.validationEnterOtp.value = '';
    } else {
      lc.validationEnterOtp.value = 'Please enter minimum 6 letters';
    }

    if (lc.otpController!.value.text.isEmpty ||
        lc.otpController!.value.text.toString().trim().length != 6) {
    } else {
      //  onVerifyOTP(context);
    }
  }

  void _checkOtpMobileValidation() {
    if (lc.phoneNumberController!.value.text == "") {
      lc.validationPhoneNumber.value = 'Please enter mobile number';
    } else if (lc.phoneNumberController!.value.text.length != 10) {
      lc.validationPhoneNumber.value = 'Please Enter 10 Digit Number';
    } else {
      String regexPattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
      var regExp = RegExp(regexPattern);
      lc.phoneNumberController!.value.text.toString().trim() == ''
          ? lc.validationPhoneLogin.value = true
          : lc.validationPhoneLogin.value = false;

      if (lc.phoneNumberController!.value.text.length != 10) {
        lc.validationPhoneCheck.value = false;
      } else {
        lc.validationPhoneCheck.value = true;
      }
      if (lc.validationPhoneCheck.value) {
        lc.validationPhoneNumber.value = '';
      } else {
        lc.validationPhoneNumber.value = 'Please Enter 10 Digit Number';
      }
      lc.otpController!.value.text.toString().trim().length < 6
          ? lc.validationPhoneLogin.value = false
          : lc.validationPhoneLogin.value = true;

      if (lc.phoneNumberController!.value.text == "" ||
          lc.phoneNumberController!.value.text.length != 10) {
      } else {
        //   onOTPrequest(context);
      }
    }
  }
}

class Constant extends GetxController {
  Rx<TextEditingController>? emailNameController;
  Rx<TextEditingController>? passwordController;
  Rx<TextEditingController>? phoneNumberController;
  Rx<TextEditingController>? otpController;
  Rx<TextEditingController>? forgotControllerMobile;

  Rx<TextEditingController>? forgotEmailController;

  Rx<TextEditingController>? verifyController;
  Rx<TextEditingController>? newPassResetController;
  Rx<TextEditingController>? renewPassResetController;
  SharedPreferences? preference;

  RxBool validationTitle = false.obs;
  RxBool validationEmailLogin = false.obs;
  RxBool validationEmailCheck = false.obs;
  RxBool validateLoginPass = false.obs;
  RxBool validationForgotMobile = false.obs;
  RxBool validationForgotEmail = false.obs;

  RxBool validForgotMobileCheck = false.obs;
  RxBool validForgotEmailCheck = false.obs;

  RxBool validationVerify = false.obs;
  RxBool validateLoginPassCheck = false.obs;
  RxBool validationVerifyCheck = false.obs;

  RxBool validationOtpCheck = false.obs;

  RxBool validationPhoneLogin = false.obs;
  RxBool validationPhoneCheck = false.obs;
  RxBool validationPhoneCheckEmpty = false.obs;
  RxBool validPhoneOtp = false.obs;
  Rx<int> visibleReq = 0.obs;

  //
  RxBool validRequest = false.obs;

  //
  RxBool status = true.obs;
  RxBool validationNewPass = false.obs;
  RxBool validationRenewPass = false.obs;
  RxBool validationNewPassCheck = false.obs;
  RxBool validationConPass = false.obs;
  RxBool validationConPassCheck = false.obs;
  RxString validationEmail = ''.obs;
  RxString validationPhoneNumber = ''.obs;
  RxString validNewPass = ''.obs;
  RxString validReNewPassword = ''.obs;
  RxString validationPassword = ''.obs;
  RxString validationEnterOtp = ''.obs;
  RxString validationForgotEnterMobile = ''.obs;
  RxString validationEnterMobile = ''.obs;

  RxString validationForgotEnterEmail = ''.obs;

  RxString validationVerifyPassword = ''.obs;

  RxInt visibleChange = 0.obs;

  RxInt start = 30.obs;
  RxString resendOtp = "Resend OTP".obs;

  RxInt time = 30.obs;
  RxInt random(min, max) {
    return min + Random().nextInt(max - min);
  }

  @override
  void onInit() {
    super.onInit();
    emailNameController = TextEditingController().obs;
    passwordController = TextEditingController().obs;
    phoneNumberController = TextEditingController().obs;
    otpController = TextEditingController().obs;
    forgotControllerMobile = TextEditingController().obs;
    forgotEmailController = TextEditingController().obs;
    verifyController = TextEditingController().obs;
    newPassResetController = TextEditingController().obs;
    renewPassResetController = TextEditingController().obs;

    visibleReq.value = 0;
  }
}
