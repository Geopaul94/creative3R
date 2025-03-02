import 'package:creative/data/models/profile/profile_model.dart';
import 'package:creative/presentation/bloc/profile/profile_bloc.dart';
import 'package:creative/presentation/widgets/customappbar.dart';
import 'package:creative/utilities/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

// Define your screens


// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ProfileBloc()..add(ProfileInitialEvent()),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Trader Profile'),
//           centerTitle: true,
//           backgroundColor: Colors.indigo,
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.logout),
//               onPressed: () => _handleLogout(context),
//             ),
//           ],
//         ),
//         body: BlocConsumer<ProfileBloc, ProfileState>(
//           listener: (context, state) {
//             if (state is ProfileErrorState) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text(state.error)),
//               );
//             }
//           },
//           builder: (context, state) {
//             if (state is ProfileLoadingState) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             if (state is ProfileSuccessState) {
//               return _buildProfileContent(context, state.profileModel);
//             }
//             return const Center(
//                 child: Text('Welcome to your trading profile!'));
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildProfileContent(BuildContext context, ProfileModel profile) {
//     final company = profile.info;
//     return ListView(
//       padding: const EdgeInsets.all(16),
//       children: [
//         _buildProfileHeader(company),
//         const SizedBox(height: 24),
//         _buildCompanyInfoSection(company),
//         const SizedBox(height: 24),
//         _buildContactSection(context, company),
//         const SizedBox(height: 24),
//         _buildSecuritySection(),
//       ],
//     );
//   }

//   Widget _buildProfileHeader(CompanyInfo company) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             const CircleAvatar(
//               radius: 40,
//               backgroundImage: AssetImage('assets/images/5.jpg'),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               company.userName,
//               style: const TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.indigo,
//               ),
//             ),
//             Text(
//               company.companyName,
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCompanyInfoSection(CompanyInfo company) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildInfoRow(Icons.business, 'Company Info'),
//             const Divider(),
//             _buildDetailItem('Company ID', company.id),
//             _buildDetailItem('Registered Address', company.address),
//             _buildDetailItem('Trading License', 'AX-7890-2023'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildContactSection(BuildContext context, CompanyInfo company) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildInfoRow(Icons.contact_page, 'Contact Details'),
//             const Divider(),
//             _buildContactItem(context, Icons.email, 'Email', company.email),
//             _buildContactItem(context, Icons.phone, 'Contact', company.contact),
//             _buildContactItem(
//                 context, Icons.message, 'WhatsApp', company.whatsapp),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSecuritySection() {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildInfoRow(Icons.security, 'Security'),
//             const Divider(),
//             _buildSecurityItem('Two-Factor Authentication', true),
//             _buildSecurityItem('Biometric Login', false),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow(IconData icon, String text) {
//     return Row(
//       children: [
//         Icon(icon, color: Colors.indigo),
//         const SizedBox(width: 8),
//         Text(
//           text,
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.indigo,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDetailItem(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(title, style: TextStyle(color: Colors.grey[600])),
//           Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }

//   Widget _buildContactItem(
//       BuildContext context, IconData icon, String type, String value) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.indigo),
//       title: Text(type, style: TextStyle(color: Colors.grey[600])),
//       subtitle:
//           Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
//       trailing: IconButton(
//         icon: const Icon(Icons.content_copy, size: 20),
//         onPressed: () => _copyToClipboard(context, value),
//       ),
//     );
//   }

//   Widget _buildSecurityItem(String text, bool isActive) {
//     return ListTile(
//       title: Text(text),
//       trailing: Switch(
//         value: isActive,
//         activeColor: Colors.indigo,
//         onChanged: (value) {},
//       ),
//     );
//   }

void _copyToClipboard(BuildContext context, String text) {
  Clipboard.setData(ClipboardData(text: text));
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Copied $text to clipboard')),
  );
}

//   void _handleLogout(BuildContext context) {
//     print('Logout pressed');
//   }
// }


class ProfileScreen extends StatelessWidget {
   ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(ProfileInitialEvent()),
      child: Scaffold(backgroundColor: black,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey[900]!,
                  Colors.black,
                ],
              ),
            ),
            child: BlocConsumer<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is ProfileErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: Colors.amber[700],
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is ProfileLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.amber[300],
                    ),
                  );
                }
                if (state is ProfileSuccessState) {
                  return _buildProfileContent(context, state.profileModel);
                }
                return Center(
                  child: Text(
                    'Welcome to your trading profile!',
                    style: TextStyle(
                      color: Colors.amber[200],
                      fontSize: 20,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, ProfileModel profile) {
    final company = profile.info;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16,5,16,16),
      children: [

        Customappbar(text: 'Profile'),Divider(thickness:0.5,color: grey,),
        _buildProfileHeader(company),
        const SizedBox(height: 24),
        _buildCompanyInfoSection(company, context),
        const SizedBox(height: 24),
        _buildContactSection(context, company),
        const SizedBox(height: 24),
        _buildSecuritySection(),
      ],
    );
  }

  Widget _buildProfileHeader(CompanyInfo company) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.amber[700]!, width: 1),
      ),
      color: Colors.grey[850],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.amber[700]!,
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: 40,
                backgroundImage: const AssetImage('assets/images/5.jpg'),
                backgroundColor: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              company.userName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.amber[300],
                letterSpacing: 0.8,
              ),
            ),
            Text(
              company.companyName,
              style: TextStyle(
                fontSize: 18,
                color: Colors.amber[100],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompanyInfoSection(CompanyInfo company, BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.amber[700]!, width: 1),
      ),
      color: Colors.grey[850],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(Icons.business, 'Company Info'),
            Divider(color: Colors.amber[700]),
            _buildDetailItem('Company ID', company.id, context),
            _buildDetailItem('Registered Address', company.address, context),
            _buildDetailItem('Trading License', 'AX-7890-2023', context),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection(BuildContext context, CompanyInfo company) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.amber[700]!, width: 1),
      ),
      color: Colors.grey[850],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(Icons.contact_page, 'Contact Details'),
             Divider(color: Colors.amber[700]),
            _buildContactItem(context, Icons.email, 'Email', company.email),
            _buildContactItem(context, Icons.phone, 'Contact', company.contact),
            _buildContactItem(
                context, Icons.message, 'WhatsApp', company.whatsapp),
          ],
        ),
      ),
    );
  }

  Widget _buildSecuritySection() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.amber[700]!, width: 1),
      ),
      color: Colors.grey[850],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(Icons.security, 'Security'),
             Divider(color: Colors.amber[700]),
            _buildSecurityItem('Two-Factor Authentication', true),
            _buildSecurityItem('Biometric Login', false),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.amber[300]),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.amber[300],
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  // Widget _buildDetailItem(String title, String value) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(title, 
  //           style: TextStyle(
  //             color: Colors.amber[100],
  //             fontSize: 14,
  //           ),
  //         ),
  //         Text(value, 
  //           style: TextStyle(
  //             fontWeight: FontWeight.bold,
  //             color: Colors.amber[300],
  //             fontSize: 14,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }


