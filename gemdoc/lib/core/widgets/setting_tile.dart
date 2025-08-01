import 'package:flutter/material.dart';
import 'package:gemdoc/core/constants/app_colors.dart';

/// A reusable settings tile with icon, title, optional subtitle, trailing widget, and tap handler.
/// Used in settings or profile screens for consistent UI appearance.
class SettingTile extends StatelessWidget {
  final IconData icon; // Leading icon
  final String title; // Tile title text
  final String? subtitle; // Optional subtitle text
  final Widget? trailing; // Optional trailing widget (e.g., switch or chevron)
  final VoidCallback? onTap; // Callback when the tile is tapped
  final Color? iconColor; // Custom color for the icon background
  final bool showDivider; // Controls whether a divider is shown below the tile

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
    return Column(
      children: [
        ListTile(
          // Custom styled leading icon with background
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor?.withOpacity(0.2) ??
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor ?? Theme.of(context).colorScheme.primary,
              size: 20,
            ),
          ),

          // Title styling
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),

          // Optional subtitle
          subtitle: subtitle != null
              ? Text(
                  subtitle!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6),
                      ),
                )
              : null,

          // Optional trailing icon or custom widget
          trailing: trailing ??
              (onTap != null
                  ? Icon(
                      Icons.chevron_right,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.5),
                    )
                  : null),

          // Tap event handler
          onTap: onTap,

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          minVerticalPadding: 0,
        ),

        // Optional divider
        if (showDivider)
          Padding(
            padding: const EdgeInsets.only(left: 72, right: 16),
            child: Divider(
              height: 1,
              thickness: 1,
              color:
                  Theme.of(context).dividerColor.withOpacity(0.1),
            ),
          ),
      ],
    );
  }
}
