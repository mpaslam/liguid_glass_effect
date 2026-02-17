/// Dynamic App Icon Example
/// Package: flutter_dynamic_icon_plus: ^2.0.0
///
/// See dynamic_app_icon_guide.md for iOS & Android setup instructions first!

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dynamic_icon_plus/flutter_dynamic_icon_plus.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Icon model
// ─────────────────────────────────────────────────────────────────────────────

class AppIconOption {
  /// The key used in Info.plist (iOS) and the alias suffix (Android).
  /// null = default icon.
  final String? iconName;
  final String label;
  final String emoji;
  final Color color;
  final String description;

  const AppIconOption({
    required this.iconName,
    required this.label,
    required this.emoji,
    required this.color,
    required this.description,
  });
}

// All available icon options.
// iconName must EXACTLY match:
//   iOS    → the key under CFBundleAlternateIcons in Info.plist
//   Android → the suffix of android:name in activity-alias (e.g. "dark" → ".MainActivityDark")
const List<AppIconOption> _iconOptions = [
  AppIconOption(
    iconName: null, // null = restore default icon
    label: 'Default',
    emoji: '🟣',
    color: Color(0xFF6C63FF),
    description: 'Original app icon',
  ),
  AppIconOption(
    iconName: 'dark', // Info.plist key / alias suffix
    label: 'Dark',
    emoji: '⚫',
    color: Color(0xFF1C1C1E),
    description: 'Dark theme icon',
  ),
  AppIconOption(
    iconName: 'blue',
    label: 'Ocean Blue',
    emoji: '🔵',
    color: Color(0xFF007AFF),
    description: 'Blue variant icon',
  ),
  AppIconOption(
    iconName: 'red',
    label: 'Fire Red',
    emoji: '🔴',
    color: Color(0xFFFF3B30),
    description: 'Red variant icon',
  ),
  AppIconOption(
    iconName: 'green',
    label: 'Nature',
    emoji: '🟢',
    color: Color(0xFF30D158),
    description: 'Green variant icon',
  ),
  AppIconOption(
    iconName: 'gold',
    label: 'Gold (Premium)',
    emoji: '🟡',
    color: Color(0xFFFFBF00),
    description: 'Exclusive premium icon',
  ),
];

// ─────────────────────────────────────────────────────────────────────────────
// Main page
// ─────────────────────────────────────────────────────────────────────────────

class DynamicIconPage extends StatefulWidget {
  const DynamicIconPage({super.key});

  @override
  State<DynamicIconPage> createState() => _DynamicIconPageState();
}

class _DynamicIconPageState extends State<DynamicIconPage> {
  String? _currentIconName; // null = default
  bool _isSupported = false;
  bool _isLoading = false;
  String _statusMessage = '';

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    // Check if dynamic icons are supported on this device
    final supported = await FlutterDynamicIconPlus.supportsAlternateIcons;

    // Get the currently active icon name
    final current = await FlutterDynamicIconPlus.alternateIconName;

