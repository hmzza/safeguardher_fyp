import 'package:flutter/material.dart';
import 'package:safeguardher/utils/custom_app_bar.dart';

class Guide extends StatefulWidget {
  const Guide({super.key});

  @override
  State<Guide> createState() => _GuideState();
}

class _GuideState extends State<Guide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'User Manual'),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/darkbgwithfade.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                guideSection(
                  icon: Icons.info_outline,
                  title: 'Getting Started',
                  content: 'The setup of the app requires you to set your email and password for authentication. You can modify you name, password and other features '
                      'later in the settings of the app',
                ),
                Divider(color: Color(0xFFF8B4CA)),
                guideSection(
                  icon: Icons.security,
                  title: 'Safety Features',
                  content: 'You are required to record your voice ideally in a quite environment with least disturbances. This is to perform user identification when you use the '
                      'safety key word: "Safeguard help" to activate the emergency actions. The app performs automatics environment analysis of scream and hate speech detection to '
                      'generate threat and activate safety features',
                ),
                Divider(color: Color(0xFFF8B4CA)),
                guideSection(
                  icon: Icons.settings,
                  title: 'App Settings & Configuration',
                  content: 'Under the Contacts tab in the nav bar, you have to set your emergency contacts as part of the set up of the '
                      'app. These contacts will be notified with an SOS message and your current location incase threat detected.',
                ),
                Divider(color: Color(0xFFF8B4CA)),
                guideSection(
                  icon: Icons.update,
                  title: 'Updating the App',
                  content: 'Make sure to check your emergency contacts and keep those who you are sure will respond for your safety.',
                ),
                Divider(color: Color(0xFFF8B4CA)),
                guideSection(
                  icon: Icons.help_outline,
                  title: 'FAQs & Troubleshooting',
                  content: 'The app is perfection itself. Make sure to allow audio analysis when ever you are travelling or feel like you need it otherwise the app will not perform automatic threat detection.',
                ),
                // Add more sections as needed
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget guideSection({required IconData icon, required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Color(0xFFF54184), size: 24), // Smaller icon size
              SizedBox(width: 10),
              Expanded( // To prevent overflow, wrap the title in an Expanded widget
                child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)), // Reduced font size and changed text color to white
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(content, style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.9))), // Reduced font size and changed text color to white for better readability
        ],
      ),
    );
  }
}
