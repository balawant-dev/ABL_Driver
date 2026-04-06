
import 'package:abldriver/widget/customPageRefresher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../app/theme/color_resource.dart';
import '../../../widget/custom_App_bar.dart';
import '../../../widget/custom_text.dart';
import '../provider/cmsProvider.dart';

class PrivaCyPolicy extends StatefulWidget {
  const PrivaCyPolicy({super.key});

  @override
  State<PrivaCyPolicy> createState() => _PrivaCyPolicyState();
}

class _PrivaCyPolicyState extends State<PrivaCyPolicy> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CmsProvider>().fetchCmsData();
    });
  }

  String parseHtmlString(String htmlString) {
    final regex = RegExp(r'<[^>]*>');
    return htmlString.replaceAll(regex, '');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CmsProvider>(
      builder: (context, provider, child) {

        if (provider.loading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final cmsData = provider.getCmsData;
        final terms = cmsData?.cmsData?.privacyPolicy;

        if (terms == null || terms.isEmpty) {
          return Scaffold(
            appBar: CustomAppBar(title: 'Privacy Policy'),
            body: const Center(
              child: CustomText(
                'No Terms & Conditions available.',
                size: 14,
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: ColorResource.white,
          appBar: CustomAppBar(title: 'Privacy Policy'),
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
