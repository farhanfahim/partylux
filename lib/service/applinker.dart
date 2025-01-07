import 'dart:async';
import 'package:uni_links/uni_links.dart';

class Applinker {

  static Applinker? _instance;

  StreamSubscription? _sub;
  DeepLinkHandler? _handler;

  Applinker._();

  factory Applinker(){
    return _instance??=Applinker._();
  }

  void startLinkStream(DeepLinkHandler handler){
    print("link stream started");
    _handler=handler;
    _sub = linkStream.listen((String? link) {
        print("unilink is: $link");
        if(link!=null) {
          _handler!.onLinkTap(link);
        }
    }, onError: (err) {
      print("unilink error is: $err");
    });
  }

  Future<String?> getLink(){
    return getInitialLink();
  }

  void cancelLinkStream(){
    _sub?.cancel();
    _handler=null;
  }



}

abstract class DeepLinkHandler{
  void onLinkTap(String link);
}