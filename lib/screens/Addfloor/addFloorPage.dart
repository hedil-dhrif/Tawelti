import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tawelti/api/api_Response.dart';
import 'package:tawelti/models/Restaurant.dart';
import 'package:tawelti/models/floor.dart';
import 'package:tawelti/screens/Profile/profilePage.dart';
import 'package:tawelti/screens/authentification/SignInPage.dart';
import 'package:tawelti/services/floor.services.dart';
import 'package:tawelti/services/user.services.dart';
import 'package:tawelti/widgets/AppBar.dart';
import 'package:tawelti/widgets/ListHeaders.dart';
import 'package:tawelti/widgets/floorDelete.dart';
import 'package:tawelti/widgets/floorItem.dart';
import 'package:tawelti/widgets/list.dart';

import '../../constants.dart';
import 'FloorDetailsPage.dart';

class AddFloorPage extends StatefulWidget {
  @override
  _AddFloorPageState createState() => _AddFloorPageState();
}

class _AddFloorPageState extends State<AddFloorPage> {
  FloorServices get floorService => GetIt.I<FloorServices>();
  UserServices get userService => GetIt.I<UserServices>();

  List<Floor> floors = [];
  APIResponse<List<Floor>> _apiResponse;
  String errorMessage;

  bool _isLoading = false;

  final FloorNameController = TextEditingController();
  final ZoneNumberController = TextEditingController();
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  void initState() {
    //_fetchFloors();
    _getUserInfo();
    super.initState();
  }

  TextEditingController NameController = TextEditingController();
  bool _isEnabled = false;
  var user;
  int Id;
  Restaurant restaurant;

  void _getUserInfo() async {
    SharedPreferences localStorage1 = await SharedPreferences.getInstance();
    var userId = localStorage1.getInt('id');
    print(userId);
    setState(() {
      user = userId;
      _getUserRestaurant(user);
      print(user);
    });
  }

  _fetchFloors() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await floorService.getFloorsList(restaurant.id.toString());

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    FloorNameController.dispose();
    super.dispose();
  }

  @override
  void dispose1() {
    // Clean up the controller when the widget is disposed.
    ZoneNumberController.dispose();
    super.dispose();
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBarWidget(
          leading: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: KBlue,
              backgroundImage: AssetImage('assets/profil.png'),
            ),
          ),
          title: _isLoading ? '' : restaurant.NomResto,
          onpressed: () {
            _scaffoldKey.currentState.openEndDrawer();
          },
        ),
      ),
      endDrawer: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('Drawer Header'),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Icon(CupertinoIcons.settings),
                      Text('paramètres'),
                    ],
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.logout),
                      Text('déconnexion'),
                    ],
                  ),
                  onTap: () {
                    logout();
                  },
                ),
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: KBlue,
        child: Icon(Icons.add),
        onPressed: () {
          _showMyDialog().then((__) => _fetchFloors());
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: _isLoading?CircularProgressIndicator():_buildFloorList(_apiResponse.data)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xffF4F4F4),
          title: Center(
              child: Text(
            'Add new Floor',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
          )),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          contentPadding: EdgeInsets.all(0.0),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                  child: TextFormField(
                    controller: FloorNameController,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black87),
                        ),
                        labelText: 'Floor Name',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        )),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                final floor = Floor(
                  RestaurantId: restaurant.id,
                  nom: FloorNameController.text,
                );
                print(FloorNameController.text);
                print(ZoneNumberController.text);
                final result = await floorService.createFloor(floor);

                setState(() {
                  _isLoading = false;
                });

                Navigator.of(context).pop();

                final title = 'Done';
                final text = 'Your floor was created';

                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text(title),
                          content: Text(text),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        )).then((data) {
                  if (result.data) {
                    Navigator.of(context).pop();
                  }
                });
              },
              child: Container(
                height: 60,
                width: 240,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: KBlue,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Add floor',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _buildFloorList(List data) {
    if(data.length>0){
      return Container(
        child: ListView.separated(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: ValueKey(data[index].id),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {},
              confirmDismiss: (direction) async {
                final result = await showDialog(
                    context: context, builder: (_) => FloorDelete());

                if (result) {
                  final deleteResult =
                  await floorService.deleteFloor(data[index].id.toString());
                  _fetchFloors();

                  var message = 'The floor was deleted successfully';

                  // showDialog(
                  //     context: context,
                  //     builder: (_) => AlertDialog(
                  //           title: Text('Done'),
                  //           content: Text(message),
                  //           actions: <Widget>[
                  //             FlatButton(
                  //                 child: Text('Ok'),
                  //                 onPressed: () {
                  //                   Navigator.of(context).pop();
                  //                 })
                  //           ],
                  //         ));

                  return deleteResult?.data ?? false;
                }
                print(result);
                return result;
              },
              background: Container(
                color: KBlue,
                padding: EdgeInsets.only(left: 16),
                child: Align(
                  child: Icon(Icons.delete, color: Colors.white),
                  alignment: Alignment.centerLeft,
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return FloorDetailsPage(
                          etageID: data[index].id,
                        );
                      },
                    ),
                  ).then((data) => _fetchFloors());
                },
                child: FloorItem(
                  floorname: data[index].nom,
                  etageId: data[index].id,
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(
            color: Colors.black87,
          ),
        ),
      );
    } else{
      return Center(child: Text('Start managing your plan',style: TextStyle(
        fontSize: 20,color: KBlue,fontWeight: FontWeight.bold
      ),));
    }

  }

  void logout() async {
    // logout from the server ...
    // var res = await CallApi().getData('logout');
    //var body = json.decode(res.body);
    //if(body['success']){
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('user');
    localStorage.remove('token');
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => SignIn()));
  }

  _getUserRestaurant(userId) async {
    setState(() {
      _isLoading = true;
    });
    await userService.getUserRestauarnt(userId.toString()).then((response) {
      if (response.error) {
        errorMessage = response.errorMessage ?? 'An error occurred';
      }
      restaurant = response.data;
      _fetchFloors();
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
