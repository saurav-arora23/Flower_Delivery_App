import 'dart:convert';
import 'package:flower_delivery_app/appStyle/app_colors.dart';
import 'package:flower_delivery_app/appStyle/app_fonts.dart';
import 'package:flower_delivery_app/appStyle/app_images.dart';
import 'package:flower_delivery_app/appStyle/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int quantity = 1;
  int price = 150;
  int totalPrice = 150;

  Future createPaymentIntent(
      {required String currency, required String amount}) async {
    final url = Uri.parse('https://api.stripe.com/v1/payment_intents');
    String secretKey =
        "sk_test_51MPNbICyVVvmIW9sCVFAGftxVD6beuVlER1JSYHfGadl6Hogtm3nBferOBVPN9wZJaDnyAInmmINxPERcuYXfv4j00yP83nXoC";

    final body = {
      'amount': amount,
      'currency': currency.toLowerCase(),
    };

    final response = await http.post(url,
        headers: {
          "Authorization": "Bearer $secretKey",
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body);

    print(body);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(json);
      return json;
    } else {
      print("error in calling payment intent");
    }
  }

  Future<void> initPaymentSheet() async {
    try {
      final data = await createPaymentIntent(
        amount: ((totalPrice * 100).toString()),
        currency: "USD",
      );
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: data['client_secret'],
          merchantDisplayName: 'Flutter Stripe',
          customerId: data['id'],
          customerEphemeralKeySecret: data['ephemeralKey'],
          returnURL: 'flutterstripe://redirect',
          style: ThemeMode.dark,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        surfaceTintColor: AppColors.whiteColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.blackColor,
            size: MediaQuery.of(context).size.height * 0.02,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.058,
          width: MediaQuery.of(context).size.width * double.infinity,
          decoration: BoxDecoration(
            color: AppColors.pinkColor,
            borderRadius: BorderRadius.circular(
              MediaQuery.of(context).size.height * 0.02,
            ),
          ),
          child: TextButton(
            onPressed: () async {
              await initPaymentSheet();
              try {
                await Stripe.instance.presentPaymentSheet();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                    "Payment Done",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.green,
                ));
              } catch (e) {
                print("payment sheet failed");
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                    "Payment Failed",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.redAccent,
                ));
              }
            },
            child: Text(
              AppStrings.checkOut,
              style: TextStyle(
                color: AppColors.whiteColor,
                fontFamily: AppFonts.montserratRegular,
                fontWeight: FontWeight.w600,
                fontSize: MediaQuery.of(context).size.height * 0.018,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              AppImages.rose1,
            ),
            Divider(indent: MediaQuery.of(context).size.width * 0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.13,
                  child: Image.asset(
                    AppImages.rose1,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.13,
                  child: Image.asset(
                    AppImages.rose2,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.13,
                  child: Image.asset(
                    AppImages.rose3,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.28,
                  decoration: BoxDecoration(
                    color: AppColors.pinkColor,
                    borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * 0.005,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (quantity < 2) {
                            quantity = 1;
                          } else {
                            quantity--;
                            totalPrice = quantity * price;
                          }
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.remove_circle,
                          color: AppColors.whiteColor,
                          size: MediaQuery.of(context).size.height * 0.022,
                        ),
                      ),
                      Text(
                        '$quantity',
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontFamily: AppFonts.poppinsBold,
                          fontSize: MediaQuery.of(context).size.height * 0.014,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          quantity++;
                          totalPrice = quantity * price;
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.add_circle,
                          color: AppColors.whiteColor,
                          size: MediaQuery.of(context).size.height * 0.022,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(indent: MediaQuery.of(context).size.width * 0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppStrings.rose,
                  style: TextStyle(
                    fontFamily: AppFonts.montserratBold,
                    color: AppColors.greyColor,
                    fontSize: MediaQuery.of(context).size.height * 0.022,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Rs.',
                        style: TextStyle(
                          fontFamily: AppFonts.montserratBold,
                          color: AppColors.pinkColor,
                          fontSize: MediaQuery.of(context).size.height * 0.022,
                        ),
                      ),
                      TextSpan(
                        text: '$totalPrice',
                        style: TextStyle(
                          fontFamily: AppFonts.montserratBold,
                          color: AppColors.greyColor,
                          fontSize: MediaQuery.of(context).size.height * 0.022,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text(
              AppStrings.description,
              style: TextStyle(
                height: MediaQuery.of(context).size.height * 0.0017,
                color: AppColors.darkGreyColor,
                fontFamily: AppFonts.montserratRegular,
                fontSize: MediaQuery.of(context).size.height * 0.018,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Divider(indent: MediaQuery.of(context).size.width * 0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '4.8 Reviews',
                  style: TextStyle(
                    fontFamily: AppFonts.montserratRegular,
                    color: AppColors.darkGreyColor,
                    fontSize: MediaQuery.of(context).size.height * 0.018,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                  width: MediaQuery.of(context).size.width * 0.27,
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: AppColors.pinkColor,
                        size: MediaQuery.of(context).size.height * 0.024,
                      ),
                      Icon(
                        Icons.star,
                        color: AppColors.pinkColor,
                        size: MediaQuery.of(context).size.height * 0.024,
                      ),
                      Icon(
                        Icons.star,
                        color: AppColors.pinkColor,
                        size: MediaQuery.of(context).size.height * 0.024,
                      ),
                      Icon(
                        Icons.star,
                        color: AppColors.pinkColor,
                        size: MediaQuery.of(context).size.height * 0.024,
                      ),
                      Icon(
                        Icons.star,
                        color: AppColors.lightGreyColor,
                        size: MediaQuery.of(context).size.height * 0.024,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(indent: MediaQuery.of(context).size.width * 0),
          ],
        ),
      ),
    );
  }
}
