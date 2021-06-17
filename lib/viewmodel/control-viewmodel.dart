
import 'package:postboard/service/authenticator.dart';

class ControlViewModel
{
  Stream<bool> get isSignedIn => Authenticator.isSignedIn;

  dispose()
  {

  }
}