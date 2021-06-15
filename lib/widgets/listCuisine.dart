import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:group_button/group_button.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:tawelti/api/api_Response.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/models/Cuisine.dart';
import 'package:tawelti/services/cuisine.services.dart';
import 'package:tawelti/services/etablissement.services.dart';
import 'package:tawelti/widgets/CuisineItem.dart';


List <String> ListCuisine = [
  'Cuisine Tunisienne',
  'Cuisine Mexicaine',
  'Cuisine italienne',
  'Cuisine française',
];


class GetCuisineCategory extends StatefulWidget {
  final int restaurantID;
  GetCuisineCategory({this.restaurantID});
  @override
  GetCuisineCategoryState createState() {
    return new GetCuisineCategoryState();
  }
}

class GetCuisineCategoryState extends State<GetCuisineCategory> {
  List<String> text = ListCuisine;
  bool _isSelected=false;
  APIResponse<List<Cuisine>> _etablissementResponse;
  final List<String> listAmbiances = [];
  CuisineServices get cuisineService => GetIt.I<CuisineServices>();
  bool _isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Cuisine',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: KBlue),),
                  TextButton( child: Text('Autre',style: TextStyle(fontSize: 20, color: Colors.black,decoration: TextDecoration.underline))),
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
              //selectedButtons: _getSelectedItemsFromDB(listAmbiances),

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
    final item=Cuisine(
      type: text[i],
      restaurantId: widget.restaurantID,
    );
    final result = await cuisineService.addCuisine(item);
    setState(() {
      _isLoading = false;
    });
  }
}
