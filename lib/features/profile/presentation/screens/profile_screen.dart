import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: const Text('Profile')),
        body: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.accentSoft,
                    child: Text(
                      'H',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Hardik',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            const _MenuTile(
              icon: Icons.person_outline_rounded,
              label: 'Account details',
            ),
            const _MenuTile(icon: Icons.shield_outlined, label: 'Security'),
            const _MenuTile(
              icon: Icons.notifications_none_rounded,
              label: 'Notifications',
            ),
            const _MenuTile(
              icon: Icons.help_outline_rounded,
              label: 'Help & support',
            ),
            const _MenuTile(
              icon: Icons.info_outline_rounded,
              label: 'About this app',
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  const _MenuTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.divider),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.textPrimary),
        title: Text(label, style: Theme.of(context).textTheme.bodyLarge),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: AppColors.textDisabled,
        ),
        onTap: () {},
      ),
    );
  }
}
