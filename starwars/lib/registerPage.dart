import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:page_transition/page_transition.dart';

import 'loginPage.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //var
  final _controller = TextEditingController();
//key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 53, 53, 53),
          actions: [
            IconButton(
                onPressed: () {
                  //cancel
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.grey,
                ))
          ]),
      backgroundColor: const Color.fromARGB(255, 53, 53, 53),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 50, top: 10, right: 50),
              child: Image.asset(
                'assets/images/star_wars_logo.png',
                width: 500.0,
                height: 200.0,
                //fit: BoxFit.cover,
              ),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || value.length < 8) {
                          return 'username should be longer than 8';
                        }
                        return null;
                      },
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(18))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(18))),
                        //hoverColor: Colors.white,
                        fillColor: Colors.transparent,
                        filled: true,
                        hintText: 'User Name',
                        hintStyle:
                            TextStyle(fontSize: 18.0, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || value.length < 8) {
                          return 'Password must be longer than 8';
                        }
                        return null;
                      },
                      textAlign: TextAlign.center,
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(18))),
                        fillColor: Colors.transparent,
                        filled: true,
                        hintText: 'Password',
                        hintStyle:
                            const TextStyle(fontSize: 18.0, color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2.0)),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      textAlign: TextAlign.center,
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(18))),
                        fillColor: Colors.transparent,
                        filled: true,
                        hintText: 'Repeat Password',
                        hintStyle:
                            const TextStyle(fontSize: 18.0, color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2.0)),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    AnimatedButton(
                        animatedOn: AnimatedOn.onTap,
                        animationDuration: const Duration(milliseconds: 700),
                        height: 55,
                        width: 360,
                        text: 'Register',
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 110, 110, 110),
                            fontSize: 20),
                        isReverse: true,
                        selectedTextColor:
                            const Color.fromARGB(255, 110, 110, 110),
                        transitionType: TransitionType.LEFT_TO_RIGHT,
                        backgroundColor: const Color.fromARGB(255, 36, 36, 36),
                        //borderColor: Colors.white,
                        borderRadius: 18,
                        borderWidth: 2,
                        onPress: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              curve: Curves.linear,
                              type: PageTransitionType.bottomToTop,
                              duration: const Duration(milliseconds: 900),
                              child: const Login(),
                            ),
                          );
                        }),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
