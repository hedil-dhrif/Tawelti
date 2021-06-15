import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get_it/get_it.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:tawelti/api/api_Response.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/models/ambiance.dart';
import 'package:tawelti/services/ambiance.services.dart';
import 'package:tawelti/services/restaurant.services.dart';
import 'package:tawelti/widgets/CuisineItem.dart';
import 'package:group_button/group_button.dart';

List<String> ListAmbianceExisted = [
  'Festive',
  'Romantique',
  'Business',
  'Family',
];

class GetAmbianceCategory extends StatefulWidget {
  final int restaurantId;
  GetAmbianceCategory({this.restaurantId});
  @override
  GetAmbianceCategoryState createState() {
    return new GetAmbianceCategoryState();
  }
}

class GetAmbianceCategoryState extends State<GetAmbianceCategory> {
  List<String> text = ListAmbianceExisted;
  bool _isSelected = false;
  List<String> checkedDB = [];
  APIResponse<List<Ambiance>> _ambianceResponse;
  final List<String> listAmbiances = [];
  AmbianceServices get ambianceService => GetIt.I<AmbianceServices>();
  bool _isLoading = true;

  @override
  void initState() {
    print(widget.restaurantId);
    _fetchAmbiances();
    super.initState();
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

  _buildListAmbiances() {
    setState(() {
      _isLoading = true;
    });

    for (int i = 0; i < _ambianceResponse.data.length; i++) {
      listAmbiances.add(_ambianceResponse.data[i].type);
    }
    setState(() {
      _isLoading = false;
    });
  }

  _getSelectedItemsFromDB(list) {
    final List<int> items = [];
    //listAmbianceDB=await _buildListAmbiances();
    for (int i = 0; i < ListAmbianceExisted.length; i++) {
      for (int j = 0; j < list.length; j++) {
        if (list[j].toLowerCase() == ListAmbianceExisted[i].toLowerCase()) {
          items.add(i);
        }
      }
    }
    print(items);
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ambiance',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: KBlue),
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _getSelectedItemsFromDB(listAmbiances);
                        });
                      },
                      child: Text('Autre',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              decoration: TextDecoration.underline))),
                ],
              ),
            ),
            GroupButton(
              spacing: 5,
              isRadio: false,
              direction: Axis.horizontal,
              onSelected: (index, isSelected) {
                _addItem(index);
              },
              buttons: text,
              selectedButtons: _getSelectedItemsFromDB(listAmbiances),

              /// [List<int>] after 2.2.1 version
              selectedTextStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: KBlue,
              ),
              unselectedTextStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.grey[600],
              ),
              selectedColor: Colors.white,
              unselectedColor: Colors.grey[300],
              selectedBorderColor: KBlue,
              unselectedBorderColor: Colors.grey[500],
              borderRadius: BorderRadius.circular(15.0),
              selectedShadow: <BoxShadow>[BoxShadow(color: Colors.transparent)],
              unselectedShadow: <BoxShadow>[
                BoxShadow(color: Colors.transparent)
              ],
            )
          ],
        ),
      ),
    );
  }
_addItem(int i) async{
  setState(() {
    _isLoading = true;
  });
       final item=Ambiance(
        type: text[i],
        restaurantId: widget.restaurantId,
      );
  final result = await ambianceService.addAmbiance(item);
  setState(() {
    _isLoading = false;
  });
}
}
