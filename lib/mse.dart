import 'package:flower_delivery_app/appStyle/app_colors.dart';
import 'package:flutter/material.dart';

class Mse extends StatefulWidget {
  const Mse({super.key});

  @override
  State<Mse> createState() => _MseState();
}

class _MseState extends State<Mse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text('Login Page'),
        centerTitle: true,
        leading: Container(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Email',
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * 0.024),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * 0.024),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * 0.024),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * 0.024),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * 0.024),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * 0.024),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * 0.024),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * 0.024),
                ),
              ),
            ),
            TextButton(
              onPressed: null,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.darkGreyColor,
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * 0.024),
                ),
                child: Center(
                  child: Text(
                    'Log In',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.height * 0.02),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
