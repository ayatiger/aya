import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/colors.dart';
import '../constants/components.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CallWidget extends StatelessWidget {
  const CallWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Emergency call',
                  style: mainTextStyle(context, color: black),
                ),
                Lottie.asset('assets/lotties/call.json'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final Uri url = Uri(scheme: 'tel', path: "01141560783");
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          debugPrint('can not launch');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: defaultColor,
                        padding: const EdgeInsets.symmetric(horizontal: 66),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: Size(screenWidth(context, .1),
                            screenHeight(context, .06)),
                      ),
                      child: Icon(
                        Icons.call_outlined,
                        color: white,
                      ),
                    ),
                    const SizedBox(width: 5),
                    ElevatedButton(
                      onPressed: launchWhatsApp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(0, 217, 95, 1),
                        padding: const EdgeInsets.symmetric(horizontal: 66),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: Size(screenWidth(context, .1),
                            screenHeight(context, .06)),
                      ),
                      child: const Icon(
                        MdiIcons.whatsapp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height:20),
                GestureDetector(
                  onTap: () async {
                    final Uri url = Uri(scheme: 'mailto', path: "aya_n91486@cic-cairo.com");
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      debugPrint('can not launch');
                    }
                  },
                  child: const Icon(
                    Icons.email,
                    color: Color.fromRGBO(0, 155, 155, 1.0),
                    size: 100,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void launchWhatsApp() async {
  String url = "whatsapp://send?phone=+201141560783&text=aya, help me%2C%20please!";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
