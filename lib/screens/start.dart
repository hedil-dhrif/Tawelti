import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawelti/screens/SignUpPage.dart';
class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Color(0xFF1C3956), BlendMode.dstATop),
              image: ExactAssetImage('assets/background-01.png'),
              fit: BoxFit.cover),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 100),
          child: Column(
            children: [
              GestureDetector(
                child: Container(
                  height: MediaQuery.of(context).size.height*0.08,
                  width: MediaQuery.of(context).size.width*0.8,
                  decoration: BoxDecoration(
                    color: Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Image.asset(
                            'assets/google.png',
                          width:  MediaQuery.of(context).size.width*0.15,
                          height:  MediaQuery.of(context).size.height*0.8,
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width*0.04,),
                        Text(
                          'SignUp with google',
                          style: TextStyle(
                            fontSize: 25
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignUpPage()));
                },
                child: Container(
                  height: MediaQuery.of(context).size.height*0.08,
                  width: MediaQuery.of(context).size.width*0.8,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1 , color: Color(0xFFAF8F61)),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(
                            Icons.alternate_email,
                          color: Color(0xFFAF8F61),
                          size: MediaQuery.of(context).size.height*0.06,
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width*0.04,),
                        Text(
                          'SignUp with email',
                          style: TextStyle(
                              fontSize: 25,
                            color: Colors.white
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
