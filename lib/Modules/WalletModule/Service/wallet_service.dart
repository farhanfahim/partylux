import 'package:partylux/Modules/WalletModule/Model/wallet_model.dart';
import 'package:partylux/Utils/Network/api_client.dart';
import 'package:partylux/Utils/Network/api_urls.dart';
import 'package:partylux/Utils/Network/tost.dart';

mixin WalletService {
  Future<MyWalletModel> getWallet() async {
    MyWalletModel wallet = await MyWalletModel.fromEmpty();

    try {
      var response = await API().get(ApiManager.MY_WALLET);

      print("response MY_WALLET Here -->> $response");
      if (response == null) {
      } else if (response.statusCode == 200) {
        wallet = MyWalletModel.fromJson(response.data["data"]);
      } else {
       // Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return wallet;
  }
}
