import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/widgets/CuisineItem.dart';


List <String> ListBudget = [
  '\$',
  '\$\$',
  '\$\$\$',
];


class GetBudget extends StatefulWidget {
  @override
  GetBudgetState createState() {
    return new GetBudgetState();
  }
}

class GetBudgetState extends State<GetBudget> {
  List<String> text = ListBudget;
  bool _isSelected=false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Budget',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: KBlue),),
                ],
              ),
            ),
            CheckboxGroup(
              orientation: GroupedButtonsOrientation.HORIZONTAL,
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
