import 'package:flutter/material.dart';

/// A reusable tile widget used in app settings screen.
/// Displays an icon, title, optional subtitle, and an optional trailing widget or arrow icon.
class SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? iconColor;
  final bool showDivider;

  const SettingTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.iconColor,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = iconColor ?? theme.colorScheme.primary;

    return Column(
      children: [
        ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              // Use withAlpha(51) to replace withOpacity(0.2) — 0.2 * 255 ≈ 51
              color: primaryColor.withAlpha(51),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 20,
            ),
          ),
          title: Text(
            title,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withAlpha(153), // ≈ 0.6 * 255 = 153
                  ),
                )
              : null,
          trailing: trailing ??
              (onTap != null
                  ? Icon(
                      Icons.chevron_right,
                      color: theme.colorScheme.onSurface.withAlpha(128), // ≈ 0.5 * 255 = 128
                    )
                  : null),
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          minVerticalPadding: 0,
        ),
        if (showDivider)
          Padding(
            padding: const EdgeInsets.only(left: 72, right: 16),
            child: Divider(
              height: 1,
              thickness: 1,
              color: theme.dividerColor.withAlpha(25), // ≈ 0.1 * 255 = 25
            ),
          ),
      ],
    );
  }
}
