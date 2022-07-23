import 'package:electro_market/modules/login/shop_login_screen.dart';
import 'package:electro_market/shared/components/components.dart';
import 'package:electro_market/shared/netwok/local/cache_helper.dart';
import 'package:electro_market/shared/styles/colors.dart';
import 'package:electro_market/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  var boardingController = PageController();
  List<BoardingModel> boarding = [
    BoardingModel(
        'assets/images/onboard2.png', 'onboard1 title', 'onboard1 body'),
    BoardingModel(
        'assets/images/onboard2.png', 'onboard2 title', 'onboard2 body'),
    BoardingModel(
        'assets/images/onboard1.png', 'onboard3 title', 'onboard3 body'),
  ];

  bool isLast = false;

  void submit(context) {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      print(value);
      if (value) {
        navigateWithNoBack(context, ShopLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            onPressed: (){
              submit(context);
            },
            text: 'SKIP',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) {
                  if (value == boarding.length - 1) {
                    isLast = true;
                  } else {
                    isLast = false;
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: boardingController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardingController,
                    effect: ExpandingDotsEffect(
                      activeDotColor: defaultColor,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5,
                    ),
                    count: boarding.length),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit(context);
                    } else {
                      boardingController.nextPage(
                        duration: Duration(milliseconds: 800),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(model.image),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            model.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            model.body,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          //PageView.builder(itemBuilder: ()))
        ],
      );
}
