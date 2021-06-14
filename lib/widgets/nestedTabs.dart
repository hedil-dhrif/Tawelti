import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tawelti/api/api_Response.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/models/event.dart';
import 'package:tawelti/screens/event/DetailsEvent.dart';
import 'package:tawelti/services/restaurant.services.dart';
import 'package:tawelti/widgets/EventCard.dart';
import 'package:tawelti/widgets/profileCarousel.dart';

import 'DescriptionInput.dart';


class NestedTabBar extends StatefulWidget {
  final String restaurantId;
  final String description;
  final String location;
  NestedTabBar({this.description,this.location,this.restaurantId});
  @override
  _NestedTabBarState createState() => _NestedTabBarState();
}
class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  TabController _nestedTabController;
  RestaurantServices get restaurantService => GetIt.I<RestaurantServices>();
  List<Event> events = [];
  APIResponse<List<Event>> _apiResponse;
  bool _isLoading = false;
  String errorMessage;
  String email;
  String phone;
  bool _enabled= true;
  @override
  void initState() {
    _fetchEvents();
    super.initState();
    _nestedTabController = new TabController(length: 2, vsync: this);
  }

  _fetchEvents() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await restaurantService.getRestaurantsListEvents(widget.restaurantId.toString());
    print(_apiResponse.data.length);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TabBar(
          controller: _nestedTabController,
          indicatorColor: KBeige,
          labelColor: KBlue,
          unselectedLabelColor: Colors.black54,
          isScrollable: true,
          labelStyle: TextStyle(fontSize: 18, color: Colors.black,),
          tabs: <Widget>[
            Tab(
              text: "Profile info",
            ),
            Tab(
              text: "Events",
            ),
          ],
        ),
        Container(
          height: screenHeight*0.5,
          child: TabBarView(
            controller: _nestedTabController,
            children: <Widget>[
              Container(
                child: ListView(
                  children: [
                    ProfileCarousel(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                      child: Text('Location',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: KBlue),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(widget.location,style: TextStyle(fontSize: 18),),
                    ),
                    DescriptionTextWidget(text: widget.description),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    //   child: Text('Cuisine',style: TextStyle(fontSize: 20,),),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20),
                    //   child: Text('Cuisine Tunisenne',style: TextStyle(fontSize: 18),),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    //   child: Text('Menu',style: TextStyle(fontSize: 20,),),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20),
                    //   child: Container(
                    //     height: 200,
                    //     //width: 150,
                    //     decoration: BoxDecoration(
                    //       color: Colors.grey,
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //   ),
                    // )
                  ],
                ),

              ),
              Container(
                height: MediaQuery.of(context).size.height*0.6,
                child:Center(child: _buildEventsList(_apiResponse.data),) ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.orangeAccent,
                ),
              ),

            ],
          ),
        )
      ],
    );
  }

  _buildEventsList(List data) {
    return data.length>0?Container(
      child: ListView.separated(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return EventCard(
            EventName: data[index].nom,
            category: data[index].category,
            description: data[index].description,
            pressDetails:  () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => DetailsEvent(eventId: data[index].id,))).then((__) => _fetchEvents());
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
          color: Colors.black87,
        ),
      ),
    ):Text('this restaurant don\'t have any events',style: TextStyle(fontSize: 20),);
  }
}