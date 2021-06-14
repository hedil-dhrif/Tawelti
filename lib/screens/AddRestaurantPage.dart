import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tawelti/models/Restaurant.dart';
import 'package:tawelti/screens/Addfloor/test.dart';
import 'package:tawelti/screens/Profile/profilePage.dart';
import 'package:tawelti/services/restaurant.services.dart';
import 'package:tawelti/services/user.services.dart';
import 'package:tawelti/widgets/CustomInputBox.dart';
import 'package:tawelti/widgets/MyCostumTitleWidget.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/widgets/SubmitButton.dart';

class AddRestaurant extends StatefulWidget {
  final int userId;
  AddRestaurant({this.userId});
  @override
  _AddRestaurantState createState() => _AddRestaurantState();
}

class _AddRestaurantState extends State<AddRestaurant> {
  RestaurantServices get restaurantService => GetIt.I<RestaurantServices>();
  UserServices get userService => GetIt.I<UserServices>();
  bool _isLoading = false;
  bool _validate = false;

  TextEditingController NameController = TextEditingController();
  TextEditingController LocationController = TextEditingController();
  TextEditingController DescriptionController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  ScaffoldState scaffoldState;
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: KBlue,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              //padding: EdgeInsets.only(top: 80),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: ExactAssetImage('assets/uppernejma.png'),
                    fit: BoxFit.cover),
              ),
            ),
          ),
        //  Positioned(top:50,child: Text(,style: TextStyle(fontSize: 40,color: Colors.white),)),
          Positioned(
            top: 80,
            left: 50,
            child: MyCostumTitle(
              MyTitle: 'Welcom to \n TAWELTI',
              size: 45,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(top: 200),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyCustomInputBox(
                    validate: _validate,
                    label: 'Restaurant Name',
                    inputHint: 'John',
                    color: KBeige,
                    controller: NameController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //
                  MyCustomInputBox(
                    validate: _validate,
                    label: 'Location',
                    inputHint: 'tunis, tunis',
                    color: KBeige,
                    controller: LocationController,
                  ),
                  //
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // //
                  // MyCustomInputBox(
                  //   validate: _validate,
                  //   label: 'Phone number',
                  //   inputHint: '22 222 222',
                  //   color: KBeige,
                  //   controller: PhoneController,
                  // ),
                  // //
                  SizedBox(
                    height: 10,
                  ),
                  MyCustomInputBox(
                    validate: _validate,
                    label: 'Description',
                    inputHint: 'add description for your restaurant',
                    color: KBeige,
                    controller: DescriptionController,
                  ),
                  SubmiButton(
                    scrWidth: scrWidth,
                    scrHeight: scrHeight,
                    // tap: () {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => HomePage()));
                    // },
                    tap: () {
                      setState(() {
                        NameController.text.isEmpty ? _validate = true : _validate = false;
                        LocationController.text.isEmpty ? _validate = true : _validate = false;
                        DescriptionController.text.isEmpty ? _validate = true : _validate = false;
                      });
                      _addRestaurant(widget.userId);
                    },
                    title: 'Add Restaurant',
                    bcolor: KBeige,
                    size: 25,
                    color: Color(0xFF333133),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _addRestaurant(userId) async {
    setState(() {
      _isLoading = true;
    });
    final restaurant = Restaurant(
      userId: widget.userId,
      NomResto: NameController.text,
      adresse: LocationController.text,
      Description: DescriptionController.text,
    );
    print(restaurant.NomResto);
    print(restaurant.adresse);
    //print(LinkController.text);
    final result = await restaurantService.createRestaurant(restaurant);

    setState(() {
      _isLoading = false;
    });

    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => Test()));

    // final title = 'Done';
    // final text = 'Your note was created';
    //
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Done'),
              content: Text('Your restaurant has been added successfully !!'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Test()));
                  },
                )
              ],
            ));
  }
}
