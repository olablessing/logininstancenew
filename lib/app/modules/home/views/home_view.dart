import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logininstance/app/modules/signin/controllers/signin_controller.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  // const HomeView({Key? key}) : super(key: key);
  HomeController controller = Get.put(HomeController());
  SigninController logincontroller = Get.put(SigninController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF8F8FA),
        body: Obx(() {
          if (controller.fetching.value == true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.instagramposts.isNotEmpty) {
            return Column(
              children: [
                SizedBox(
                  height: size.height * 0.08,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          Text(
                            'Hi, ${logincontroller.instagramname}!',
                            style: GoogleFonts.nunito(
                                color: Colors.grey[800],
                                fontSize: 26,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    
                    ],
                  ),
                ),
                
                Text(
                  'Number of Posts ${controller.instagramposts.length}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                Wrap(
                  spacing: 1,
                  runSpacing: 1,
                  children:
                      List.generate(controller.instagramposts.length, (index) {
                    return Container(
                      width: (size.width - 3) / 3,
                      height: (size.width - 3) / 3,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(controller
                                  .instagramposts[index].mediaUrl
                                  .toString()),
                              fit: BoxFit.cover)),
                    );
                  }),
                )
              ],
            );
          } else {
            return const Center(
              child: Text('No Data'),
            );
          }
        }),
      ),
    );
  }
}