// Widget _buildDetailItem(String title, String value) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 8),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(title,
//           style: TextStyle(
//             color: Colors.amber[100],
//             fontSize: 14,
//           ),
//         ),
//         GestureDetector(
//           onTap: title == 'Registered Address'
//               ? () => _launchMaps(value)
//               : null,
//           child: Text(value,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: title == 'Registered Address'
//                   ? Colors.amber[500] // Highlight address differently
//                   : Colors.amber[300],
//               fontSize: 14,
//               decoration: title == 'Registered Address'
//                   ? TextDecoration.underline
//                   : null,
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }



  // Widget _buildContactItem(
  //     BuildContext context, IconData icon, String type, String value) {
  //   return ListTile(
  //     leading: Icon(icon, color: Colors.amber[300]),
  //     title: Text(type, 
  //       style: TextStyle(
  //         color: Colors.amber[100],
  //         fontSize: 14,
  //       ),
  //     ),
  //     subtitle: Text(value, 
  //       style: TextStyle(
  //         fontWeight: FontWeight.bold,
  //         color: Colors.amber[300],
  //         fontSize: 14,
  //       ),
  //     ),
  //     trailing: IconButton(
  //       icon: Icon(Icons.content_copy, 
  //         size: 20,
  //         color: Colors.amber[300],
  //       ),
  //       onPressed: () => _copyToClipboard(context, value),
  //     ),
  //   );
  // }









  Widget _buildContactItem(
      BuildContext context, IconData icon, String type, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.amber[300]),
      title: Text(type,
        style: TextStyle(
          color: Colors.amber[100],
          fontSize: 14,
        ),
      ),
      subtitle: Text(value,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.amber[300],
          fontSize: 14,
        ),
      ),
      trailing: IconButton(
        icon: Icon(Icons.content_copy,
          size: 20,
          color: Colors.amber[300],
        ),
        onPressed: () => _copyToClipboard(context, value),
      ),
      onTap: () async {
        try {
          if (type == 'Email') {
            await _launchEmail(value);
          } else if (type == 'WhatsApp') {
            await _launchWhatsApp(value);
          } else if (type == 'Contact') {
            await _launchPhone(value);
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Could not launch ${type.toLowerCase()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    );
  }

  Widget _buildDetailItem(String title, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
            style: TextStyle(
              color: Colors.amber[100],
              fontSize: 14,
            ),
          ),
          GestureDetector(
            onTap: title == 'Registered Address' 
                ? () async {
                      try {
                        await _launchMaps(value);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Could not launch maps'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                : null,
            child: Text(value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: title == 'Registered Address'
                    ? Colors.amber[500]
                    : Colors.amber[300],
                fontSize: 14,
                decoration: title == 'Registered Address'
                    ? TextDecoration.underline
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildSecurityItem(String text, bool isActive) {
    return ListTile(
      title: Text(text,
        style: TextStyle(
          color: Colors.amber[100],
          fontSize: 14,
        ),
      ),
      trailing: Switch(
        value: isActive,
        activeColor: Colors.amber[700],
        activeTrackColor: Colors.amber[300],
        inactiveThumbColor: Colors.grey[400],
        inactiveTrackColor: Colors.grey[600],
        onChanged: (bool value) {
          // Handle the switch state change
        },
      ),
    );
  }

  // Keep _copyToClipboard and _handleLogout methods unchanged







  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'No email client installed';
    }
  }

  Future<void> _launchWhatsApp(String number) async {
    final cleanedPhone = number.replaceAll(RegExp(r'[+\s-]'), '');
    final Uri whatsappUri = Uri.parse('https://wa.me/$cleanedPhone');
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      throw 'WhatsApp not installed';
    }
  }

  Future<void> _launchPhone(String phone) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Phone dialer not available';
    }
  }

  Future<void> _launchMaps(String address) async {
    final Uri mapsUri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}',
    );
    if (await canLaunchUrl(mapsUri)) {
      await launchUrl(mapsUri);
    } else {
      throw 'Maps application not found';
    }
  }

  // ... rest of your existing code

}