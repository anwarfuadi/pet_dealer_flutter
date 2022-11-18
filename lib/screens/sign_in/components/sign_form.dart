import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/form_error.dart';
import 'package:shop_app/helper/keyboard.dart';
import 'package:shop_app/models/Customer.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:http/http.dart' as http;

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  Customer? customer;

  bool? remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          // Row(
          //   children: [
          //     Checkbox(
          //       value: remember,
          //       activeColor: kPrimaryColor,
          //       onChanged: (value) {
          //         setState(() {
          //           remember = value;
          //         });
          //       },
          //     ),
          //     Text("Remember me"),
          //     Spacer(),
          //     GestureDetector(
          //       onTap: () => Navigator.pushNamed(
          //           context, ForgotPasswordScreen.routeName),
          //       child: Text(
          //         "Forgot Password",
          //         style: TextStyle(decoration: TextDecoration.underline),
          //       ),
          //     )
          //   ],
          // ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Masuk",
            press: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                KeyboardUtil.hideKeyboard(context);
                customer = await _findCustomer(email, password);
                if(customer != null){
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString("email", customer!.email);
                  prefs.setString("name", customer!.name);
                  Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, ModalRoute.withName(HomeScreen.routeName));
                }else{
                  addError(error: credentialError);
                }
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 4) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Password",
        hintText: "Masukkan password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Masukkan alamat email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
  
  Future<Customer?> _findCustomer(String? email, String? password) async {
    final response = await http.get(Uri.parse('${ENDPOINTAPI}/api/customer/${email}/${password}'));
    final jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    if(jsonResponse["data"] != null){
      final cust = Customer.fromJson(jsonResponse["data"]);
      return cust;
    }
    return null;
  }
}
