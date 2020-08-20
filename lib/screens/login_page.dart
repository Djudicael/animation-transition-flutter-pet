import 'package:flutter/material.dart';

import '../utils/animations/login_pager_animations.dart';
import 'home_page.dart';
import '../utils/pages_routes/fade_page_route.dart';

class AnimatedLoginPage extends StatefulWidget {
  @override
  _AnimatedLoginPageState createState() => _AnimatedLoginPageState();
}

class _AnimatedLoginPageState extends State<AnimatedLoginPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1),
        reverseDuration: Duration(microseconds: 400));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _LoginPage(_controller);
  }
}

class _LoginPage extends StatelessWidget {
  double _deviceHeight;
  double _deviceWidth;
  Color _primaryColor = Color.fromRGBO(125, 191, 211, 1.0);
  Color _secondaryColor = Color.fromRGBO(169, 234, 241, 1.0);
  AnimationController _controller;

  EnterAnimation _enterAnimation;

  _LoginPage(this._controller) {
    _enterAnimation = EnterAnimation(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery
        .of(context)
        .size
        .height;
    _deviceWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      backgroundColor: _primaryColor,
      body: Align(
        alignment: Alignment.center,
        child: Container(
          height: _deviceHeight * 0.60,
          width: _deviceWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _avatarWidget(),
              SizedBox(
                height: _deviceHeight * 0.05,
              ),
              _emailTextField(),
              _passwordTextField(),
              SizedBox(
                height: _deviceHeight * 0.10,
              ),
              _loginButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _avatarWidget() {
    double _circleD = _deviceHeight * 0.25;

    return AnimatedBuilder(
        animation: _enterAnimation.controller,
        builder: (BuildContext _contex, Widget _widget) {
          //print(_enterAnimation.circleSize);
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.diagonal3Values(_enterAnimation.circleSize.value,
                _enterAnimation.circleSize.value, 1),
            child: Container(
              height: _circleD,
              width: _circleD,
              decoration: BoxDecoration(
                color: _secondaryColor,
                borderRadius: BorderRadius.circular(500),
                image: DecorationImage(
                  image: AssetImage('assets/images/judi_avatar.jpg'),
                ),
              ),
            ),
          );
        });
  }

  Widget _emailTextField() {
    return Container(
      width: _deviceWidth * 0.70,
      child: TextField(
        cursorColor: Colors.white,
        autocorrect: false,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            hintText: "JoJo@boom.com",
            hintStyle: TextStyle(color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            )),
      ),
    );
  }

  Widget _passwordTextField() {
    return Container(
      width: _deviceWidth * 0.70,
      child: TextField(
        obscureText: true,
        cursorColor: Colors.white,
        autocorrect: false,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            hintText: "Password",
            hintStyle: TextStyle(color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            )),
      ),
    );
  }

  Widget _loginButton(BuildContext _context) {
    return MaterialButton(
      minWidth: _deviceWidth * 0.28,
      height: _deviceHeight * 0.060,
      color: Colors.white,
      child: Text(
        "LOG IN",
        style: TextStyle(
            fontSize: 16, color: _primaryColor, fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
          side: BorderSide(color: Colors.white)),
      onPressed: () async {
        await _controller.reverse();
        Navigator.pushReplacement(
            _context,
            FadePageRoute(AnimationHomePage(),) ,
        );
      },
    );
  }
}

//MaterialPageRoute(
//builder: (BuildContext _context) {
//return HomePage();
//},
//)
