import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tawelti/api/api.dart';
import 'package:tawelti/models/Restaurant.dart';
import 'package:tawelti/models/user.dart';
import 'package:tawelti/screens/Profile/editProfile.dart';
import 'package:tawelti/services/restaurant.services.dart';
import 'package:tawelti/services/user.services.dart';
import 'package:tawelti/widgets/AppBar.dart';
import 'package:tawelti/widgets/ProfileAvatar.dart';
import 'package:tawelti/widgets/nestedTabs.dart';
import 'package:tawelti/widgets/profileCarousel.dart';

import '../../constants.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}
GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

class _ProfilePageState extends State<ProfilePage> {
  //RestaurantServices get restaurantService => GetIt.I<RestaurantServices>();
  UserServices get userService=>GetIt.I<UserServices>();
  bool _isLoading = false;
 // bool get isEditing => widget.userId != null;

  String errorMessage;
  Restaurant restaurant;
  //User user;

  @override
  void initState() {
    super.initState();
    _getUserInfo();
    super.initState();
  }
  TextEditingController NameController = TextEditingController();
  bool _isEnabled =false;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBarWidget(
          leading: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: KBlue,
              backgroundImage: AssetImage('assets/profil.png'),
            ),
          ),
          title: _isLoading?'':restaurant.NomResto,
          onpressed: () {
            _scaffoldKey.currentState.openEndDrawer();
          },
        ),
      ),
      body: _isLoading?CircularProgressIndicator():Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ProfileAvatar(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.username,style:TextStyle(fontSize: 18, color: Colors.black,)),
                    Text(user.email,style: TextStyle(fontSize: 18, color: Colors.blueGrey,),),
                    Text(user.phone,style: TextStyle(fontSize: 18, color: Colors.blueGrey,),),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfilePage())).then((__) => _getUserRestaurant(user));
                      print(restaurant);
                      print(user);
                      },

                        child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Icon(Icons.edit_outlined,size: 24,))),
                  ],
                ),
              )
            ],
          ),
        // ProfileCarousel(),
          NestedTabBar(description: restaurant.Description,location: restaurant.adresse,restaurantId: restaurant.id.toString(),),
        ],
      ),
    );
  }

  _getUserProfile(userId)async{
    setState(() {
      _isLoading=true;
    });
     await userService.getUserProfile(userId.toString()).then((response) {

      if (response.error) {
        errorMessage = response.errorMessage ?? 'An error occurred';
      }
      user = response.data;
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
  _getUserRestaurant(userId) async {
    setState(() {
      _isLoading = true;
    });
      await userService.getUserRestauarnt(userId.toString()).then((response) {
        if (response.error) {
          errorMessage = response.errorMessage ?? 'An error occurred';
        }
        restaurant = response.data ;
        print(restaurant.id);
        print(restaurant.NomResto);
        print(restaurant.id);
        print(restaurant.adresse);
        print(restaurant.Description);
      setState(() {
        _isLoading = false;
      });

      // _titleController.text = floor.nom;
      //_contentController.text = note.noteContent;
    });
  }
}
