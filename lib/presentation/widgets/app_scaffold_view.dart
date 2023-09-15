import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// AppScaffoldView widget is used as core template widget which provides
/// functional selection of safe area and status bar color
/// safeAreaColor: Color of the safe area
/// child: Widget to be wrapped
/// bottomNavigationBar: Bottom navigation bar implementation
class AppScaffoldView extends StatelessWidget {
  const AppScaffoldView({
    super.key,
    this.safeAreaColor,
    required this.body,
    this.bottomNavigationBar,
    this.top = true,
    this.bottom = true,
    this.left = true,
    this.right = true,
    this.appBar,
    this.bottomSheet,
    this.backgroundColor,
  });

  final Color? safeAreaColor;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomSheet;
  final Widget? bottomNavigationBar;

  final bool top;
  final bool bottom;
  final bool left;
  final bool right;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: safeAreaColor,
        ),
        child: SafeArea(
          top: top,
          bottom: bottom,
          left: left,
          right: right,
          child: SizedBox(width: double.infinity, height: double.infinity, child: body),
        ),
      ),
      bottomSheet: bottomSheet,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
