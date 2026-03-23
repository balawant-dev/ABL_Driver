
import 'package:abldriver/widget/customPageRefresher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../app/theme/color_resource.dart';
import '../../../widget/custom_App_bar.dart';
import '../../../widget/custom_text.dart';
import '../provider/cmsProvider.dart';

class TermsAndCondition extends StatefulWidget {
  const TermsAndCondition({super.key});

  @override
  State<TermsAndCondition> createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {

  @override
  void initState() {
    super.initState();

    /// Call API after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CmsProvider>().fetchCmsData();
    });
  }

  /// Remove HTML tags safely
  String parseHtmlString(String htmlString) {
    final regex = RegExp(r'<[^>]*>');
    return htmlString.replaceAll(regex, '');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CmsProvider>(
      builder: (context, provider, child) {

        /// 1️⃣ Loading state
        if (provider.loading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        /// 2️⃣ Null / empty data check
        final cmsData = provider.getCmsData;
        final terms = cmsData?.cmsData?.termAndConditions;

        if (terms == null || terms.isEmpty) {
          return Scaffold(
            appBar: CustomAppBar(title: 'Terms And Condition'),
            body: const Center(
              child: CustomText(
                'No Terms & Conditions available.',
                size: 14,
              ),
            ),
          );
        }

        /// 3️⃣ Success state
        return Scaffold(
          backgroundColor: ColorResource.white,
          appBar: CustomAppBar(title: 'Terms And Condition'),
          body: CustomPageRefresher(
              onRefresh: () async {
                context.read<CmsProvider>().fetchCmsData();
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: CustomText(
                  parseHtmlString(terms),
                  size: 14,
                ),
              ),
          )

        );
      },
    );
  }
}
