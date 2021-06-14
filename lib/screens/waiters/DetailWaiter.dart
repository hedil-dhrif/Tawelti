import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tawelti/models/waiter.dart';
import 'package:tawelti/services/waiter.services.dart';
import 'package:tawelti/widgets/DisabledInputbox.dart';

import '../../constants.dart';
import 'WaiterList.dart';

class DetailWaiter extends StatefulWidget {
  final int waiterId;
  DetailWaiter({this.waiterId});
  @override
  _DetailWaiterState createState() => _DetailWaiterState();
}

class _DetailWaiterState extends State<DetailWaiter> {
  bool get isEditing => widget.waiterId != null;
  WaiterServices get waitersService => GetIt.I<WaiterServices>();
  String errorMessage;
  Waiter waiter;
  bool _isLoading = false;
  bool _isEnabled= false;
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _adresseController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

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
        _firstnameController.text=waiter.nom;
        _lastnameController.text=waiter.prenom;
        _adresseController.text=waiter.adresse;
        _phoneController.text=waiter.telephone;
      });
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: KBlue,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WaiterList()));
            },
            icon: Icon(CupertinoIcons.arrow_left),
          ),
          title: Center(
            child: Text(
              'Detail waiter',
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
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(right: 50),
                decoration: BoxDecoration(border: Border.all(color: Colors.black87),borderRadius: BorderRadius.circular(4)),
                child: IconButton(icon: Icon(Icons.edit), onPressed: (){
                  setState(() {
                    _isEnabled=!_isEnabled;

                  });
                }),
              ),
              DisabledInputBox(
                controller: _firstnameController,
                enabled: _isEnabled,
                label: 'First name: ',
                inputHint: 'XXXXX',
                color: KBlue,
              ),
              DisabledInputBox(
                enabled: _isEnabled,

                controller: _lastnameController,
                label: 'Last name: ',
                inputHint: 'XXXXX',
                color: KBlue,
              ),
              DisabledInputBox(
                enabled: _isEnabled,

                controller: _phoneController,
                label: 'Phone number: ',
                inputHint: 'XXXXX',
                color: KBlue,
              ),
              DisabledInputBox(
                enabled: _isEnabled,

                controller: _adresseController,
                label: 'Zone: ',
                inputHint: 'XXXXX',
                color: KBlue,
              ),
              _isEnabled?FlatButton(onPressed: () async{
                setState(() {
                  _isLoading = true;
                });
                final waiter = Waiter(
                  restaurantId: 33,
                  nom: _firstnameController.text,
                  prenom: _lastnameController.text,
                  adresse: _adresseController.text,
                  telephone: _phoneController.text,
                );
                final result = await waitersService.updateWaiter(widget.waiterId.toString(), waiter);

                setState(() {
                  _isLoading = false;
                });

                final title = 'Done';
                final text = 'Your Waiter was updated';

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

              }, child: Text('submit')):Container(),
            ],
          ),
        ),
      ),
    );
  }
}
