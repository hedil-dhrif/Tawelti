import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tawelti/api/api.dart';
import 'package:tawelti/models/Restaurant.dart';
import 'package:tawelti/screens/AddRestaurantPage.dart';
import 'package:tawelti/screens/Addfloor/test.dart';
import 'package:tawelti/screens/authentification/GetPassword.dart';
import 'package:tawelti/services/user.services.dart';
import 'package:tawelti/widgets/CustomInputBox.dart';
import 'package:tawelti/widgets/MyCostumTitleWidget.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/widgets/SubmitButton.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isLoading = false;
 String token;
 int userId;
 String username;
  bool _validate = false;
  bool _hasResto = false;
  UserServices get userService=>GetIt.I<UserServices>();
  // bool get isEditing => widget.userId != null;

  String errorMessage;
  Restaurant restaurant;
  //User user;
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ScaffoldState scaffoldState;
  _showMsg(msg) { //
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 150),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Color(0xFFFEFEFE), BlendMode.dstATop),
                    image: ExactAssetImage('assets/uppernejma.png'),
                    fit: BoxFit.cover),
              ),
              child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyCostumTitle(
                    MyTitle: 'Sign In',
                    size: 60,
                  ),
                  MyCustomInputBox(
                    validate: _validate,
                    label: 'email',
                    inputHint: 'John',
                    color: KBlue,
                    controller: mailController,
                  ),
                  MyCustomInputBox(
                    validate: _validate,
                    label: 'Password',
                    inputHint: '8+ Characters,1 Capital letter',
                    color: KBlue,
                    controller: passwordController,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GetPassword()));
                    },
                    child: Text(
                      'forgot my password',
                      style: TextStyle(
                        fontSize: 15,
                        color: KBlue,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                  SubmiButton(
                    scrWidth: scrWidth,
                    scrHeight: scrHeight,
                    tap: () {
                      setState(() {
                        mailController.text.isEmpty ? _validate = true : _validate = false;
                        passwordController.text.isEmpty ? _validate = true : _validate = false;
                      });
                      _login();
                      //_isLoading ? null : _login;
                    },
                    title: 'Login',
                    bcolor: KBlue,
                    size: 20,
                    color: Colors.white70,
                  ),
                  // FlatButton(onPressed: (){
                  //   _getProfile();
                  // }, child:Container(color:Colors.blue,child: Text('getProfile')))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _login() async{

    setState(() {
      _isLoading = true;
    });

    var data = {
      'email' : mailController.text,
      'password' : passwordController.text
    };

    var res = await CallApi().postData(data, 'users/login');
    var body = jsonDecode(res.body);
    //if(body['status_code']==200){
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('token', body['token']);
    token=body['token'];
    _getProfile();
    print(body);
    // localStorage.setString('user', json.decode(body['userData']));
    // print(body['userData']);
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) =>Test()));
    // }else{
    //   print('error');
    // }


    setState(() {
      _isLoading = false;
    });

  }

  void _getProfile()async{
    var res = await CallApi().getProfile('users/profile',token);
    var body = json.decode(res.body);
    SharedPreferences localStorage1 = await SharedPreferences.getInstance();
    localStorage1.setInt('id', json.decode(body['id'].toString()));
    print(body['id']);
    _getUserRestaurant(body['id']);
    userId=body['id'];
    // username=body['username'];
    // print(userId);
    // print(body);
  }

  _getUserRestaurant(userId) async {
    setState(() {
      _isLoading = true;
    });
    await userService.getUserRestauarnt(userId.toString()).then((response) {
      if (response.error) {
        errorMessage = response.errorMessage ?? 'An error occurred';
      }
      restaurant = response.data ;
      print(restaurant.NomResto);
      print(restaurant.id);
      print(restaurant.adresse);
      print(restaurant.Description);
      _checkIfHasResto();
      setState(() {
        _isLoading = false;
      });

      // _titleController.text = floor.nom;
      //_contentController.text = note.noteContent;
    });
  }

  void _checkIfHasResto() async{
    // check if token is there
    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    // var token = localStorage.getString('id');
    if(restaurant.id!= null){
      setState(() {
        _hasResto = true;
      });
    }
  }
}
