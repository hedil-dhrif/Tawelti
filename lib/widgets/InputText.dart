import 'package:flutter/material.dart';
import 'package:tawelti/constants.dart';


class InputText extends StatefulWidget {
  final String label;
  final String inputHint;
  final TextEditingController controller;
  final bool enabled;

  InputText({this.label,this.inputHint,this.controller,this.enabled});
  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(widget.label,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: KBlue),),
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xffE5E5E5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  enabled: widget.enabled,
                  controller: widget.controller,
          decoration: InputDecoration(
          border: UnderlineInputBorder(
                  borderSide: BorderSide.none,
          ),
          hintText: widget.inputHint,
          hintStyle: TextStyle(fontSize: 20, color: Colors.black,)
          ),
          ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
