import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawelti/screens/Profile/editProfile.dart';
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
          title: 'Restaurant name',
          onpressed: () {
            _scaffoldKey.currentState.openEndDrawer();
          },
        ),
      ),
      body: Column(
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
                    Text('Restaurant name',style:TextStyle(fontSize: 18, color: Colors.black,)),
                    Text('email@gmail.com',style: TextStyle(fontSize: 18, color: Colors.blueGrey,),),
                    Text('2154897',style: TextStyle(fontSize: 18, color: Colors.blueGrey,),),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfilePage()));
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
         //ProfileCarousel(),
          NestedTabBar(),
        ],
      ),
    );
  }
}
