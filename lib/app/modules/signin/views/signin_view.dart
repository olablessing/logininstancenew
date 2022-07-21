import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logininstance/app/modules/signin/views/instagram_view.dart';
import 'package:snapkit/snapkit.dart';

import '../controllers/signin_controller.dart';

class SigninView extends StatefulWidget {
  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  SigninController controller = Get.put(SigninController());

    GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();


  String _platformVersion = 'Unknown';
  SnapchatUser? _snapchatUser;
  Snapkit _snapkit = Snapkit();

  TextEditingController _regionController = TextEditingController(text: 'US');
  TextEditingController _phoneController =
      TextEditingController(text: '0001234567');

  late StreamSubscription<SnapchatUser?> subscription;

  bool _isSnackOpen = false;
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await Snapkit.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> loginUser() async {
    try {
      bool installed = await _snapkit.isSnapchatInstalled;
      if (installed)
        await _snapkit.login();
      else if (!_isSnackOpen) {
        _isSnackOpen = true;
        _scaffoldMessengerKey.currentState!
            .showSnackBar(
                SnackBar(content: Text('Snapchat App not Installed.')))
            .closed
            .then((_) {
          _isSnackOpen = false;
        });
      }
    } on PlatformException catch (exception) {
      print(exception);
    }
  }

  Future<void> logoutUser() async {
    try {
      await _snapkit.logout();
    } on PlatformException catch (exception) {
      print(exception);
    }

    setState(() {
      _snapchatUser = null;
    });
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();

    // _snapkit.addAuthStateListener(this);

    subscription = _snapkit.onAuthStateChanged.listen((SnapchatUser? user) {
      setState(() {
        _snapchatUser = user;
      });
    });
  }





  @override
  Widget build(BuildContext context) {
    Widget _submitButton() {
      return InkWell(
        onTap: () {
     loginUser();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color(0xffdf8e33).withAlpha(100),
                    offset: Offset(2, 4),
                    blurRadius: 8,
                    spreadRadius: 2)
              ],
              color: Colors.white),
          child: Text(
            'Login with SnapChat',
            style: TextStyle(fontSize: 20, color: Color(0xfff7892b)),
          ),
        ),
      );
    }

    Widget _signUpButton() {
      return InkWell(
        onTap: () {
          Get.to(() => InstagramView());
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Text(
            'Login with Instagram',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      );
    }

    Widget _title() {
      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'd',
            style: GoogleFonts.nunito(
              textStyle: Theme.of(context).textTheme.headline1,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            children: [
              TextSpan(
                text: 'insta',
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
              TextSpan(
                text: 'Snap',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ]),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xfffbb448), Color(0xffe46b10)])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _title(),
              SizedBox(
                height: 80,
              ),
              _submitButton(),
              SizedBox(
                height: 20,
              ),
              _signUpButton(),
              SizedBox(
                height: 20,
              ),
              // _label()
            ],
          ),
        ),
      ),
    );
  }
}
