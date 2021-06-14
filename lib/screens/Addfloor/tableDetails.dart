import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:tawelti/models/table.dart';
import 'package:tawelti/services/table.services.dart';

import '../../constants.dart';


class DetailsTable extends StatefulWidget {
  final int tableCode;
  final int zoneId;
  final String tableId;
  DetailsTable({this.tableId,this.tableCode,this.zoneId});
  @override
  _DetailsTableState createState() => _DetailsTableState();
}

class _DetailsTableState extends State<DetailsTable> {
  int _etat = 0;
  int _counterCouvert = 0;
  int _counterTolerance = 0;
  bool get isEditing => widget.tableId != null;
  TableServices get tablesService => GetIt.I<TableServices>();
  String errorMessage;
  RestaurantTable table;
  bool _isLoading= false;
  bool _isEnabled =false;
  String _picked = "available";

  // TextEditingController _nameController = TextEditingController();
  // TextEditingController _descriptionController = TextEditingController();
  // TextEditingController _categoryController = TextEditingController();
  // TextEditingController _startController = TextEditingController();
  // TextEditingController _endController = TextEditingController();
  void initState() {
    print(widget.tableId);
    super.initState();

    if (isEditing) {
      setState(() {
        _isLoading = true;
      });
      tablesService.getTable(widget.tableId.toString()).then((response) {

        table= response.data;
        print(table);
        print(table.nbCouverts);
        print(table.tolerance);
        _counterCouvert=table.nbCouverts;
        _counterTolerance=table.tolerance;
        _etat=table.etat;
        switch (_etat) {
          case 0:
            _picked='available';
            break;
          case 1:
            _picked='reserved';
            break;
          case -1:
            _picked='blocked';
            break;
          default:
            _picked='available';
        }
        setState(() {
          _isLoading = false;
        });

        if (response.error) {
          errorMessage = response.errorMessage ?? 'An error occurred';
        }



      });
    }

    super.initState();
  }



  void _incrementCounterCouvert() {
    setState(() {
      _counterCouvert++;
    });
  }

 void _decrementCounterCouvert() {
    setState(() {
      _counterCouvert--;
    });
  }

  void _incrementCounterTolerance() {
    setState(() {
      _counterTolerance++;
    });
  }

  void _decrementCounterTolerance() {
    setState(() {
      _counterTolerance--;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Color(0xf6f6f6),
          iconTheme: IconThemeData(
            color: KBlue,
          ),
          leading: Icon(CupertinoIcons.arrow_left),
          title: Text(
            'Table Details',
            style: TextStyle(color: Colors.black87, fontSize: 24),
          ),
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height * 0.08),
            child: Divider(
              thickness: 2,
              color: KBeige,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding:             const EdgeInsets.symmetric(horizontal: 25, vertical: 8),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'table cultery',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black87),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$_counterCouvert',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              child: Icon(
                                Icons.arrow_drop_up,
                                size: 30,
                                color: KBlue,
                              ),
                              onTap: _incrementCounterCouvert,
                            ),
                            GestureDetector(
                              child: Icon(
                                Icons.arrow_drop_down,
                                size: 30,
                                color: KBlue,
                              ),
                              onTap: _decrementCounterCouvert,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Status',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RadioButtonGroup(
                  onSelected: (String selected) => setState((){
                    _picked = selected;
                  }),
                  picked: _picked,
                  labels: [
                    'blocked',
                    'available',
                    'reserved'
                  ],
                  labelStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  activeColor: KBlue,
                ),
              ],
            ),
          ),
          Padding(
            padding:             const EdgeInsets.symmetric(horizontal: 25, vertical: 8),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'table tolerance',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black87),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$_counterTolerance',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              child: Icon(
                                Icons.arrow_drop_up,
                                size: 30,
                                color: KBlue,
                              ),
                              onTap: _incrementCounterTolerance,
                            ),
                            GestureDetector(
                              child: Icon(
                                Icons.arrow_drop_down,
                                size: 30,
                                color: KBlue,
                              ),
                              onTap: _decrementCounterTolerance,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: FlatButton(
              onPressed: () async{
                setState(() {
                  _isLoading = true;
                });
                final table = RestaurantTable(
                  nbCouverts: _counterCouvert,
                  tolerance: _counterTolerance,
                  etat: getState(),
                  code: widget.tableCode,
                  zoneId: widget.zoneId,
                  //createdAt: _startController.text,
                );
                print(table.nbCouverts);
                print(table.etat);
                print(table.tolerance);
                final result = await tablesService.updateTable(widget.tableId.toString(), table);
                setState(() {
                  _isLoading = false;
                });

                final title = 'Done';
                final text = 'Your table was updated';

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
                    )
                );
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
                          'Submit',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
 int getState(){
   switch (_picked) {
     case 'available':
       return 0;
       break;
     case 'reserved':
       return 1;
       break;
     case 'blocked':
       return -1;
       break;
   }
 }

}
