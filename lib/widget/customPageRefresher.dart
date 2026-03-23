
import 'package:abldriver/app/theme/color_resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPageRefresher extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;

  const CustomPageRefresher({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: ColorResource.buttonBackground,
      backgroundColor: ColorResource.white,
      child: child is ScrollView
          ? child
          : SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: child,
      ),
    );
  }
}
