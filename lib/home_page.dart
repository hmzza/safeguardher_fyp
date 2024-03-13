import 'package:flutter/material.dart';
import 'package:safeguardher/SOSGeneration.dart';
import 'package:safeguardher/fakecall_mainpage.dart';
import 'package:safeguardher/threatDetection_mainPage.dart';
import 'package:safeguardher/utils/carousel_cards.dart';
import 'package:safeguardher/utils/custom_app_bar.dart';

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'Hi Saba!'),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backgroundlogin.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Row(
                children: [
                  Flexible(
                    flex: 2, // Adjust flex factor for carousel height
                    child: CarouselCards(),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  featureItem(
                    context: context,
                    image: 'assets/images/threatdetection.png',
                    label: 'Threat Detection',
                    onTap: () =>
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  AudioRecorderUploader()),
                        ),
                    height: 210,
                    width: 230
                    // flex: 3, // Larger flex factor for "Threat Detection"
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  featureItem(
                    context: context,
                    image: 'assets/images/fakecall.png',
                    label: 'Fake Call',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => fakecallmainpage()),
                    ),
                    // flex: 3,
                  ),
                  featureItem(
                    context: context,
                    image: 'assets/images/sos.png',
                    label: 'SOS Alert',
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SOSGeneration()),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget featureItem({
    required BuildContext context,
    required String image,
    required String label,
    required VoidCallback onTap,
    double height = 200,
    double width = 200,
    int flex = 1, // Default flex is 1
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: flex, // Use the flex factor to control size
              child: Container(
                width: double.infinity, // Container should fill the width
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
