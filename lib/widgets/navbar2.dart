import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tawelti/widgets/roundedButton.dart';
import 'clipPath.dart';


enum TabItem { red, green, blue }

Map<TabItem, String> tabName = {
  TabItem.red: 'red',
  TabItem.green: 'green',
  TabItem.blue: 'blue',
};

Map<TabItem, MaterialColor> activeTabColor = {
  TabItem.red: Colors.red,
  TabItem.green: Colors.green,
  TabItem.blue: Colors.blue,
};
class BottomNavBarV2 extends StatefulWidget {
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final bgColor;
  final Color activeIconColor;
  final Color deactiveIconColor;
  final RoundedButton syncButton;
  BottomNavBarV2(
      {this.bgColor,
        this.currentTab, this.onSelectTab,
        this.activeIconColor,
        this.deactiveIconColor,
        this.syncButton});
  @override
  _BottomNavBarV2State createState() => _BottomNavBarV2State();
}

class _BottomNavBarV2State extends State<BottomNavBarV2> {
  int currentIndex = 0;

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          height: 60,
          child: Stack(
            overflow: Overflow.visible,
            children: [
              CustomPaint(
                size: Size(size.width, 80),
                painter: BNBCustomPainter(bgColor: widget.bgColor),
              ),
              widget.syncButton,
              Container(
                width: size.width,
                //height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(
                      'assets/floor-plan.svg',
                      color: Colors.white,
                      height: 32,
                      width: 32,
                    ),
                    SvgPicture.asset(
                      'assets/calendar-multiselect.svg',
                      color: Colors.white,
                      height: 32,
                      width: 32,
                    ),
                    Container(
                      width: size.width * 0.20,
                    ),
                  SvgPicture.asset(
                    'assets/cog-outline.svg',
                    color: Colors.white,
                    height: 32,
                    width: 32,
                  ),
                  SvgPicture.asset(
                    'assets/calendar-star.svg',
                    color: Colors.white,
                    height: 32,
                    width: 32,
                  ),

                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
