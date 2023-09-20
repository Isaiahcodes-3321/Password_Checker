import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class Inputs extends StatefulWidget {
  const Inputs({Key? key});

  @override
  State<Inputs> createState() => _InputsState();
}

class _InputsState extends State<Inputs> {
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isPasswordVisiblecheck = false;

  final StreamController<bool> _passwordMatchStreamController =
      StreamController<bool>();

  @override
  void initState() {
    super.initState();

    // This timer will check all textfield every seconds if there is a text in it.
    Timer.periodic(Duration(seconds: 0), (timer) {
      // Check if the passwords match and add the result to the stream.

      final passwordsMatch =
          passwordController.text == confirmPasswordController.text;
      _passwordMatchStreamController.add(passwordsMatch);
    });
  }

  @override
  Widget build(BuildContext context) {
    var inputDecoration = UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Color.fromRGBO(112, 111, 111, 1),
        width: 10,
      ),
    );

    // Text styling
    var textStyle = TextStyle(fontSize: 17, color: Colors.black);
    var textGreen = TextStyle(color: Colors.green, fontWeight: FontWeight.w500);
    var textred = TextStyle(color: Colors.red, fontWeight: FontWeight.w500);
    var paddingg = EdgeInsets.only(top: 4, right: 2);

    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 208, 207, 207),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        height: 350,
        width: 300,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: !isPasswordVisible,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: textStyle,
                  hintText: "Password",
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(255, 104, 104, 104),
                  ),
                  focusedBorder: inputDecoration,
                  enabledBorder: inputDecoration,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    child: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: const Color.fromARGB(255, 88, 88, 88),
                    ),
                  ),
                ),
                onChanged: (value) {
                  Provider.of<Check_password>(context, listen: false)
                      .check(passwordController.text);
                },
              ),
              StreamBuilder<bool>(
                stream: Stream.periodic(Duration(seconds: 0)).map((_) =>
                    passwordController.text != null &&
                    passwordController.text.isNotEmpty),
                initialData: false,
                builder: (context, snapshot) => snapshot.data == true
                    ? Consumer<Check_password>(
                        builder: (context, model, child) {
                          return Wrap(
                            children: [
                              (passwordController.text
                                      .contains(RegExp(r'[a-z]')))
                                  ? Padding(
                                      padding: paddingg,
                                      child: Text(
                                        '✔️ Lowercase',
                                        style: textGreen,
                                      ),
                                    )
                                  : Padding(
                                      padding: paddingg,
                                      child: Text(
                                        "⚠️ Lowercase",
                                        style: textred,
                                      ),
                                    ),
                              (passwordController.text
                                      .contains(RegExp(r'[A-Z]')))
                                  ? Padding(
                                      padding: paddingg,
                                      child: Text(
                                        '✔️ Uppercase',
                                        style: textGreen,
                                      ),
                                    )
                                  : Padding(
                                      padding: paddingg,
                                      child: Text(
                                        "⚠️ Uppercase",
                                        style: textred,
                                      ),
                                    ),
                              (passwordController.text
                                      .contains(RegExp(r'[0-9]')))
                                  ? Padding(
                                      padding: paddingg,
                                      child: Text(
                                        '✔️ Numbers',
                                        style: textGreen,
                                      ),
                                    )
                                  : Padding(
                                      padding: paddingg,
                                      child: Text(
                                        "⚠️ Numbers",
                                        style: textred,
                                      ),
                                    ),
                              (passwordController.text.length > 7)
                                  ? Padding(
                                      padding: paddingg,
                                      child: Text(
                                        '✔️ 8 or more',
                                        style: textGreen,
                                      ),
                                    )
                                  : Padding(
                                      padding: paddingg,
                                      child: Text(
                                        "⚠️ 8 or more",
                                        style: textred,
                                      ),
                                    ),
                              (passwordController.text.contains(RegExp(
                                      r'[!@#$¥%^&*()¢_+{}\[\]:;<>,$€.?~\£\-← ↑ → ↓ ↔ ↕ ↖ ↗ ↘ ↙× ÷ = < > ≤ ≥ ≠ ≈ ± √ ∑ ∫ ∆ π ≡ ∞ ∠]')))
                                  ? Padding(
                                      padding: paddingg,
                                      child: Text(
                                        '✔️ Symbols',
                                        style: textGreen,
                                      ),
                                    )
                                  : Padding(
                                      padding: paddingg,
                                      child: Text(
                                        "⚠️ Symbols",
                                        style: textred,
                                      ),
                                    ),
                            ],
                          );
                        },
                      )
                    : Text(""),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: !isPasswordVisiblecheck,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  // helperText: 'Confirm Password',
                  labelStyle: textStyle,
                  focusedBorder: inputDecoration,
                  enabledBorder: inputDecoration,

                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isPasswordVisiblecheck = !isPasswordVisiblecheck;
                      });
                    },
                    child: Icon(
                      isPasswordVisiblecheck
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: const Color.fromARGB(255, 88, 88, 88),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              StreamBuilder<bool>(
                stream: _passwordMatchStreamController.stream,
                initialData: false,
                builder: (context, snapshot) => snapshot.data == true
                    ? (passwordController.text.isEmpty)
                        ? Text('')
                        : Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Password Confirmed',
                              style: textGreen.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                    : Text(''),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
