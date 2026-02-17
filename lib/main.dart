/// iOS 26 Liquid Glass Example — adaptive_platform_ui: ^0.1.101
///
/// pubspec.yaml dependencies:
///   adaptive_platform_ui: ^0.1.101
///   flutter_localizations:
///     sdk: flutter

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:liguid_glass_effect/icon_change.dart';

// ──────────────────────────────────────────────────────────────────────────────
// Entry point
// ──────────────────────────────────────────────────────────────────────────────

void main() {
  runApp(const LiquidGlassApp());
}

// ──────────────────────────────────────────────────────────────────────────────
// Root app — uses AdaptiveApp for automatic platform theming
// ──────────────────────────────────────────────────────────────────────────────

class LiquidGlassApp extends StatelessWidget {
  const LiquidGlassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveApp(
      title: 'iOS 26 Liquid Glass',
      themeMode: ThemeMode.system,

      // ── Material theme (Android) ──────────────────────────────────────────
      materialLightTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      materialDarkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),

      // ── Cupertino theme (iOS) ─────────────────────────────────────────────
      cupertinoLightTheme: const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.systemPurple,
      ),
      cupertinoDarkTheme: const CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: CupertinoColors.systemPurple,
      ),

      // ── Localization (required for date/time pickers etc.) ────────────────
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],

      home: const DynamicIconPage(),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Main shell — AdaptiveScaffold + AdaptiveBottomNavigationBar (Liquid Glass)
