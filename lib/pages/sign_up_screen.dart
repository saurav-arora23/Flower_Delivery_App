import 'package:flower_delivery_app/appStyle/app_colors.dart';
import 'package:flower_delivery_app/appStyle/app_fonts.dart';
import 'package:flower_delivery_app/appStyle/app_images.dart';
import 'package:flower_delivery_app/appStyle/app_strings.dart';
import 'package:flower_delivery_app/db_helper.dart';
import 'package:flower_delivery_app/models/data_fields.dart';
import 'package:flower_delivery_app/pages/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sqflite/sqflite.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final DBHelper _dbHelper = DBHelper();
  List<Map<String, dynamic>> _users = [];
  List<String> eA = [];
  bool passwordVisible = false;

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  static Database? _database;

  getDatabase() async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    debugPrint("Database : $_database");
    return _database!;
  }

  initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/userDatabase.db';
    return openDatabase(
      path,
      version: 1,
      onCreate: createDatabase,
    );
  }

  createDatabase(Database db, int version) async {
    return await db.execute(
        'CREATE TABLE ${DataFields.tableName}(${DataFields.id} ${DataFields.idType}, ${DataFields.email} ${DataFields.textType},${DataFields.password} ${DataFields.textType})');
  }

  void _loadItems() async {
    final users = await _dbHelper.getItems();
    setState(() {
      _users = users;
    });
    eA.clear();
    for (int i = 0; i < _users.length; i++) {
      setState(() {
        eA.add(_users[i]['email']);
      });
      debugPrint(
          "Id :- ${_users[i]['id']} ---- Email Address is ${_users[i]['email']} ----- Password is ${_users[i]['password']}");
    }
    debugPrint('Users Database Length is ${_users.length}');
    debugPrint('Users Length is ${eA.length}');
  }

  @override
  void initState() {
    getDatabase();
    _loadItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        surfaceTintColor: AppColors.whiteColor,
        centerTitle: true,
        title: Text(
          AppStrings.signUp,
          style: TextStyle(
            color: AppColors.blackColor,
            fontFamily: AppFonts.montserratRegular,
            fontWeight: FontWeight.w600,
            fontSize: MediaQuery.of(context).size.height * 0.025,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailAddress,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.018,
                  color: AppColors.blackColor,
                  fontFamily: AppFonts.montserratRegular,
                  fontWeight: FontWeight.w500,
                ),
                cursorColor: AppColors.pinkColor,
                decoration: InputDecoration(
                  hintText: AppStrings.email,
                  hintStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.018,
                    color: AppColors.blackColor,
                    fontFamily: AppFonts.montserratRegular,
                    fontWeight: FontWeight.w500,
                  ),
                  filled: true,
                  fillColor: AppColors.lightPinkColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height * 0.008),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height * 0.008),
                    borderSide: BorderSide.none,
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height * 0.008),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height * 0.008),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              TextFormField(
                controller: pass,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.018,
                  color: AppColors.blackColor,
                  fontFamily: AppFonts.montserratRegular,
                  fontWeight: FontWeight.w500,
                ),
                cursorColor: AppColors.pinkColor,
                obscureText: passwordVisible == false ? true : false,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (passwordVisible == false) {
                        passwordVisible = true;
                      } else {
                        passwordVisible = false;
                      }
                      setState(() {});
                    },
                    icon: Icon(
                      passwordVisible == false
                          ? Icons.visibility_off
                          : Icons.visibility,
                      size: MediaQuery.of(context).size.height * 0.036,
                      color: AppColors.blackColor,
                    ),
                  ),
                  hintText: AppStrings.password,
                  hintStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.018,
                    color: AppColors.blackColor,
                    fontFamily: AppFonts.montserratRegular,
                    fontWeight: FontWeight.w500,
                  ),
                  filled: true,
                  fillColor: AppColors.lightPinkColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height * 0.008),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height * 0.008),
                    borderSide: BorderSide.none,
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height * 0.008),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height * 0.008),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              TextFormField(
                controller: confirmPassword,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.018,
                  color: AppColors.blackColor,
                  fontFamily: AppFonts.montserratRegular,
                  fontWeight: FontWeight.w500,
                ),
                cursorColor: AppColors.pinkColor,
                obscureText: passwordVisible == false ? true : false,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (passwordVisible == false) {
                        passwordVisible = true;
                      } else {
                        passwordVisible = false;
                      }
                      setState(() {});
                    },
                    icon: Icon(
                      passwordVisible == false
                          ? Icons.visibility_off
                          : Icons.visibility,
                      size: MediaQuery.of(context).size.height * 0.036,
                      color: AppColors.blackColor,
                    ),
                  ),
                  hintText: AppStrings.confirmPassword,
                  hintStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.018,
                    color: AppColors.blackColor,
                    fontFamily: AppFonts.montserratRegular,
                    fontWeight: FontWeight.w500,
                  ),
                  filled: true,
                  fillColor: AppColors.lightPinkColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height * 0.008),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height * 0.008),
                    borderSide: BorderSide.none,
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height * 0.008),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height * 0.008),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Container(
                height: MediaQuery.of(context).size.height * 0.058,
                width: MediaQuery.of(context).size.width * double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.pinkColor,
                  borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.height * 0.005,
                  ),
                ),
                child: TextButton(
                  onPressed: () async {
                    if (emailAddress.text.isEmpty &&
                        pass.text.isEmpty &&
                        confirmPassword.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fill Required Parameters'),
                        ),
                      );
                      debugPrint("Not Signed Up");
                    } else {
                      if (pass.text == confirmPassword.text) {
                        final email = emailAddress.text;
                        final password = pass.text;
                        if (email.isNotEmpty) {
                          if (eA.contains(email)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Email Already Registered ! Use Another Email'),
                              ),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProductScreen(),
                              ),
                            );
                            debugPrint(
                                "Email Already Registered ! Use Another Email");
                          } else {
                            await _dbHelper.insertItem(email, password);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProductScreen(),
                              ),
                            );
                          }
                          _loadItems();
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Password Not Match'),
                          ),
                        );
                        debugPrint('Password Not Match');
                      }
                    }
                  },
                  child: Text(
                    AppStrings.signUp,
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      endIndent: MediaQuery.of(context).size.width * 0.05,
                      color: AppColors.lightBlackColor,
                    ),
                  ),
                  Text(
                    AppStrings.or,
                    style: TextStyle(
                      color: AppColors.greyColor,
                      fontFamily: AppFonts.montserratRegular,
                      fontWeight: FontWeight.w500,
                      fontSize: MediaQuery.of(context).size.height * 0.018,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: AppColors.lightBlackColor,
                      indent: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              GestureDetector(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.058,
                  width: MediaQuery.of(context).size.width * double.infinity,
                  padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.height * 0.08,
                    left: MediaQuery.of(context).size.height * 0.08,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.lightBlackColor,
                      width: MediaQuery.of(context).size.width * 0.004,
                    ),
                    borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * 0.005,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.g_mobiledata_rounded,
                        color: Colors.lightBlue,
                        size: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Text(
                        AppStrings.googleSignIn,
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: MediaQuery.of(context).size.height * 0.018,
                          fontFamily: AppFonts.montserratRegular,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              GestureDetector(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.058,
                  width: MediaQuery.of(context).size.width * double.infinity,
                  padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.height * 0.08,
                    left: MediaQuery.of(context).size.height * 0.08,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.lightBlackColor,
                      width: MediaQuery.of(context).size.width * 0.004,
                    ),
                    borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * 0.005,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppImages.facebook,
                        height: MediaQuery.of(context).size.height * 0.035,
                      ),
                      Text(
                        AppStrings.facebookSignIn,
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: MediaQuery.of(context).size.height * 0.018,
                          fontFamily: AppFonts.montserratRegular,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
