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
  List checkedDB = List();
  APIResponse<List<Ambiance>> _ambianceResponse;
  List<String> listAmbiances = [];
  AmbianceServices get ambianceService => GetIt.I<AmbianceServices>();
  var items = [];

  @override
  void initState() {
    print(widget.restaurantId);
    getAmbiance();
    super.initState();
  }

  getAmbiance() async {
    _ambianceResponse = await ambianceService
        .getRestaurantsListAmbiance(widget.restaurantId.toString());
    buildListAmbiances();
  }

  buildListAmbiances() {
    for (int i = 0; i < _ambianceResponse.data.length; i++) {
      listAmbiances.add(_ambianceResponse.data[i].type);
    }
    print(listAmbiances);

    return listAmbiances;
  }

  getSelectedItemsFromDB() {
    for (int i = 0; i < ListAmbianceExisted.length; i++) {
      for (int j = 0; j < listAmbiances.length; j++) {
        if (listAmbiances[j].toLowerCase() ==
            ListAmbianceExisted[i].toLowerCase()) {
          items.add(ListAmbianceExisted[j]);
        }
      }
    }
    return items;
  }

  // void _onCategorySelected(bool selected, ambiance_type) {
  //   checkedDB = getSelectedItemsFromDB();
  //   if (selected == true) {
  //     setState(() {
  //       checkedDB.add(ambiance_type);
  //     });
  //   } else {
  //     setState(() {
  //       checkedDB.remove(ambiance_type);
  //     });
  //   }
  // }

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
                    onPressed: (){
                      insertAmbiance();
                    },
                      child: Text('Autre',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              decoration: TextDecoration.underline))),
                ],
              ),
            ),
            // Container(
            //   height: 500,
            //   child: ListView.builder(
            //       itemCount: text.length,
            //       itemBuilder: (BuildContext context, int index) {
            //         return CheckboxListTile(
            //           value:checkedDB
            //             .contains(text[index]),
            //           onChanged: (bool selected) {
            //             setState(() {
            //               print(text[index]);
            //               _onCategorySelected(selected,
            //                   text[index]);
            //             });
            //           },
            //           title: Text(text[index]),
            //         );
            //       }),
            // )
            CheckboxGroup(
                labels: text,
                //checked: getSelectedItemsFromDB(),
                // onChange: (bool isChecked, String label, int index) {
                //   setState(() {
                //    // print(text[index]);
                //     _onCategorySelected(isChecked, items[index]);
                //   });
                // },
                labelStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                onSelected: (List<String> checked) {
                  items
                  = checked;

                }
              ),
          ],
        ),
      ),
    );
  }



  insertAmbiance(){
    items.forEach((element) { 
      ambianceService.addAmbiance(element);
    });
  }
//   List<LabeledCheckbox> _createList(List list){
//     return List.generate(list.length, (index) => LabeledCheckbox(
//       label: list[index],
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             value: _isSelected,
//             onChanged: (bool newValue,index) {
//               setState(() {
//                 _isSelected = newValue;
//               });
//             },
//           ),
//   );
// }
}