// ──────────────────────────────────────────────────────────────────────────────

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    _HomePage(),
    _SliderPage(),
    _AlertsPage(),
    _ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      // ── Native iOS 26 UIToolbar with Liquid Glass ─────────────────────────
      appBar: AdaptiveAppBar(
        title: _tabTitle(_selectedIndex),
        useNativeToolbar: true,
        actions: [
          AdaptiveAppBarAction(
            onPressed: () => _showInfoDialog(context),
            iosSymbol: 'info.circle',
            icon: Icons.info_outline,
          ),
          AdaptiveAppBarAction(
            onPressed: () => _showSettingsSnack(context),
            iosSymbol: 'gear',
            icon: Icons.settings_outlined,
          ),
        ],
      ),

      // ── Native iOS 26 UITabBar with Liquid Glass ──────────────────────────
      bottomNavigationBar: AdaptiveBottomNavigationBar(
        useNativeBottomBar: true,
        selectedIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          AdaptiveNavigationDestination(icon: 'house.fill', label: 'Home'),
          AdaptiveNavigationDestination(
              icon: 'slider.horizontal.3', label: 'Controls'),
          AdaptiveNavigationDestination(
              icon: 'bell.badge.fill', label: 'Alerts'),
          AdaptiveNavigationDestination(
              icon: 'person.crop.circle.fill', label: 'Profile'),
        ],
      ),

      body: _pages[_selectedIndex],
    );
  }

  String _tabTitle(int index) =>
      const ['Home', 'Controls', 'Alerts', 'Profile'][index];

  // FIX: show() returns void — no await, no result variable
  void _showInfoDialog(BuildContext ctx) {
    AdaptiveAlertDialog.show(
      context: ctx,
      title: 'About',
      message: 'This app demonstrates iOS 26 Liquid Glass effects using the '
          'adaptive_platform_ui package.',
      icon: 'info.circle.fill',
      actions: [
        AlertAction(
          title: 'Got it',
          style: AlertActionStyle.primary,
          onPressed: () {},
        ),
      ],
    );
  }

  void _showSettingsSnack(BuildContext ctx) {
    AdaptiveSnackBar.show(
      ctx,
      message: 'Settings tapped!',
      type: AdaptiveSnackBarType.info,
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Tab 1 — Home
// ──────────────────────────────────────────────────────────────────────────────

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Hero card
        AdaptiveCard(
          padding: const EdgeInsets.all(24),
          borderRadius: BorderRadius.circular(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6C63FF), Color(0xFFFF6584)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.auto_awesome,
                        color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Liquid Glass UI',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700)),
                        Text('iOS 26 Native Design',
                            style: TextStyle(
                                fontSize: 13,
                                color: CupertinoColors.secondaryLabel)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'This demo showcases native iOS 26 Liquid Glass effects '
                'including the bottom navigation bar, toolbar, sliders, '
                'switches, and alert dialogs — all rendered with real UIKit '
                'components on iOS 26+.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),
        _sectionHeader('Features'),
        const SizedBox(height: 10),

        _FeatureTile(
          icon: Icons.table_rows,
          title: 'Liquid Glass Bottom Bar',
          subtitle: 'Native UITabBar with blur & minimize',
          color: const Color(0xFF6C63FF),
        ),
        const SizedBox(height: 10),
        _FeatureTile(
          icon: Icons.tune,
          title: 'Adaptive Sliders & Switches',
          subtitle: 'Native UISlider & UISwitch on iOS',
          color: const Color(0xFF43BBFF),
        ),
        const SizedBox(height: 10),
        _FeatureTile(
          icon: Icons.notifications,
          title: 'Alert Dialogs',
          subtitle: 'UIAlertController with Liquid Glass',
          color: const Color(0xFFFF6584),
        ),
        const SizedBox(height: 10),
        _FeatureTile(
          icon: Icons.message,
          title: 'Adaptive SnackBar / Toast',
          subtitle: 'Banner on iOS, SnackBar on Android',
          color: const Color(0xFF30D158),
        ),

        const SizedBox(height: 20),
        _sectionHeader('Platform'),
        const SizedBox(height: 10),

        AdaptiveCard(
          padding: const EdgeInsets.all(16),
          borderRadius: BorderRadius.circular(16),
          child: Column(
            children: [
              _InfoRow(
                  label: 'Platform',
                  value: PlatformInfo.isIOS ? 'iOS' : 'Android'),
              const Divider(height: 1),
              _InfoRow(
                  label: 'Version',
                  value: PlatformInfo.platformDescription),
              if (PlatformInfo.isIOS) ...[
                const Divider(height: 1),
                _InfoRow(
                  label: 'Liquid Glass',
                  value: PlatformInfo.isIOS26OrHigher()
                      ? '✅ Active (iOS 26+)'
                      : '⚠️ Not active',
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _sectionHeader(String title) => Padding(
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

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _FeatureTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveListTile(
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
      subtitle: Text(subtitle,
          style: const TextStyle(
              fontSize: 12, color: CupertinoColors.secondaryLabel)),
      trailing: const Icon(CupertinoIcons.chevron_right,
          size: 14, color: CupertinoColors.tertiaryLabel),
      onTap: () {},
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 14, color: CupertinoColors.secondaryLabel)),
          Text(value,
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Tab 2 — Sliders & Controls
// ──────────────────────────────────────────────────────────────────────────────

class _SliderPage extends StatefulWidget {
  const _SliderPage();

  @override
  State<_SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<_SliderPage> {
  double _volume = 0.6;
  double _brightness = 0.75;
  double _temperature = 22.0;
  bool _musicEnabled = true;
  bool _nightMode = false;
  bool _autoUpdate = true;
  int _selectedQuality = 1;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // ── Audio ──────────────────────────────────────────────────────────
        const _SectionTitle(title: 'Audio'),
        AdaptiveCard(
          padding: const EdgeInsets.all(20),
          borderRadius: BorderRadius.circular(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    _volume == 0
                        ? Icons.volume_off_rounded
                        : _volume < 0.5
                            ? Icons.volume_down_rounded
                            : Icons.volume_up_rounded,
                    color: const Color(0xFF6C63FF),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Volume',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15)),
                        // Native UISlider on iOS 26
                        AdaptiveSlider(
                          value: _volume,
                          min: 0.0,
                          max: 1.0,
                          onChanged: (v) => setState(() => _volume = v),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('${(_volume * 100).round()}%',
                      style: const TextStyle(
                          fontSize: 13,
                          color: CupertinoColors.secondaryLabel,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Music',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500)),
                  // Native UISwitch on iOS 26
                  AdaptiveSwitch(
                    value: _musicEnabled,
                    onChanged: (v) => setState(() => _musicEnabled = v),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // ── Display ────────────────────────────────────────────────────────
        const _SectionTitle(title: 'Display'),
        AdaptiveCard(
          padding: const EdgeInsets.all(20),
          borderRadius: BorderRadius.circular(18),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.brightness_6_rounded,
                      color: Color(0xFFFFBF00)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Brightness',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15)),
                        AdaptiveSlider(
                          value: _brightness,
                          min: 0.1,
                          max: 1.0,
                          onChanged: (v) =>
                              setState(() => _brightness = v),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('${(_brightness * 100).round()}%',
                      style: const TextStyle(
                          fontSize: 13,
                          color: CupertinoColors.secondaryLabel,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Night Mode',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500)),
                  AdaptiveSwitch(
                    value: _nightMode,
                    onChanged: (v) => setState(() => _nightMode = v),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // ── Climate ────────────────────────────────────────────────────────
        const _SectionTitle(title: 'Climate'),
        AdaptiveCard(
          padding: const EdgeInsets.all(20),
          borderRadius: BorderRadius.circular(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    _temperature < 18
                        ? '🥶'
                        : _temperature < 24
                            ? '😊'
                            : '🥵',
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Temperature  ${_temperature.toStringAsFixed(1)}°C',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                        AdaptiveSlider(
                          value: _temperature,
                          min: 16.0,
                          max: 30.0,
                          onChanged: (v) =>
                              setState(() => _temperature = v),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Auto update',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500)),
                  AdaptiveSwitch(
                    value: _autoUpdate,
                    onChanged: (v) => setState(() => _autoUpdate = v),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // ── Stream quality ─────────────────────────────────────────────────
        const _SectionTitle(title: 'Stream Quality'),
        AdaptiveCard(
          padding: const EdgeInsets.all(20),
          borderRadius: BorderRadius.circular(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Select quality',
                  style: TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.secondaryLabel)),
              const SizedBox(height: 12),
              // Native UISegmentedControl on iOS 26
              AdaptiveSegmentedControl(
                labels: const ['Low', 'Medium', 'High'],
                selectedIndex: _selectedQuality,
                onValueChanged: (i) =>
                    setState(() => _selectedQuality = i),
              ),
              const SizedBox(height: 12),
              _QualityDescription(quality: _selectedQuality),
            ],
          ),
        ),
      ],
    );
  }
}

class _QualityDescription extends StatelessWidget {
  final int quality;
  const _QualityDescription({required this.quality});

  @override
  Widget build(BuildContext context) {
    const descriptions = [
      '360p · Saves data, suitable for slow connections.',
      '720p · Balanced quality for most connections.',
      '1080p · Full HD, requires fast internet.',
    ];
    const colors = [
      Color(0xFF30D158),
      Color(0xFF43BBFF),
      Color(0xFF6C63FF),
    ];
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
              color: colors[quality], shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(descriptions[quality],
              style: const TextStyle(
                  fontSize: 12,
                  color: CupertinoColors.secondaryLabel)),
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Tab 3 — Alerts & Dialogs
// ──────────────────────────────────────────────────────────────────────────────

class _AlertsPage extends StatefulWidget {
  const _AlertsPage();

  @override
  State<_AlertsPage> createState() => _AlertsPageState();
}

class _AlertsPageState extends State<_AlertsPage> {
  String _lastResult = '—';

  void _setResult(String r) => setState(() => _lastResult = r);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Last result banner
        AdaptiveCard(
          padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          borderRadius: BorderRadius.circular(14),
          child: Row(
            children: [
              const Icon(Icons.history_rounded,
                  color: CupertinoColors.secondaryLabel, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text('Last action: $_lastResult',
                    style: const TextStyle(
                        fontSize: 13,
                        color: CupertinoColors.secondaryLabel)),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // ── Basic dialogs ────────────────────────────────────────────────
        const _SectionTitle(title: 'Basic Dialogs'),
        _DialogCard(
          icon: Icons.check_circle_outline_rounded,
          iconColor: const Color(0xFF30D158),
          title: 'Confirmation',
          subtitle: 'Cancel & Confirm actions',
          onTap: () => _showConfirmDialog(context),
        ),
        const SizedBox(height: 10),
        _DialogCard(
          icon: Icons.warning_amber_rounded,
          iconColor: const Color(0xFFFF9F0A),
          title: 'Warning',
          subtitle: 'Destructive action warning',
          onTap: () => _showDestructiveDialog(context),
        ),
        const SizedBox(height: 10),
        _DialogCard(
          icon: Icons.error_outline_rounded,
          iconColor: const Color(0xFFFF453A),
          title: 'Error',
          subtitle: 'Error notification dialog',
          onTap: () => _showErrorDialog(context),
        ),

        const SizedBox(height: 20),

        // ── Input dialog ─────────────────────────────────────────────────
        const _SectionTitle(title: 'Input Dialog'),
        _DialogCard(
          icon: Icons.person_outline_rounded,
          iconColor: const Color(0xFF43BBFF),
          title: 'Name Input',
          subtitle: 'Alert with text field',
          onTap: () => _showNameDialog(context),
        ),

        const SizedBox(height: 20),

        // ── Auth dialog ──────────────────────────────────────────────────
        const _SectionTitle(title: 'Auth Dialog'),
        _DialogCard(
          icon: Icons.lock_outline_rounded,
          iconColor: const Color(0xFF6C63FF),
          title: 'Authentication',
          subtitle: 'Sign-in confirmation dialog',
          onTap: () => _showAuthDialog(context),
        ),

        const SizedBox(height: 20),

        // ── Snackbar / toast ─────────────────────────────────────────────
        const _SectionTitle(title: 'Snackbar / Toast'),
        Row(
          children: [
            Expanded(
              child: AdaptiveButton(
                onPressed: () => AdaptiveSnackBar.show(context,
                    message: 'Action completed!',
                    type: AdaptiveSnackBarType.success),
                style: AdaptiveButtonStyle.tinted,
                label: '✅ Success',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AdaptiveButton(
                onPressed: () => AdaptiveSnackBar.show(context,
                    message: 'Something went wrong',
                    type: AdaptiveSnackBarType.error),
                style: AdaptiveButtonStyle.tinted,
                color: Colors.red,
                label: '❌ Error',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: AdaptiveButton(
                onPressed: () => AdaptiveSnackBar.show(context,
                    message: 'Check your connection',
                    type: AdaptiveSnackBarType.warning),
                style: AdaptiveButtonStyle.tinted,
                color: Colors.orange,
                label: '⚠️ Warning',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AdaptiveButton(
                onPressed: () => AdaptiveSnackBar.show(context,
                    message: 'Item deleted',
                    type: AdaptiveSnackBarType.info,
                    action: 'Undo',
                    onActionPressed: () => _setResult('Undo tapped')),
                style: AdaptiveButtonStyle.tinted,
                color: Colors.blue,
                label: 'ℹ️ Undo',
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // ── Button styles ────────────────────────────────────────────────
        const _SectionTitle(title: 'Button Styles'),
        AdaptiveCard(
          padding: const EdgeInsets.all(16),
          borderRadius: BorderRadius.circular(18),
          // FIX: do NOT use crossAxisAlignment.stretch with AdaptiveButton —
          // UiKitView (iOS 26 native button) needs bounded width constraints.
          // Use SizedBox with a fixed width instead.
          child: LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth - 32; // card padding = 16*2
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: w,
                    child: AdaptiveButton(
                      onPressed: () => _setResult('Filled tapped'),
                      style: AdaptiveButtonStyle.filled,
                      size: AdaptiveButtonSize.large,
                      label: 'Filled (Primary)',
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: w,
                    child: AdaptiveButton(
                      onPressed: () => _setResult('Tinted tapped'),
                      style: AdaptiveButtonStyle.tinted,
                      size: AdaptiveButtonSize.large,
                      label: 'Tinted (Secondary)',
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: w,
                    child: AdaptiveButton(
                      onPressed: () => _setResult('Bordered tapped'),
                      style: AdaptiveButtonStyle.bordered,
                      size: AdaptiveButtonSize.large,
                      label: 'Bordered',
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: w,
                    child: AdaptiveButton(
                      onPressed: () => _setResult('Gray tapped'),
                      style: AdaptiveButtonStyle.gray,
                      size: AdaptiveButtonSize.large,
                      label: 'Gray',
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: w,
                    child: AdaptiveButton(
                      onPressed: () => _setResult('Plain tapped'),
                      style: AdaptiveButtonStyle.plain,
                      size: AdaptiveButtonSize.large,
                      label: 'Plain Text',
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  // ── Dialog helpers ───────────────────────────────────────────────────────

  // FIX: All dialogs are now void (no await, no result variable)
  // Results are captured inside onPressed callbacks or via onChanged

  void _showConfirmDialog(BuildContext ctx) {
    AdaptiveAlertDialog.show(
      context: ctx,
      title: 'Save Changes?',
      message: 'Your changes will be saved to your account.',
      icon: 'checkmark.circle.fill',
      actions: [
        AlertAction(
          title: 'Cancel',
          style: AlertActionStyle.cancel,
          onPressed: () => _setResult('Cancelled'),
        ),
        AlertAction(
          title: 'Save',
          style: AlertActionStyle.primary,
          onPressed: () => _setResult('Changes saved'),
        ),
      ],
    );
  }

  void _showDestructiveDialog(BuildContext ctx) {
    AdaptiveAlertDialog.show(
      context: ctx,
      title: 'Delete Account?',
      message: 'This action is permanent and cannot be undone. '
          'All your data will be removed.',
      icon: 'trash.fill',
      actions: [
        AlertAction(
          title: 'Cancel',
          style: AlertActionStyle.cancel,
          onPressed: () => _setResult('Delete cancelled'),
        ),
        AlertAction(
          title: 'Delete',
          style: AlertActionStyle.destructive,
          onPressed: () => _setResult('Account deleted'),
        ),
      ],
    );
  }

  void _showErrorDialog(BuildContext ctx) {
    AdaptiveAlertDialog.show(
      context: ctx,
      title: 'Connection Error',
      message: 'Unable to connect to the server. Please check your '
          'internet connection and try again.',
      icon: 'wifi.exclamationmark',
      actions: [
        AlertAction(
          title: 'Dismiss',
          style: AlertActionStyle.cancel,
          onPressed: () => _setResult('Error dismissed'),
        ),
        AlertAction(
          title: 'Retry',
          style: AlertActionStyle.primary,
          onPressed: () => _setResult('Retrying…'),
        ),
      ],
    );
  }

  void _showNameDialog(BuildContext ctx) {
    // FIX: capture input via onChanged — NOT by awaiting show()
    String? capturedName;

    AdaptiveAlertDialog.show(
      context: ctx,
      title: 'Enter Your Name',
      message: 'This will be displayed on your profile.',
      icon: 'person.fill',
      // FIX: no 'const' keyword — closures cannot be const
      // input: AdaptiveAlertDialogInput(
      //   placeholder: 'e.g. Alex Smith',
      //   initialValue: '',
      //   keyboardType: TextInputType.name,
      //   onChanged: (value) => capturedName = value, // capture as user types
      // ),
      actions: [
        AlertAction(
          title: 'Cancel',
          style: AlertActionStyle.cancel,
          onPressed: () => _setResult('Name input cancelled'),
        ),
        AlertAction(
          title: 'Save',
          style: AlertActionStyle.primary,
          // FIX: read capturedName here inside onPressed
          onPressed: () {
            if (capturedName != null && capturedName!.isNotEmpty) {
              _setResult('Name entered: $capturedName');
            } else {
              _setResult('No name entered');
            }
          },
        ),
      ],
    );
  }

  void _showAuthDialog(BuildContext ctx) {
    // FIX: removed oneTimeCode: and iconColor: — not in ^0.1.101 API
    AdaptiveAlertDialog.show(
      context: ctx,
      title: 'Authentication Required',
      message: 'Use the code 847 291 to complete your sign-in.',
      icon: 'lock.shield.fill',
      actions: [
        AlertAction(
          title: 'Cancel',
          style: AlertActionStyle.cancel,
          onPressed: () => _setResult('Auth cancelled'),
        ),
        AlertAction(
          title: 'Continue',
          style: AlertActionStyle.primary,
          onPressed: () => _setResult('Auth confirmed'),
        ),
      ],
    );
  }
}

class _DialogCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _DialogCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // FIX: AdaptiveButton (UiKitView on iOS 26) crashes in 'trailing' because
    // trailing has unbounded width. Use a plain styled button instead.
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: CupertinoColors.secondarySystemGroupedBackground
              .resolveFrom(context),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15)),
                  Text(subtitle,
                      style: const TextStyle(
                          fontSize: 12,
                          color: CupertinoColors.secondaryLabel)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Safe trailing: a plain text button with fixed size
            CupertinoButton(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              color: iconColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
              minSize: 0,
              onPressed: onTap,
              child: Text(
                'Show',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: iconColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Tab 4 — Profile
// ──────────────────────────────────────────────────────────────────────────────

class _ProfilePage extends StatefulWidget {
  const _ProfilePage();

  @override
  State<_ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<_ProfilePage> {
  bool _notifications = true;
  bool _biometrics = false;
  bool _analytics = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Avatar
        Center(
          child: Column(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6C63FF), Color(0xFFFF6584)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6C63FF).withOpacity(0.35),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(Icons.person,
                    color: Colors.white, size: 48),
              ),
              const SizedBox(height: 12),
              const Text('Alex Johnson',
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w700)),
              const Text('alex.johnson@email.com',
                  style: TextStyle(
                      fontSize: 14,
                      color: CupertinoColors.secondaryLabel)),
              const SizedBox(height: 14),
              // FIX: give bounded width so UiKitView doesn't get infinite size
              SizedBox(
                width: 160,
                child: AdaptiveButton(
                  onPressed: () => _editProfile(context),
                  style: AdaptiveButtonStyle.tinted,
                  label: 'Edit Profile',
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 28),

        const _SectionTitle(title: 'Preferences'),
        AdaptiveCard(
          padding: const EdgeInsets.symmetric(vertical: 4),
          borderRadius: BorderRadius.circular(18),
          child: Column(
            children: [
              AdaptiveListTile(
                leading: const Icon(Icons.notifications_outlined,
                    color: Color(0xFF6C63FF)),
                title: const Text('Push Notifications'),
                trailing: AdaptiveSwitch(
                  value: _notifications,
                  onChanged: (v) =>
                      setState(() => _notifications = v),
                ),
              ),
              AdaptiveListTile(
                leading: const Icon(Icons.fingerprint,
                    color: Color(0xFF30D158)),
                title: const Text('Biometric Login'),
                trailing: AdaptiveSwitch(
                  value: _biometrics,
                  onChanged: (v) => setState(() => _biometrics = v),
                ),
              ),
              AdaptiveListTile(
                leading: const Icon(Icons.analytics_outlined,
                    color: Color(0xFFFFBF00)),
                title: const Text('Usage Analytics'),
                trailing: AdaptiveSwitch(
                  value: _analytics,
                  onChanged: (v) => setState(() => _analytics = v),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),
        const _SectionTitle(title: 'Account'),
        AdaptiveCard(
          padding: const EdgeInsets.symmetric(vertical: 4),
          borderRadius: BorderRadius.circular(18),
          child: Column(
            children: [
              AdaptiveListTile(
                leading: const Icon(Icons.lock_outline_rounded,
                    color: Color(0xFF43BBFF)),
                title: const Text('Change Password'),
                trailing: const Icon(CupertinoIcons.chevron_right,
                    size: 14,
                    color: CupertinoColors.tertiaryLabel),
                onTap: () {},
              ),
              AdaptiveListTile(
                leading: const Icon(Icons.privacy_tip_outlined,
                    color: Color(0xFF6C63FF)),
                title: const Text('Privacy Settings'),
                trailing: const Icon(CupertinoIcons.chevron_right,
                    size: 14,
                    color: CupertinoColors.tertiaryLabel),
                onTap: () {},
              ),
              AdaptiveListTile(
                leading: const Icon(Icons.logout_rounded,
                    color: Color(0xFFFF453A)),
                title: const Text('Sign Out',
                    style: TextStyle(color: Color(0xFFFF453A))),
                onTap: () => _confirmSignOut(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _editProfile(BuildContext ctx) {
    // FIX: no await, no result variable
    // FIX: capture text via onChanged into a local variable
    String? editedName;

    AdaptiveAlertDialog.show(
      context: ctx,
      title: 'Edit Display Name',
      message: 'Enter your new display name.',
      icon: 'person.crop.circle.fill',
      // FIX: no 'const' — closures cannot be const
      // input: AdaptiveAlertDialogInput(
      //   placeholder: 'Display name',
      //   initialValue: 'Alex Johnson',
      //   keyboardType: TextInputType.name,
      //   onChanged: (value) => editedName = value,
      // ),
      actions: [
        AlertAction(
          title: 'Cancel',
          style: AlertActionStyle.cancel,
          onPressed: () {},
        ),
        AlertAction(
          title: 'Update',
          style: AlertActionStyle.primary,
          // FIX: read editedName here — not from show() return value
          onPressed: () {
            final name = editedName;
            if (name != null && name.isNotEmpty) {
              AdaptiveSnackBar.show(
                ctx,
                message: 'Profile updated to "$name"',
                type: AdaptiveSnackBarType.success,
              );
            }
          },
        ),
      ],
    );
  }

  void _confirmSignOut(BuildContext ctx) {
    // FIX: no await needed — show() returns void
    AdaptiveAlertDialog.show(
      context: ctx,
      title: 'Sign Out?',
      message: 'You will need to sign in again to access your account.',
      icon: 'rectangle.portrait.and.arrow.forward',
      actions: [
        AlertAction(
          title: 'Cancel',
          style: AlertActionStyle.cancel,
          onPressed: () {},
        ),
        AlertAction(
          title: 'Sign Out',
          style: AlertActionStyle.destructive,
          onPressed: () => AdaptiveSnackBar.show(
            ctx,
            message: 'Signed out successfully',
            type: AdaptiveSnackBarType.info,
          ),
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// Shared helper widgets
// ──────────────────────────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
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