import 'package:custom_switch_button/custom_switch_button.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:tawelti/screens/Profile/profilePage.dart';
import 'package:tawelti/widgets/CuisineItem.dart';
import 'package:tawelti/widgets/DescriptionInput.dart';
import 'package:tawelti/widgets/InputText.dart';
import 'package:tawelti/widgets/ProfileAvatar.dart';
import 'package:tawelti/widgets/SubmitButton.dart';
import 'package:tawelti/widgets/addPhotos.dart';
import 'package:tawelti/widgets/listCuisine.dart';

import '../../constants.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black87),
                                ),
                                hintText: 'Restaurant Name',
                                hintStyle: TextStyle(fontSize: 20, color: Colors.black,)
                            ),
                          ),
                        ),
                        Container(
                          width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Icon(Icons.edit_outlined,size: 24,))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            InputText(label: 'Email',inputHint: 'email@gmail.com',),
            InputText(label: 'Phone number',inputHint: '20158745',),
            InputText(label: 'Adresse',inputHint: 'Rue *******',),
            DescriptionTextWidget(text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, see more'),
            GetCuisineCategory(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text('Boissons',style: TextStyle(fontSize: 20,),),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                    child: Center(
                      child: CustomSwitchButton(
                        backgroundColor: KBeige,
                        unCheckedColor: Colors.white,
                        animationDuration: Duration(milliseconds: 400),
                        checkedColor: KBlue,
                        checked: isChecked,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //AddPhotos(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SubmiButton(scrWidth: MediaQuery.of(context).size.width, scrHeight: MediaQuery.of(context).size.height, size: 24, tap: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ProfilePage()));
              }, title: 'Submit', color: Colors.white, bcolor: KBlue),
            )
          ],
        ),
      ),
    );
  }
}
