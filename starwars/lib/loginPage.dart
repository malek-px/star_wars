import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:starwars/registerPage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'characterList.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

TextEditingController username = TextEditingController();
TextEditingController password = TextEditingController();
bool checkValue = false;

late SharedPreferences sharedPreferences;

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 53, 53, 53),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 50, top: 80, right: 50),
              child: Image.asset(
                'assets/images/star_wars_logo.png',
                width: 500.0,
                height: 200.0,
                //fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: username,
              validator: (value) {
                if (value!.isEmpty || value.length < 8) {
                  return 'User name must not be empty';
                }
                return null;
              },
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(18))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(18))),
                //hoverColor: Colors.white,
                fillColor: Colors.transparent,
                filled: true,
                hintText: 'User Name',
                hintStyle: TextStyle(fontSize: 18.0, color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: password,
              validator: (value) {
                if (value!.isEmpty || value.length < 8) {
                  return 'Password must be longer than 8';
                }
                return null;
              },
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
              obscureText: true,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(18))),
                fillColor: Colors.transparent,
                filled: true,
                hintText: 'Password',
                hintStyle: const TextStyle(fontSize: 18.0, color: Colors.grey),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0)),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            // AnimatedButton(
            //   animatedOn: AnimatedOn.onTap,
            //   animationDuration: const Duration(milliseconds:500),
            //   height: 55,
            //   width: 360,
            //   text: 'Login',
            //   textStyle: const TextStyle(
            //       color: Color.fromARGB(255, 110, 110, 110), fontSize: 20),
            //   isReverse: true,
            //   selectedTextColor: const Color.fromARGB(255, 110, 110, 110),
            //   transitionType: TransitionType.LEFT_TO_RIGHT,
            //   backgroundColor: const Color.fromARGB(255, 36, 36, 36),
            //   //borderColor: Colors.white,
            //   borderRadius: 18,
            //   borderWidth: 2,
            //   onPress: _onChanged;
            // ),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 36, 36, 36),
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(18.0)),
              child: ListTile(
                title: const Text(
                  "Login",
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                onTap: _navigator,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AnimatedButton(
              height: 55,
              width: 360,
              text: 'Inscription',
              textStyle: const TextStyle(
                  color: Color.fromARGB(255, 110, 110, 110), fontSize: 20),
              isReverse: true,
              selectedTextColor: const Color.fromARGB(255, 110, 110, 110),
              transitionType: TransitionType.LEFT_TO_RIGHT,
              backgroundColor: const Color.fromARGB(255, 70, 70, 70),
              //borderColor: Colors.white,
              borderRadius: 18,
              borderWidth: 2,
              onPress: () {
                Navigator.push(
                  context,
                  PageTransition(
                    curve: Curves.linear,
                    type: PageTransitionType.bottomToTop,
                    duration: const Duration(milliseconds: 400),
                    child: const Register(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _onChanged(bool value) async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = value;
      sharedPreferences.setBool("check", checkValue);
      sharedPreferences.setString("username", username.text);
      sharedPreferences.setString("password", password.text);
      sharedPreferences.commit();
      getCredential();
    });
  }

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      checkValue = sharedPreferences.getBool("check")!;
      if (checkValue != null) {
        if (checkValue) {
          username.text = sharedPreferences.getString("username")!;
          password.text = sharedPreferences.getString("password")!;
        } else {
          username.clear();
          password.clear();
          sharedPreferences.clear();
        }
      } else {
        checkValue = false;
      }
    });
  }

  _navigator() {
    if (username.text.length != 0 || password.text.length != 0) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => const CharacterList()),
          (Route<dynamic> route) => false);
    } else {
      const CircularProgressIndicator();
    }
  }
}
