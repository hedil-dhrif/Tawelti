import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/widgets/CuisineItem.dart';


List <String> ListGeneral = [
  'Ranking',
  'Reservation required',
  'Fuming',
  'children Area',
  'meal tickets',
  'animals',
  'alcohol',
  'shisha',
  'OpenAir',
  'Indoor',
  'wifi',
  'Karaoke',
];


class GetGeneralCategory extends StatefulWidget {
  @override
  GetGeneralCategoryState createState() {
    return new GetGeneralCategoryState();
  }
}

class GetGeneralCategoryState extends State<GetGeneralCategory> {
  List<String> text = ListGeneral;
  bool _isSelected=false;

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
                  Text('General',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: KBlue),),
                  TextButton( child: Text('Autre',style: TextStyle(fontSize: 20, color: Colors.black,decoration: TextDecoration.underline))),
                ],
              ),
            ),
            CheckboxGroup(
                labels: text,
                labelStyle: TextStyle(fontSize: 18, color: Colors.black,),
                onSelected: (List<String> checked) => print(checked.toString())
            ),
          ],
        ),
      ),
    );
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
