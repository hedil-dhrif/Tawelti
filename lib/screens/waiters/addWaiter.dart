import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tawelti/models/waiter.dart';
import 'package:tawelti/screens/waiters/WaiterList.dart';
import 'package:tawelti/constants.dart';
import 'package:tawelti/services/waiter.services.dart';

class AddWaiter extends StatefulWidget {
  final int restaurantID;
  final int waiterId;
  AddWaiter({this.waiterId, this.restaurantID});
  @override
  _AddWaiterState createState() => _AddWaiterState();
}

class _AddWaiterState extends State<AddWaiter> {
  bool get isEditing => widget.waiterId != null;
  WaiterServices get waitersService => GetIt.I<WaiterServices>();
  String errorMessage;
  Waiter waiter;
  bool _isLoading = false;
  DateTime _datetime;
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _adresseController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  String valueChoose;
  bool _validate = false;
  List listItem = [
    '1st Floor',
    '2nd floor',
    '3rd floor',
    '4th floor',
  ];
  @override
  void initState() {
    super.initState();

    if (isEditing) {
      setState(() {
        _isLoading = true;
      });
      waitersService.getWaiter(widget.waiterId.toString()).then((response) {
        setState(() {
          _isLoading = false;
        });

        if (response.error) {
          errorMessage = response.errorMessage ?? 'An error occurred';
        }
        waiter = response.data;
        print(waiter);
        _firstnameController.text = waiter.nom;
        _lastnameController.text = waiter.prenom;
        _adresseController.text = waiter.adresse;
        _phoneController.text = waiter.telephone;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Color(0xf6f6f6),
          iconTheme: IconThemeData(
            color: KBlue,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(CupertinoIcons.arrow_left),
          ),
          title: Center(
            child: Text(
              'Add Waiter',
              style: TextStyle(
                  fontSize: 25,
                  color: KBlue,
                  fontFamily: 'ProductSans',
                  letterSpacing: 1,
                  fontWeight: FontWeight.w100),
            ),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'first name',
                      style: TextStyle(
                        fontSize: 20,
                        color: KBlue,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: KBlue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          controller: _firstnameController,
                          decoration: InputDecoration(
                            errorText: _validate
                                ? 'Value Can\'t Be Empty'
                                : null,
                            border: InputBorder.none,
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'last name',
                      style: TextStyle(
                        fontSize: 20,
                        color: KBlue,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: KBlue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          controller: _lastnameController,
                          decoration: InputDecoration(
                            errorText: _validate
                                ? 'Value Can\'t Be Empty'
                                : null,
                            border: InputBorder.none,
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Adresse',
                      style: TextStyle(
                        fontSize: 20,
                        color: KBlue,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: KBlue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          controller: _adresseController,
                          decoration: InputDecoration(
                            errorText: _validate
                                ? 'Value Can\'t Be Empty'
                                : null,
                            border: InputBorder.none,
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'phone number',
                      style: TextStyle(
                        fontSize: 20,
                        color: KBlue,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: KBlue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            errorText: _validate
                                ? 'Value Can\'t Be Empty'
                                : null,
                            border: InputBorder.none,
                          ),
                        )),
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          _adresseController.text.isEmpty ? _validate = true : _validate = false;
                          _phoneController.text.isEmpty ? _validate = true : _validate = false;
                          _lastnameController.text.isEmpty ? _validate = true : _validate = false;
                          _firstnameController.text.isEmpty ? _validate = true : _validate = false;
                          _isLoading = true;
                        });
                        final waiter = Waiter(
                          restaurantId: widget.restaurantID,
                          nom: _firstnameController.text,
                          prenom: _lastnameController.text,
                          adresse: _adresseController.text,
                          telephone: _phoneController.text,
                        );
                        print(waiter.telephone);
                        print(waiter.nom);
                        print(waiter.prenom);
                        print(waiter.adresse);
                        final result =
                            await waitersService.createWaiter(waiter);

                        setState(() {
                          _isLoading = false;
                        });

                        final title = 'Done';
                        final text ='Your waiter was created';

                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: Text(title),
                                  content: Text(text),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('Ok'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ));
                      },
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.07,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: KBlue,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              'add waiter',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: KBackgroundColor,
                                  letterSpacing: 2),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
