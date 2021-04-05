import 'package:flutter/material.dart';
import 'package:tawelti/widgets/ProfileAvatar.dart';
import 'package:tawelti/widgets/nestedTabs.dart';
import 'package:tawelti/widgets/profileCarousel.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Text('Restaurant name',style:TextStyle(fontSize: 20, color: Colors.black,)),
                    Text('email@gmail.com',style: TextStyle(fontSize: 20, color: Colors.blueGrey,),),
                    Text('2154897',style: TextStyle(fontSize: 20, color: Colors.blueGrey,),),
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
