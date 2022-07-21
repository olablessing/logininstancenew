import 'package:get/get.dart';
import 'package:logininstance/app/data/global.dart';
import 'package:logininstance/app/models/intagrammedia.dart';
import 'package:logininstance/network.dart';

class HomeController extends GetxController {
  var fetching = false.obs;

  List<InstagramPostModel> instagramposts = [];

  //TODO: Implement HomeController

  void getIntagramPosts() async {
    fetching.value = true;

    HttpRequest(
      'https://graph.instagram.com/me/media?fields=id,caption,media_type,media_url,thumnail_url&access_token=${token}',
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      onSuccess: (resp, result) {
        print('sucessfully fetched instagram posts');
        print(resp.body['data']);

        var jsonString = resp.body['data'];

        List<InstagramPostModel> postlist = jsonString
            .map<InstagramPostModel>((e) => InstagramPostModel.fromJson(e))
            .toList();
        // box.write('wallets', walletlist);
        // print(resp.statusCode);
        // print(resp.body['countries']);
        fetching.value = false;

        instagramposts = postlist;

        // countrydata.assignAll(countrylist);
        update(['posts']);
      },
    ).send();
  }

  final count = 0.obs;
  @override
  void onInit() {
    getIntagramPosts();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
