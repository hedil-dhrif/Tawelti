import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tawelti/api/api_Response.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/models/Cuisine.dart';
import 'package:tawelti/models/ambiance.dart';
import 'package:tawelti/models/etablissement.dart';
import 'package:tawelti/models/event.dart';
import 'package:tawelti/models/general.dart';
import 'package:tawelti/screens/event/DetailsEvent.dart';
import 'package:tawelti/services/ambiance.services.dart';
import 'package:tawelti/services/cuisine.services.dart';
import 'package:tawelti/services/etablissement.services.dart';
import 'package:tawelti/services/general.services.dart';
import 'package:tawelti/services/restaurant.services.dart';
import 'package:tawelti/widgets/EventCard.dart';
import 'package:tawelti/widgets/profileCarousel.dart';

import 'DescriptionInput.dart';

class NestedTabBar extends StatefulWidget {
  final String restaurantId;
  final String description;
  final String location;
  NestedTabBar({this.description, this.location, this.restaurantId});
  @override
  _NestedTabBarState createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  TabController _nestedTabController;
  RestaurantServices get restaurantService => GetIt.I<RestaurantServices>();
  AmbianceServices get ambianceService => GetIt.I<AmbianceServices>();
  GeneralServices get generalService => GetIt.I<GeneralServices>();
 EtablissementServices get etablissementService => GetIt.I<EtablissementServices>();
 CuisineServices get cuisineService => GetIt.I<CuisineServices>();
  APIResponse<List<Ambiance>> _ambianceResponse;
  APIResponse<List<General>> _generalResponse;
  APIResponse<List<Etablissement>> _etablissementResponse;
  APIResponse<List<Cuisine>> _cuisineResponse;
  final List<String> listAmbiances = [];
  final List<String> listGenerals=[];
  final List<String> listEtablissement=[];
  final List<String> listCuisines=[];
  List<Event> events = [];
  APIResponse<List<Event>> _apiResponse;
  bool _isLoading = false;
  String errorMessage;
  String email;
  String phone;
  bool _enabled = true;
  @override
  void initState() {
    _fetchEvents();
    _fetchAmbiances();
    _fetchGenerals();
    _fetchEtablissements();
    _fetchCuisines();
    super.initState();
    _nestedTabController = new TabController(length: 2, vsync: this);
  }

