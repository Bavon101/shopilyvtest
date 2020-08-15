import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopapp/pages/homepage.dart';
import 'package:shopapp/widgets/LoadDialog.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  logToFirebase fireLog = new logToFirebase();
  _login() async{
    try{
      Dialogs.showLoadingDialog(context, _keyLoader);
      await _googleSignIn.signIn();
      // UserDetails userDetails = new UserDetails(_googleSignIn.currentUser.displayName, _googleSignIn.currentUser.photoUrl, _googleSignIn.currentUser.email,promoCode,userId);
      //print(userDetails.userName);
      dynamic results = await fireLog.SignInAnn();
      if(results == null){
        print("Error logging user");

      }else{
        ///loguser
        try{
          DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child('userData');
          databaseReference.orderByChild('mail').startAt(_googleSignIn.currentUser.email.toString().trim()).endAt(_googleSignIn.currentUser.email.toString().trim() +"\uf8ff").limitToFirst(1).once()
              .then((DataSnapshot snap) async {
            var Keys = snap.value.keys;
            var Data = snap.value;
            for(var byKey in Keys){
              if (Data[byKey]['mail'].toString().compareTo(_googleSignIn.currentUser.email) == 0) {
                String userId = Data[byKey]['id'];
                String userCode = Data[byKey]['code'];
                UserDetails _user = new UserDetails(
                    _googleSignIn.currentUser.displayName, _googleSignIn.currentUser.photoUrl,
                    _googleSignIn.currentUser.email);
                Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
                Fluttertoast.showToast(
                  backgroundColor: Colors.grey[700],
                  textColor: Colors.white,
                  msg: "welcome ${_user.userName}",
                  toastLength: Toast.LENGTH_SHORT,
                );

                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(_user)));


              }
            }
          }).catchError((e) async {
            print('ERROR $e');
            Fluttertoast.showToast(
              backgroundColor: Colors.grey[700],
              textColor: Colors.white,
              msg: "New User detected",
              toastLength: Toast.LENGTH_SHORT,
            );
            UserDetails _user = new UserDetails(
                _googleSignIn.currentUser.displayName, _googleSignIn.currentUser.photoUrl, _googleSignIn.currentUser.email,);
            ///add items to sql
            Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
            Fluttertoast.showToast(
              backgroundColor: Colors.grey[700],
              textColor: Colors.white,
              msg: "welcome ${_user.userName}",
              toastLength: Toast.LENGTH_SHORT,
            );

            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(_user)));

          });
        }catch(e){
        }



//        Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
//        Navigate.goToHomeCompletely(context, userDetails);
      }
    } catch (err){
      print('Error in google sign in$err');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
       // mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*.50,),
          Center(child: Text("Welcome to Coffee Shop",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Shopilyv Code",
              style: TextStyle(
                decoration: TextDecoration.underline
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () => _login(),
              child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 30),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(25)
                  ),
                  child: Center(
                    child: Text("Sign in with Google",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}


class UserDetails{
  final String userName;
  final String photoUrl;
  final String userEmail;
  UserDetails(this.userName,this.photoUrl,this.userEmail);
  Map<String,dynamic> map(){
    var map = <String,dynamic>{
      'name':this.userName,
      'photo':this.photoUrl,
      'mail':this.userEmail,
    };
    return map;
  }
}


class logToFirebase{
//firebase auth
Future SignInAnn() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  try{
    AuthResult result = await auth.signInAnonymously();
    FirebaseUser user = result.user;
    return user;
  }catch(e){
    print(e.toString());
    return null;
  }
}
}