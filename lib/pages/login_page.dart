// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_application_one/utils/routes.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool changeBtn = false;

  final _formKey = GlobalKey<FormState>();
  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeBtn = true;
      });

      await Future.delayed(Duration(seconds: 1));
      //await Navigator.pushNamed(context, MyRoutes.homeRoute);
      await context.vxNav.push(Uri.parse(MyRoutes.homeRoute));
      setState(() {
        changeBtn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      //want to show app bar then use scaffolf in place of appbar
      color: context.canvasColor,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30.0),
                  child: Image.asset(
                    "assets/images/login_image.png",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Login $name",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
                ),
                //Padding(padding: padding)
                Padding(
                  //padding: const EdgeInsets.all(16.0), //or
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),

                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: "Enter username", labelText: "Username"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "username cannot be empty";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          //same as on text change listener
                          name = value;
                          setState(() {});
                        },
                      ),
                      TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "Enter password",
                              labelText: "Password"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "password cannot be empty";
                            } else if (value.length < 6) {
                              return "password length must be greater than 6";
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 40.0,
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(changeBtn ? 50 : 8),
                        color: context.theme.buttonColor,
                        child: InkWell(
                          //using inkwell for click and animation on container
                          onTap: () => moveToHome(context),
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            width: changeBtn ? 50 : 150,
                            height: 50,
                            alignment: Alignment.center,
                            child: changeBtn
                                ? Icon(
                                    Icons.done,
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text(
                          'Register', //title
                          textAlign: TextAlign.center, //aligment
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
