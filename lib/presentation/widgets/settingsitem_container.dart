
import 'package:creative/presentation/widgets/custom_text.dart';
import 'package:creative/presentation/widgets/customappbar.dart';
import 'package:creative/utilities/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SettingsItemContainer extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;

  const SettingsItemContainer({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.onTap,
    this.iconColor = Colors.amber,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850],
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.amber[700]!, width: 0.5),
      ),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        splashColor: Colors.amber.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.amber[300],
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subtitle != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          subtitle!,
                          style: TextStyle(
                            color: Colors.amber[100],
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Icon(
                CupertinoIcons.chevron_forward,
                color: Colors.amber[200],
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
