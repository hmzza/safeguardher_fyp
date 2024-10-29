// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safeguardher/utils/custom_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpAndSupport extends StatefulWidget {
  const HelpAndSupport({super.key});

  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
  void _launchMailto(String email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
    );
    String url = params.toString();
    if (await canLaunchUrl(params)) {
      await launchUrl(params);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'Help and Support'),
      body: Stack(
        children: <Widget>[
          // Background
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/darkbackground.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/logo.png', // Make sure this path is correct
                    width: MediaQuery.of(context).size.width * 0.5, // Adjust the size as needed
                    // height: can also be specified if necessary
                  ),
                ),
                ListTile(
                  title: Text('Hamza', style: TextStyle(color: Colors.white)),
                  subtitle: Text('hamza.cstn@gmail.com', style: TextStyle(color: Colors.grey)),
                  leading: Icon(Icons.account_circle, color: Colors.white),
                  trailing: IconButton(
                    icon: Icon(Icons.email, color: Colors.white),
                    onPressed: () => _launchMailto('hamza.cstn@gmail.com'),
                  ),
                ),
                ListTile(
                  title: Text('Phone Number', style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.phone, color: Colors.white),
                  trailing: IconButton(
                    icon: Icon(Icons.call, color: Colors.white),
                    onPressed: () => _makePhoneCall('03161439569'),
                  ),
                ),
                Divider(color: Colors.grey),
                ListTile(
                  title: Text('Saba Karim', style: TextStyle(color: Colors.white)),
                  subtitle: Text('saba.karim@gmail.com', style: TextStyle(color: Colors.grey)),
                  leading: Icon(Icons.account_circle, color: Colors.white),
                  trailing: IconButton(
                    icon: Icon(Icons.email, color: Colors.white),
                    onPressed: () => _launchMailto('saba.karim@gmail.com'),
                  ),
                ),
                ListTile(
                  title: Text('Phone Number', style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.phone, color: Colors.white),
                  trailing: IconButton(
                    icon: Icon(Icons.call, color: Colors.white),
                    onPressed: () => _makePhoneCall('03221439568'),
                  ),
                ),
                Divider(color: Colors.grey),
                ListTile(
                  title: Text('Hamza Jadoon', style: TextStyle(color: Colors.white)),
                  subtitle: Text('hamza.jadoon@gmail.com', style: TextStyle(color: Colors.grey)),
                  leading: Icon(Icons.account_circle, color: Colors.white),
                  trailing: IconButton(
                    icon: Icon(Icons.email, color: Colors.white),
                    onPressed: () => _launchMailto('hamza.jadoon@gmail.com'),
                  ),
                ),
                ListTile(
                  title: Text('Phone Number', style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.phone, color: Colors.white),
                  trailing: IconButton(
                    icon: Icon(Icons.call, color: Colors.white),
                    onPressed: () => _makePhoneCall('03165896525'),
                  ),
                ),

                // More items can be added here
              ],
            ),
          ),
        ],
      ),
    );
  }
}
