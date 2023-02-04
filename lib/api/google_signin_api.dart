import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn(
      clientId:
          "213471695827-v9b2us49iqcfepdu7b1fsoria9ncj5lf.apps.googleusercontent.com");

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  static Future  logout ()async{
      await _googleSignIn.disconnect();

   } 
   
    
}
