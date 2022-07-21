import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../services/errorhandle.dart';
import '../login/login_test.dart';
import '../login/login_view.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  late TextEditingController _fullnameTextController =
  TextEditingController(text: '');
  late TextEditingController _emailTextController =
  TextEditingController(text: '');
  late TextEditingController _passTextController =
  TextEditingController(text: '');
  late TextEditingController _positionCPTextController =
  TextEditingController(text: '');
  late TextEditingController _phoneTextController =
  TextEditingController(text: '');
  FocusNode _fullnameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();
  FocusNode _positionFocusNode = FocusNode();
  bool _obscureText = true;
  final _signUpFormKey = GlobalKey<FormState>();
  File? imageFile;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  get id => null;

  get movie_title => null;
  @override
  void dispose() {
    _fullnameTextController.dispose();
    _emailTextController.dispose();
    _passTextController.dispose();
    _positionCPTextController.dispose();
    _fullnameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passFocusNode.dispose();
    _positionFocusNode.dispose();
    _phoneFocusNode.dispose();
    _phoneTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void submitFormOnSignUp() async {
    final isValid = _signUpFormKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      setState(() {
        _isLoading = true;
      });
      try {
        await _auth.createUserWithEmailAndPassword(
            email: _emailTextController.text.toLowerCase().trim(),
            password: _passTextController.text.trim());
        final User? user=FirebaseAuth.instance.currentUser;
        final userID=user!.uid;
        await FirebaseFirestore.instance.collection('users').doc(userID).set({
          'id': userID,
          'name': _fullnameTextController.text,
          'email': _emailTextController.text,
          'phone_number':_phoneTextController,
          'createdTime': Timestamp.now()});
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        GlobalMethods.showErrorDialog(
            error: error.toString(), context: context);
        print('error: $error');
      }
    } else {
      print('Form not valid');
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
       backgroundColor: Colors.black38,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  Text(
                    'Register',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Already have an account?',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '   '),
                        TextSpan(
                          text: 'Login',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            ),
                          style: TextStyle(
                              color: Colors.blue.shade300,
                              decoration: TextDecoration.underline,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              flex: 2,
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                focusNode: _fullnameFocusNode,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(_emailFocusNode),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Field can\'t be missing';
                                  }
                                  return null;
                                },
                                controller: _fullnameTextController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'Full name',
                                  hintStyle: TextStyle(color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.pink.shade700),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: size.width * 0.24,
                                      height: size.width * 0.24,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: Colors.white),
                                          borderRadius: BorderRadius.circular(16)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: imageFile == null
                                            ? Image.network(
                                          'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png',
                                          fit: BoxFit.fill,
                                        )
                                            : Image.file(
                                          imageFile!,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: InkWell(

                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.pink,
                                          border: Border.all(
                                              width: 2, color: Colors.white),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            imageFile == null
                                                ? Icons.add_a_photo
                                                : Icons.edit_outlined,
                                            size: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          focusNode: _emailFocusNode,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_passFocusNode),
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid Email adress';
                            }
                            return null;
                          },
                          controller: _emailTextController,
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.pink.shade700),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //Password TextField

                        TextFormField(
                          focusNode: _passFocusNode,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_phoneFocusNode),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 7) {
                              return 'Please enter a valid password';
                            }
                            return null;
                          },
                          obscureText: _obscureText,
                          controller: _passTextController,
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                            ),
                            hintText: 'Password',
                            hintStyle: const TextStyle(color: Colors.white),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.pink.shade700),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          focusNode: _phoneFocusNode,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_positionFocusNode),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Field can\'t be missing';
                            }
                            return null;
                          },
                          onChanged: (v) {
                            print(
                                '_phoneTextController.text ${_phoneTextController.text}');
                          },
                          controller: _phoneTextController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Phone number',
                            hintStyle: const TextStyle(color: Colors.white),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.pink.shade700),
                            ),
                            errorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                        // SizedBox(
                        //   height: 10,
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  _isLoading
                      ? Center(
                    child: Container(
                      width: 70,
                      height: 70,
                      child: const CircularProgressIndicator(),
                    ),
                  )
                      : MaterialButton(
                    onPressed: (){
                      submitFormOnSignUp();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_)=>const LoginView()));
                    },
                    color: Colors.pink.shade700,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                        side: BorderSide.none),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          child: Text(
                            'Register',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.person_add,
                          color: Colors.white,
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }










}
