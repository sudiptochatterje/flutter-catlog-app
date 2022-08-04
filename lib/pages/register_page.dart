// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:velocity_x/velocity_x.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool changeBtn = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.canvasColor,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30.0),
                child: Image.asset(
                  "assets/images/register.png",
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Register",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              //Padding(padding: padding)
              Padding(
                //padding: const EdgeInsets.all(16.0), //or
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: "Enter username", labelText: "Username"),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: "Enter email", labelText: "Email"),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: "Enter password", labelText: "Password"),
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Enter confirm password",
                          labelText: "Confirm Password"),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(changeBtn ? 50 : 8),
                      color: context.theme.buttonColor,
                      child: InkWell(
                        //using inkwell for click and animation on container
                        //onTap: () => moveToHome(context),
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
                                  "Register",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
