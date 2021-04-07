import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tawelti/widgets/AppBar.dart';
import 'package:tawelti/widgets/AddButton.dart';
import 'package:tawelti/widgets/navbar2.dart';
import 'package:tawelti/widgets/roundedButton.dart';
import '../constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: AppBarWidget(
          title: 'Add to wait list',
          icon: Icons.close,
          onpressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ),
      bottomNavigationBar: BottomNavBarV2(bgColor: KBlue,
        activeIconColor: Colors.white,
        deactiveIconColor: Colors.grey[300],
        syncButton: RoundedButton(
         radius: 60,
          color: KBeige,
          // press: () => Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => StatsPage())),
          icon:   SvgPicture.asset(
            'assets/plus.svg',
            color: Colors.white,
            height:32,
            width: 32,
          ),
        ),),
      body: Column(
        children: [
          SizedBox(
            height: 150,
          ),
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text('Manage your \n   floor plan',style: TextStyle(fontSize: 20,),),
                ),
                AddButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
