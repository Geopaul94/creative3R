import 'package:creative/presentation/screeens/authentication/login_screen.dart';
import 'package:creative/presentation/widgets/custom_signout.dart';
import 'package:creative/presentation/widgets/custom_text.dart';
import 'package:creative/presentation/widgets/customappbar.dart';
import 'package:creative/presentation/widgets/settingsitem_container.dart';
import 'package:creative/utilities/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
   
    void navigateToSettings() {
      // Add your sign-out logic here
    }

    void openPrivacyPolicy() {
      // Add your privacy policy logic here
    }
    void showTerms() {
      // Add your privacy policy logic here
    }
    return Scaffold(
      backgroundColor: black,
      body: Stack(
        children: [
          Positioned(
            left: 150,
            bottom: 30,
            child: CustomText(
              text: 'verson 1.02',
              color: grey,
            ),
          ),
          SafeArea(
              child: Column(
            children: [
              Customappbar(text: 'Aurify'),
              Divider(
                thickness: 0.5,
                color: grey100,
              ),
              SettingsItemContainer(
                title: "Privacy Policy",
                subtitle: "Read our data protection guidelines",
                icon: Icons.privacy_tip_outlined,
                onTap: () => openPrivacyPolicy(),
              ),
              SettingsItemContainer(
                title: "Terms & Conditions",
                icon: Icons.description_outlined,
                onTap: () => showTerms(),
              ),
              SettingsItemContainer(
                title: "App Settings",
                subtitle: "Customize your experience",
                icon: Icons.settings,
                onTap: () => navigateToSettings(),
              ),
              SettingsItemContainer(
                title: "Sign Out",
                icon: Icons.logout,
                iconColor: Colors.red[400] ?? Colors.red,
                onTap: () => handleSignOut( context),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
