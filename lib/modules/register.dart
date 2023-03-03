import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store_app/layout/home_layout.dart';
import 'package:store_app/modules/home.dart';
import 'package:store_app/modules/login.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 25,
                end: 25,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 42,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 3.5,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'worry less we will make all your data protected and at safe hands',
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsetsDirectional.only(
                        top: 13,
                        bottom: 13,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black87,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            18,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.account_circle,
                            color: Colors.black87,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Continue with chrome',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: Text(
                      'or',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextField(
                    cursorColor: Colors.black87,
                    decoration: InputDecoration(
                      focusColor: Colors.black87,
                      fillColor: Colors.black87,
                      hoverColor: Colors.black87,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black87,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black87,
                        ),
                      ),
                      label: Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: 15,
                        ),
                        child: Text(
                          'Email',
                        ),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Colors.black87,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const TextField(
                    cursorColor: Colors.black87,
                    decoration: InputDecoration(
                      focusColor: Colors.black87,
                      fillColor: Colors.black87,
                      hoverColor: Colors.black87,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black87,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black87,
                        ),
                      ),
                      label: Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: 15,
                        ),
                        child: Text(
                          'Username',
                        ),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Colors.black87,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const TextField(
                    cursorColor: Colors.black87,
                    decoration: InputDecoration(
                      focusColor: Colors.black87,
                      fillColor: Colors.black87,
                      hoverColor: Colors.black87,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black87,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black87,
                        ),
                      ),
                      label: Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: 15,
                        ),
                        child: Text(
                          'Password',
                        ),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Colors.black87,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const TextField(
                    cursorColor: Colors.black87,
                    decoration: InputDecoration(
                      focusColor: Colors.black87,
                      fillColor: Colors.black87,
                      hoverColor: Colors.black87,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black87,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black87,
                        ),
                      ),
                      label: Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: 15,
                        ),
                        child: Text(
                          'Confirm Password',
                        ),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Colors.black87,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => HomeLayout(),
                        ),
                            (route) => false,
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsetsDirectional.only(
                        top: 13,
                        bottom: 13,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            18,
                          ),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already an member',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
