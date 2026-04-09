//
// import 'package:abldriver/widget/customPageRefresher.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
//
// import '../../../app/theme/color_resource.dart';
// import '../../../widget/custom_App_bar.dart';
// import '../../../widget/custom_text.dart';
// import '../provider/cmsProvider.dart';
//
// class PrivaCyPolicy extends StatefulWidget {
//   const PrivaCyPolicy({super.key});
//
//   @override
//   State<PrivaCyPolicy> createState() => _PrivaCyPolicyState();
// }
//
// class _PrivaCyPolicyState extends State<PrivaCyPolicy> {
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<CmsProvider>().fetchCmsData();
//     });
//   }
//
//   String parseHtmlString(String htmlString) {
//     final regex = RegExp(r'<[^>]*>');
//     return htmlString.replaceAll(regex, '');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CmsProvider>(
//       builder: (context, provider, child) {
//
//         if (provider.loading) {
//           return const Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }
//
//         final cmsData = provider.getCmsData;
//         final terms = cmsData?.cmsData?.privacyPolicy;
//
//         if (terms == null || terms.isEmpty) {
//           return Scaffold(
//             appBar: CustomAppBar(title: 'Privacy Policy'),
//             body: const Center(
//               child: CustomText(
//                 'No Terms & Conditions available.',
//                 size: 14,
//               ),
//             ),
//           );
//         }
//
//         return Scaffold(
//           backgroundColor: ColorResource.white,
//           appBar: CustomAppBar(title: 'Privacy Policy'),
//           body: CustomPageRefresher(
//               onRefresh: () async {
//                 context.read<CmsProvider>().fetchCmsData();
//               },
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(16),
//                 child: CustomText(
//                   parseHtmlString(terms),
//                   size: 14,
//                 ),
//               ),
//           )
//
//
//         );
//       },
//     );
//   }
// }


import 'package:abldriver/widget/customPageRefresher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';

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
        final privacyPolicy = cmsData?.cmsData?.privacyPolicy ?? '';

        if (privacyPolicy.isEmpty) {
          return Scaffold(
            backgroundColor: ColorResource.white,
            appBar: CustomAppBar(title: 'Privacy Policy'),
            body: const Center(
              child: CustomText(
                'No Privacy Policy available.',
                size: 14,
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: CustomAppBar(title: 'Privacy Policy'),
          body: CustomPageRefresher(
            onRefresh: () async {
              await context.read<CmsProvider>().fetchCmsData();
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: ColorResource.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Html(
                  data: privacyPolicy,
                  style: {
                    "body": Style(
                      margin: Margins.zero,
                      padding: HtmlPaddings.zero,
                      fontSize: FontSize(15),
                      color: Colors.black87,
                      lineHeight: const LineHeight(1.6),
                      fontWeight: FontWeight.w400,
                    ),
                    "p": Style(
                      margin: Margins.only(bottom: 14),
                    ),
                    "h1": Style(
                      fontSize: FontSize(26),
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F172A),
                      margin: Margins.only(bottom: 14, top: 10),
                    ),
                    "h2": Style(
                      fontSize: FontSize(20),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B),
                      margin: Margins.only(bottom: 12, top: 18),
                    ),
                    "h3": Style(
                      fontSize: FontSize(17),
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF334155),
                      margin: Margins.only(bottom: 10, top: 14),
                    ),
                    "ul": Style(
                      margin: Margins.only(left: 10, bottom: 14),
                      padding: HtmlPaddings.only(left: 10),
                    ),
                    "li": Style(
                      margin: Margins.only(bottom: 8),
                      fontSize: FontSize(15),
                      lineHeight: const LineHeight(1.5),
                    ),
                    "strong": Style(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF111827),
                    ),
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}