  _fetchEvents() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await restaurantService
        .getRestaurantsListEvents(widget.restaurantId.toString());
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
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TabBar(
          controller: _nestedTabController,
          indicatorColor: KBeige,
          labelColor: KBlue,
          unselectedLabelColor: Colors.black54,
          isScrollable: true,
          labelStyle: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
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
          height: screenHeight * 0.6,
          child: TabBarView(
            controller: _nestedTabController,
            children: <Widget>[
              Container(
                child: ListView(
                  children: [
                    ProfileCarousel(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: Text(
                        'Location',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: KBlue),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        widget.location,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    DescriptionTextWidget(text: widget.description),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: Text(
                        'Cuisine',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: KBlue),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30,right: 20,),
                      child: Wrap(
                        runSpacing: 15.0,
                        spacing: 10.0,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(listCuisines.length, (index) {
                          return Container(
                              decoration: BoxDecoration(
                                color: KBlue,
                                border: Border.all(color: KBlue),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  listCuisines[index].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ));
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: Text(
                        'Etablissement',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: KBlue),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30,right: 20,),
                      child: Wrap(
                        runSpacing: 15.0,
                        spacing: 10.0,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(listEtablissement.length, (index) {
                          return Container(
                              decoration: BoxDecoration(
                                color: KBlue,
                                border: Border.all(color: KBlue),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  listEtablissement[index].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ));
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: Text(
                        'Ambiance',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: KBlue),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30,right: 20,),
                      child: Wrap(
                        runSpacing: 15.0,
                        spacing: 10.0,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(listAmbiances.length, (index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: KBlue,
                              border: Border.all(color: KBlue),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                            listAmbiances[index].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white,
                            ),
                          ),
                              ));
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: Text(
                        'General',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: KBlue),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30,right: 20,),
                      child: Wrap(
                        runSpacing: 15.0,
                        spacing: 10.0,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(listGenerals.length, (index) {
                          return Container(
                              decoration: BoxDecoration(
                                color: KBlue,
                                border: Border.all(color: KBlue),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  listGenerals[index].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ));
                        }),
                      ),
                    ),
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
                height: MediaQuery.of(context).size.height * 0.6,
                child: Center(
                  child: _buildEventsList(_apiResponse.data),
                ),
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
    return data.length > 0
        ? Container(
            child: ListView.separated(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return EventCard(
                  EventName: data[index].nom,
                  category: data[index].category,
                  description: data[index].description,
                  pressDetails: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsEvent(
                                  eventId: data[index].id,
                                ))).then((__) => _fetchEvents());
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                color: Colors.black87,
              ),
            ),
          )
        : Text(
            'this restaurant don\'t have any events',
            style: TextStyle(fontSize: 20),
          );
  }

  _fetchAmbiances() async {
    setState(() {
      _isLoading = true;
    });

    _ambianceResponse = await ambianceService
        .getRestaurantsListAmbiance(widget.restaurantId.toString());
    _buildListAmbiances();
    setState(() {
      _isLoading = false;
    });
  }

  _fetchGenerals() async {
    setState(() {
      _isLoading = true;
    });

    _generalResponse = await generalService
        .getRestaurantsListGeneral(widget.restaurantId.toString());
    _buildListGenerals();
    setState(() {
      _isLoading = false;
    });
  }
  _fetchEtablissements() async {
    setState(() {
      _isLoading = true;
    });

    _etablissementResponse = await etablissementService
        .getRestaurantsListEtablissement(widget.restaurantId.toString());
    _buildListEtablissements();
    setState(() {
      _isLoading = false;
    });
  }

  _fetchCuisines() async {
    setState(() {
      _isLoading = true;
    });

    _cuisineResponse = await cuisineService
        .getRestaurantsListCuisine(widget.restaurantId.toString());
    _buildListCuisines();
    setState(() {
      _isLoading = false;
    });
  }

  _buildListAmbiances() {
    setState(() {
      _isLoading = true;
    });

    for (int i = 0; i < _ambianceResponse.data.length; i++) {
      if(listAmbiances.contains(_ambianceResponse.data[i].type)){
        i++;
      }else{
        listAmbiances.add(_ambianceResponse.data[i].type);
      }
    }
    print(listAmbiances);
    setState(() {
      _isLoading = false;
    });
  }
  _buildListCuisines() {
    setState(() {
      _isLoading = true;
    });

    for (int i = 0; i < _cuisineResponse.data.length; i++) {
      if(listCuisines.contains(_cuisineResponse.data[i].type)){
        i++;
      }else{
        listCuisines.add(_cuisineResponse.data[i].type);
      }
    }
    print(listCuisines);
    setState(() {
      _isLoading = false;
    });
  }
  _buildListGenerals() {
    setState(() {
      _isLoading = true;
    });

    for (int i = 0; i < _generalResponse.data.length; i++) {
      if(listGenerals.contains(_generalResponse.data[i].type)){
        i++;
      }else{
        listGenerals.add(_generalResponse.data[i].type);
      }
    }
    print(listGenerals);
    setState(() {
      _isLoading = false;
    });
  }
  _buildListEtablissements() {
    setState(() {
      _isLoading = true;
    });

    for (int i = 0; i < _etablissementResponse.data.length; i++) {
      if(listEtablissement.contains(_etablissementResponse.data[i].type)){
        i++;
      }else{
        listEtablissement.add(_etablissementResponse.data[i].type);
      }
    }
    print(listEtablissement);
    setState(() {
      _isLoading = false;
    });
  }
}