    setState(() {
      _isSupported = supported;
      _currentIconName = current; // null if default icon is active
    });
  }

  // ── Change icon ───────────────────────────────────────────────────────────

  Future<void> _changeIcon(AppIconOption option) async {
    if (!_isSupported) {
      _showStatus(
        '❌ Dynamic icons not supported on this device',
        isError: true,
      );
      return;
    }

    if (_currentIconName == option.iconName) {
      _showStatus('Already using "${option.label}" icon', isError: false);
      return;
    }

    setState(() => _isLoading = true);

    try {
      // ✅ Correct v1.4.0 API — named parameter iconName:
      await FlutterDynamicIconPlus.setAlternateIconName(
        iconName: option.iconName, // null = restore default
      );

      final newCurrent = await FlutterDynamicIconPlus.alternateIconName;
      setState(() {
        _currentIconName = newCurrent;
        _isLoading = false;
      });

      _showStatus('✅ Icon changed to "${option.label}"', isError: false);
    } catch (e) {
      setState(() => _isLoading = false);
      _showStatus('❌ Failed: ${e.toString()}', isError: true);
      debugPrint('Dynamic icon error: $e');
    }
  }

  // ── ICON OPTIONS — iconName must match alias suffix exactly ──────────────────
  // Manifest alias          iconName in Dart
  // .MainActivitydefault  → null       (default/restore)
  // .MainActivitydark     → "dark"
  // .MainActivityblue     → "blue"
  // .MainActivityred      → "red"
  // .MainActivitygreen    → "green"
  // .MainActivitygold     → "gold"

  List<AppIconOption> _iconOptions = [
    AppIconOption(
      iconName: null, // ← null restores .MainActivitydefault
      label: 'Default',
      emoji: '🟣',
      color: Color(0xFF6C63FF),
      description: 'Original app icon',
    ),
    AppIconOption(
      iconName: 'dark', // ← matches .MainActivitydark
      label: 'Dark',
      emoji: '⚫',
      color: Color(0xFF1C1C1E),
      description: 'Dark theme icon',
    ),
    AppIconOption(
      iconName: 'blue', // ← matches .MainActivityblue
      label: 'Ocean Blue',
      emoji: '🔵',
      color: Color(0xFF007AFF),
      description: 'Blue variant icon',
    ),
    AppIconOption(
      iconName: 'red', // ← matches .MainActivityred
      label: 'Fire Red',
      emoji: '🔴',
      color: Color(0xFFFF3B30),
      description: 'Red variant icon',
    ),
    AppIconOption(
      iconName: 'green', // ← matches .MainActivitygreen
      label: 'Nature',
      emoji: '🟢',
      color: Color(0xFF30D158),
      description: 'Green variant icon',
    ),
    AppIconOption(
      iconName: 'gold', // ← matches .MainActivitygold
      label: 'Gold',
      emoji: '🟡',
      color: Color(0xFFFFBF00),
      description: 'Premium icon',
    ),
  ];

  void _showStatus(String msg, {required bool isError}) {
    setState(() => _statusMessage = msg);
    if (!mounted) return;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? Colors.red.shade700 : Colors.green.shade700,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  AppIconOption get _currentOption => _iconOptions.firstWhere(
    (o) => o.iconName == _currentIconName,
    orElse: () => _iconOptions.first,
  );

  bool _isActive(AppIconOption option) => option.iconName == _currentIconName;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF1C1C1E)
          : const Color(0xFFF2F2F7),
      body: CustomScrollView(
        slivers: [
          // ── Large title app bar ───────────────────────────────────────────
          SliverAppBar.large(
            backgroundColor: isDark
                ? const Color(0xFF1C1C1E)
                : const Color(0xFFF2F2F7),
            title: const Text(
              'App Icon',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            actions: [
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: CupertinoActivityIndicator(),
                ),
            ],
          ),

          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── Current icon preview ──────────────────────────────────
                _CurrentIconCard(option: _currentOption, isLoading: _isLoading),

                const SizedBox(height: 24),

                // ── Support badge ─────────────────────────────────────────
                if (!_isSupported)
                  _WarningBanner(
                    message: Platform.isIOS
                        ? 'Dynamic icons require iOS 10.3+'
                        : 'Dynamic icons may not be supported on this Android launcher.',
                  ),

                if (!_isSupported) const SizedBox(height: 16),

                // ── iOS notice ────────────────────────────────────────────
                if (Platform.isIOS && _isSupported)
                  _InfoBanner(
                    message:
                        'iOS will show a system alert each time you change the icon. '
                        'This cannot be disabled — it\'s enforced by Apple.',
                  ),

                if (Platform.isIOS && _isSupported) const SizedBox(height: 16),

                // ── Android notice ────────────────────────────────────────
                if (Platform.isAndroid && _isSupported)
                  _InfoBanner(
                    message:
                        'On Android the app briefly closes and reopens when '
                        'the icon changes. This is normal behaviour.',
                  ),

                if (Platform.isAndroid && _isSupported)
                  const SizedBox(height: 16),

                // ── Section title ─────────────────────────────────────────
                const _SectionHeader(title: 'Choose Icon'),
                const SizedBox(height: 12),

                // ── Icon grid ─────────────────────────────────────────────
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: _iconOptions.length,
                  itemBuilder: (context, index) {
                    final option = _iconOptions[index];
                    return _IconTile(
                      option: option,
                      isActive: _isActive(option),
                      isLoading: _isLoading,
                      onTap: () => _changeIcon(option),
                    );
                  },
                ),

                const SizedBox(height: 24),

                // ── How it works ──────────────────────────────────────────
                const _SectionHeader(title: 'How It Works'),
                const SizedBox(height: 12),
                const _HowItWorksList(),

                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Current icon card
// ─────────────────────────────────────────────────────────────────────────────

class _CurrentIconCard extends StatelessWidget {
  final AppIconOption option;
  final bool isLoading;

  const _CurrentIconCard({required this.option, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2C2C2E) : Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: option.color.withOpacity(0.2),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon preview
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: option.color,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: option.color.withOpacity(0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Center(
              child: isLoading
                  ? const CupertinoActivityIndicator(color: Colors.white)
                  : Text(option.emoji, style: const TextStyle(fontSize: 38)),
            ),
          ),

          const SizedBox(width: 20),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Current Icon',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: CupertinoColors.secondaryLabel,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Text(
                    option.label,
                    key: ValueKey(option.label),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  option.description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: CupertinoColors.secondaryLabel,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Icon tile (grid cell)
// ─────────────────────────────────────────────────────────────────────────────

class _IconTile extends StatelessWidget {
  final AppIconOption option;
  final bool isActive;
  final bool isLoading;
  final VoidCallback onTap;

  const _IconTile({
    required this.option,
    required this.isActive,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isActive
              ? option.color.withOpacity(0.12)
              : isDark
              ? const Color(0xFF2C2C2E)
              : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isActive ? option.color : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: (isDark ? Colors.black : Colors.black12).withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon circle
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: option.color,
                borderRadius: BorderRadius.circular(15),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: option.color.withOpacity(0.45),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: Text(option.emoji, style: const TextStyle(fontSize: 28)),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              option.label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive
                    ? option.color
                    : isDark
                    ? Colors.white70
                    : Colors.black87,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            // Active checkmark
            AnimatedOpacity(
              opacity: isActive ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Icon(
                  Icons.check_circle_rounded,
                  color: option.color,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Warning / info banners
// ─────────────────────────────────────────────────────────────────────────────

class _WarningBanner extends StatelessWidget {
  final String message;
  const _WarningBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Colors.orange,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(fontSize: 13, color: Colors.orange),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoBanner extends StatelessWidget {
  final String message;
  const _InfoBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.blue.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline_rounded, color: Colors.blue, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 13,
                color: Colors.blue.shade700,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section header
// ─────────────────────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: CupertinoColors.secondaryLabel,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// How it works section
// ─────────────────────────────────────────────────────────────────────────────

class _HowItWorksList extends StatelessWidget {
  const _HowItWorksList();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final steps = [
      (
        icon: Icons.phone_iphone_rounded,
        color: const Color(0xFF6C63FF),
        title: 'iOS',
        body:
            'Uses the native setAlternateIconName() API (iOS 10.3+). '
            'A system alert is always shown — this is enforced by Apple.',
      ),
      (
        icon: Icons.android_rounded,
        color: const Color(0xFF30D158),
        title: 'Android',
        body:
            'Uses activity-alias components in AndroidManifest.xml. '
            'The app briefly restarts after the icon changes.',
      ),
      (
        icon: Icons.image_rounded,
        color: const Color(0xFF43BBFF),
        title: 'Icon Files',
        body:
            'Icons must be added natively — in Xcode for iOS and in '
            'res/mipmap folders for Android.',
      ),
      (
        icon: Icons.lock_outline_rounded,
        color: const Color(0xFFFFBF00),
        title: 'Limitations',
        body:
            'You cannot use any image from the internet. '
            'All alternate icons must be bundled at build time.',
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2C2C2E) : Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: steps.asMap().entries.map((entry) {
          final i = entry.key;
          final s = entry.value;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: s.color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(s.icon, color: s.color, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            s.body,
                            style: const TextStyle(
                              fontSize: 13,
                              color: CupertinoColors.secondaryLabel,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (i < steps.length - 1) const Divider(height: 1, indent: 64),
            ],
          );
        }).toList(),
      ),
    );
  }
}
