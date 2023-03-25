import 'package:bisan_systems_erp/services/api.dart';
import 'package:bisan_systems_erp/themes/bsn_theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final accountController = TextEditingController(text: "demopos4");
  final userController = TextEditingController(text: "alaa2");
  final passwordController = TextEditingController(text: "a12345");
  double elementRation = 0.50;

  @override
  Widget build(BuildContext context) {
    elementRation = MediaQuery.of(context).size.width < 600 ? 0.75 : 0.50;
    return Scaffold(
      backgroundColor: BsnTheme.secondaryColor,
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                      child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Image.asset(
                            'assets/images/big_logo.png',
                            height: 150,
                          ))),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * elementRation,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextField(
                              controller: accountController,
                              decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                  labelText: 'Account Code',
                                  hintText: 'Bisan'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 15, bottom: 0),
                            //padding: EdgeInsets.symmetric(horizontal: 15),
                            child: TextField(
                              controller: userController,
                              decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                  labelText: 'Password',
                                  hintText: 'Enter secure password'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 15, bottom: 0),
                            //padding: EdgeInsets.symmetric(horizontal: 15),
                            child: TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                  labelText: 'Password',
                                  hintText: 'Enter secure password'),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(10),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            BsnTheme.getColor)),
                                onPressed: () {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  _login(context);
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Login',
                                      style: TextStyle(
                                          color: BsnTheme.primaryColor),
                                    ), // <-- Text
                                    const SizedBox(width: 5, height: 35),
                                    _isLoading
                                        ? SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              color: BsnTheme.primaryColor,
                                              strokeWidth: 3,
                                            ))
                                        : Icon(
                                            // <-- Icon
                                            Icons.send,
                                            size: 24.0,
                                            color: BsnTheme.primaryColor,
                                          ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ])),
    );
  }

  _login(context) async {
    _isLoading = true;
    Api.accountCode = accountController.text;
    String username = userController.text;
    String password = passwordController.text;
    Response<dynamic> response = await Api.login(username, password);
    print(response.data['token']);
    Api.token = response.data['token'];
    // we need to navigate to the home page || the dashboard.
    Navigator.of(context).pushReplacementNamed('home');
  }
}
