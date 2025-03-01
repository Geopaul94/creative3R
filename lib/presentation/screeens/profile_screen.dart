import 'package:creative/data/models/profile/profile_model.dart';
import 'package:creative/presentation/bloc/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Define your screens
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(ProfileInitialEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Trader Profile'),
          centerTitle: true,
          backgroundColor: Colors.indigo,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => _handleLogout(context),
            ),
          ],
        ),
        body: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProfileSuccessState) {
              return _buildProfileContent(context, state.profileModel);
            }
            return const Center(
                child: Text('Welcome to your trading profile!'));
          },
        ),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, ProfileModel profile) {
    final company = profile.info;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildProfileHeader(company),
        const SizedBox(height: 24),
        _buildCompanyInfoSection(company),
        const SizedBox(height: 24),
        _buildContactSection(context, company),
        const SizedBox(height: 24),
        _buildSecuritySection(),
      ],
    );
  }

  Widget _buildProfileHeader(CompanyInfo company) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/images/5.jpg'),
            ),
            const SizedBox(height: 16),
            Text(
              company.userName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            Text(
              company.companyName,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompanyInfoSection(CompanyInfo company) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(Icons.business, 'Company Info'),
            const Divider(),
            _buildDetailItem('Company ID', company.id),
            _buildDetailItem('Registered Address', company.address),
            _buildDetailItem('Trading License', 'AX-7890-2023'),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection(BuildContext context, CompanyInfo company) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(Icons.contact_page, 'Contact Details'),
            const Divider(),
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
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(Icons.security, 'Security'),
            const Divider(),
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
        Icon(icon, color: Colors.indigo),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.grey[600])),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildContactItem(
      BuildContext context, IconData icon, String type, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.indigo),
      title: Text(type, style: TextStyle(color: Colors.grey[600])),
      subtitle:
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      trailing: IconButton(
        icon: const Icon(Icons.content_copy, size: 20),
        onPressed: () => _copyToClipboard(context, value),
      ),
    );
  }

  Widget _buildSecurityItem(String text, bool isActive) {
    return ListTile(
      title: Text(text),
      trailing: Switch(
        value: isActive,
        activeColor: Colors.indigo,
        onChanged: (value) {},
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied $text to clipboard')),
    );
  }

  void _handleLogout(BuildContext context) {
    print('Logout pressed');
  }
}
