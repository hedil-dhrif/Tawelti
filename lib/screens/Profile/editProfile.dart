import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tawelti/api/api.dart';
import 'package:tawelti/models/Restaurant.dart';
import 'package:tawelti/services/restaurant.services.dart';
import 'package:tawelti/services/user.services.dart';
import 'package:tawelti/widgets/AppBar.dart';
import 'package:tawelti/widgets/DescriptionInput.dart';
import 'package:tawelti/widgets/InputText.dart';
import 'package:tawelti/widgets/ProfileAvatar.dart';
import 'package:tawelti/widgets/SubmitButton.dart';
import 'package:tawelti/widgets/ambianceList.dart';
import 'package:tawelti/widgets/budgets.dart';
import 'package:tawelti/widgets/etablissementList.dart';
import 'package:tawelti/widgets/generalsList.dart';
import 'package:tawelti/widgets/listCuisine.dart';
import '../../constants.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isChecked = false;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  UserServices get userService => GetIt.I<UserServices>();
  RestaurantServices get restaurantService => GetIt.I<RestaurantServices>();
  bool _isLoading = false;
  bool _enabled = false;
  // bool get isEditing => widget.userId != null;
  Future<List<String>>listAmbiances ;
  List<String> listEtablissements = [];
  List<String> listCuisines = [];
  List<String> listGenerals = [];
  String errorMessage;
  Restaurant restaurant;
  int restaurantId;
  //User user;
  String username;
  TextEditingController RestNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  TextEditingController adresseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUserInfo();
    super.initState();
  }

  var user;
  int Id;

  void _getUserInfo() async {
    SharedPreferences localStorage1 = await SharedPreferences.getInstance();
    var userId = localStorage1.getInt('id');
    print(userId);
    setState(() {
      user = userId;
      _getUserProfile(user);
      _getUserRestaurant(user);
      print(user);
    });
  }

  _getUserRestaurant(userId) {
    setState(() {
      _isLoading = true;
    });
    userService.getUserRestauarnt(userId.toString()).then((response) {
      setState(() {
        _isLoading = false;
      });

      if (response.error) {
        errorMessage = response.errorMessage ?? 'An error occurred';
      }
      restaurant = response.data;
      RestNameController.text = restaurant.NomResto;
      adresseController.text = restaurant.adresse;
      descriptionController.text = restaurant.Description;
      restaurantId = restaurant.id;
     print(listAmbiances);
      // _restaurantProfile.getEstablishement(restaurantId.toString());
      // _restaurantProfile.getCuisine(restaurantId.toString());
      // _restaurantProfile.getGeneral(restaurantId.toString());
      print(restaurant.NomResto);
      print(restaurant.id);
      print(restaurant.adresse);
      print(restaurant.Description);
      // _titleController.text = floor.nom;
      //_contentController.text = note.noteContent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBarWidget(
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(CupertinoIcons.arrow_left)),
          title: _isLoading ? '' : restaurant.NomResto,
          onpressed: () {
            _scaffoldKey.currentState.openEndDrawer();
          },
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  ProfileAvatar(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 170,
                          child: TextFormField(
                            enabled: _enabled,
                            controller: RestNameController,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black87),
                                ),
                                hintText: 'Restaurant Name',
                                hintStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _enabled = !_enabled;
                            });
                          },
                          child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Icon(
                                Icons.edit_outlined,
                                size: 24,
                              )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            InputText(
              label: 'Email',
              inputHint: 'email@gmail.com',
              controller: emailController,
              enabled: _enabled,
            ),
            InputText(
                label: 'Phone number',
                inputHint: '20158745',
                controller: PhoneController,
                enabled: _enabled),
            InputText(
                label: 'Adresse',
                inputHint: 'Rue *******',
                controller: adresseController,
                enabled: _enabled),
            DescriptionTextWidget(
              text: restaurant.Description,
            ),
            GetCuisineCategory(restaurantID: restaurantId,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(10),
                  //   child: Text(
                  //     'Boissons',
                  //     style: TextStyle(
                  //       fontSize: 20,
                  //     ),
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     setState(() {
                  //       isChecked = !isChecked;
                  //     });
                  //   },
                  //   child: Center(
                  //     child: CustomSwitchButton(
                  //       backgroundColor: KBeige,
                  //       unCheckedColor: Colors.white,
                  //       animationDuration: Duration(milliseconds: 400),
                  //       checkedColor: KBlue,
                  //       checked: isChecked,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            GetAmbianceCategory(
              restaurantId: restaurantId,
            ),
            GetEtablissementCategory(restaurantID: restaurantId,),
            GetGeneralCategory(restaurantID: restaurantId,),
            GetBudget(),
            // AddPhotos(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SubmiButton(
                  scrWidth: MediaQuery.of(context).size.width,
                  scrHeight: MediaQuery.of(context).size.height,
                  size: 24,
                  tap: () async {
                    // setState(() {
                    //   _isLoading = true;
                    // });
                    final restaurantUp = Restaurant(
                      NomResto: RestNameController.text,
                      adresse: adresseController.text,
                      Description: descriptionController.text,
                    );
                    print(restaurant.NomResto);
                    print(restaurant.id);
                    //print(widget.userId);
                    //  final result = await restaurantService.updateRestaurant(
                    //      restaurant.id.toString(), restaurantUp);
                    _updateUser(user.id.toString());
                    setState(() {
                      _isLoading = false;
                    });

                    // final title = 'Done';
                    // final text = 'Your profile was updated';
                    //
                    // showDialog(
                    //     context: context,
                    //     builder: (_) => AlertDialog(
                    //           title: Text(title),
                    //           content: Text(text),
                    //           actions: <Widget>[
                    //             FlatButton(
                    //               child: Text('Ok'),
                    //               onPressed: () {
                    //                 Navigator.of(context).pop();
                    //               },
                    //             )
                    //           ],
                    //         )).then((data) {
                    //   if (result.data) {
                    //     Navigator.of(context).pop();
                    //   }
                    // });

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (BuildContext context) => ProfilePage()));
                  },
                  title: 'Submit',
                  color: Colors.white,
                  bcolor: KBlue),
            )
          ],
        ),
      ),
    );
  }

  _getUserProfile(userId) async {
    setState(() {
      _isLoading = true;
    });
    await userService.getUserProfile(userId.toString()).then((response) {
      if (response.error) {
        errorMessage = response.errorMessage ?? 'An error occurred';
      }
      user = response.data;
      emailController.text = user.email;
      PhoneController.text = user.phone;
      print(user.username);
      print(user.email);
      print(user.id);
      // _titleController.text = floor.nom;
      //_contentController.text = note.noteContent;
    });
    setState(() {
      _isLoading = false;
    });
  }

  void _updateUser(userId) async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      'email': emailController.text,
      // 'password' : passwordController.text,
      // 'phone' : phoneController.text,
    };
    print(userId);
    print(emailController.text);
    var res = await CallApi().updateData(data, 'users/update/', userId);
    var body = json.decode(res.body.toString());
    print(body);
    setState(() {
      _isLoading = false;
    });
  }
}
