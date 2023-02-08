import 'dart:convert';
import 'package:ecommerce_api/widgets/my_pages.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObsecure = true;

  getLogin() async {
    try {
      setState(() {
        isLoading = true;
      });
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String link = "https://apihomechef.antopolis.xyz/api/admin/sign-in";
      var map = Map<String, dynamic>();
      map["email"] = emailController.text.toString();
      map["password"] = passwordController.text.toString();
      var responce = await http.post(Uri.parse(link), body: map);
      var data = jsonDecode(responce.body);
      setState(() {
        isLoading = false;
      });
      print("access token is ${data["access_token"]}");
      if (data["access_token"] != null) {
        sharedPreferences.setString("token", data["access_token"]);
        print("saved token is ${sharedPreferences.getString("token")}");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MyPage()),
            (route) => false);
      } else {
        Fluttertoast.showToast(msg: "Email or Password doesn't match");
      }
    } catch (e) {
      print(e);
    }
  }

  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://static.vecteezy.com/system/resources/previews/002/414/434/original/abstract-colorful-fun-background-vector.jpg"),
                fit: BoxFit.cover)),
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 250),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
              color: Colors.white,
              border: Border.all(color: Colors.amber, width: 3)),
          child: Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            child: Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Admin Login',
                      style: TextStyle(
                          fontSize: 26,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Welcome Back!',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.3),
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          Fluttertoast.showToast(msg: "Password is required");
                        }
                      },
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.3),
                          fontWeight: FontWeight.bold),
                      controller: emailController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2.5, color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2.5, color: Colors.amber),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: "Enter your email",
                        labelText: "EMAIL",
                        labelStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.3),
                            fontWeight: FontWeight.bold),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          Fluttertoast.showToast(msg: "Password is required");
                        }
                      },
                      obscureText: isObsecure,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black.withOpacity(0.3),
                          fontWeight: FontWeight.bold),
                      controller: passwordController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.5, color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2.5, color: Colors.amber),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: "Enter your password",
                          labelText: "PASSWORD",
                          labelStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          hintStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black.withOpacity(0.3),
                              fontWeight: FontWeight.bold),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.blueGrey,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isObsecure = !isObsecure;
                              });
                            },
                            icon: Icon(isObsecure == false
                                ? Icons.visibility
                                : Icons.visibility_off),
                            color: isObsecure == false
                                ? Colors.green
                                : Colors.orange,
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          /* Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MyDrawer()));*/
                          getLogin();
                        } else {
                          Fluttertoast.showToast(msg: "Enter all fields");
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.amber,
                            border: Border.all(
                                color: Colors.deepPurple, width: 2.5)),
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Don\'t have an account?',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black.withOpacity(0.3),
                                fontWeight: FontWeight.bold)),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.deepPurple, width: 2.5)),
                            child: Center(
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: CircleAvatar(
                              child: Image.asset(
                                'images/facebook.png',
                                fit: BoxFit.cover,
                              ),
                            )),
                        TextButton(
                            onPressed: () {},
                            child: CircleAvatar(
                              child: Image.asset(
                                'images/instagram.png',
                                fit: BoxFit.cover,
                              ),
                            )),
                        TextButton(
                            onPressed: () {},
                            child: CircleAvatar(
                              child: Image.asset(
                                'images/linkedin.png',
                                fit: BoxFit.cover,
                              ),
                            )),
                        TextButton(
                            onPressed: () {},
                            child: CircleAvatar(
                              child: Image.asset(
                                'images/twitter.png',
                                fit: BoxFit.cover,
                              ),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
