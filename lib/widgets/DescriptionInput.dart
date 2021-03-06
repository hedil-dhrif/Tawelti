import 'package:flutter/material.dart';
import 'package:tawelti/constants.dart';


class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({@required this.text});

  @override
  _DescriptionTextWidgetState createState() => new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String firstHalf;
  String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 50) {
      firstHalf = widget.text.substring(0, 50);
      secondHalf = widget.text.substring(50, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text('Description',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: KBlue),),
          ),
          new Container(
            decoration: BoxDecoration(
              color: Color(0xffE5E5E5),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: new EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: secondHalf.isEmpty
                ? new Text(firstHalf)
                : new Column(
              children: <Widget>[
                new Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf),style:  TextStyle(fontSize: 20, color: Colors.black,),),
                new InkWell(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Text(
                        flag ? "show more" : "show less",
                        style: new TextStyle(fontSize: 20, color: Colors.black54,decoration: TextDecoration.underline,decorationThickness: 2),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}