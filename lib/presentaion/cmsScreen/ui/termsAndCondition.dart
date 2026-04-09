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
// class TermsAndCondition extends StatefulWidget {
//   const TermsAndCondition({super.key});
//
//   @override
//   State<TermsAndCondition> createState() => _TermsAndConditionState();
// }
//
// class _TermsAndConditionState extends State<TermsAndCondition> {
//
//   @override
//   void initState() {
//     super.initState();
//
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
//         final terms = cmsData?.cmsData?.termAndConditions;
//
//         if (terms == null || terms.isEmpty) {
//           return Scaffold(
//             appBar: CustomAppBar(title: 'Terms And Condition'),
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
//           appBar: CustomAppBar(title: 'Terms And Condition'),
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

class TermsAndCondition extends StatefulWidget {
  const TermsAndCondition({super.key});

  @override
  State<TermsAndCondition> createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
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
        final terms = cmsData?.cmsData?.termAndConditions ?? '';

        if (terms.isEmpty) {
          return Scaffold(
            backgroundColor: ColorResource.white,
            appBar: CustomAppBar(title: 'Terms & Conditions'),
            body: const Center(
              child: CustomText(
                'No Terms & Conditions available.',
                size: 14,
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: CustomAppBar(title: 'Terms & Conditions'),
          body: CustomPageRefresher(
            onRefresh: () async {
              await context.read<CmsProvider>().fetchCmsData();
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Top Banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF0F172A),
                          Color(0xFF1E293B),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.gavel_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Terms & Conditions',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Please read the terms carefully before using the app.',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// Main Content Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: const Color(0xFFE2E8F0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Html(
                      data: terms,
                      style: {
                        "body": Style(
                          margin: Margins.zero,
                          padding: HtmlPaddings.zero,
                          fontSize: FontSize(15),
                          color: const Color(0xFF334155),
                          lineHeight: const LineHeight(1.7),
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
                          color: const Color(0xFF0F172A),
                          margin: Margins.only(top: 22, bottom: 12),
                          padding: HtmlPaddings.only(bottom: 6),
                          border: Border(
                            bottom: BorderSide(
                              color: const Color(0xFFE2E8F0),
                              width: 1,
                            ),
                          ),
                        ),

                        "h3": Style(
                          fontSize: FontSize(17),
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E293B),
                          margin: Margins.only(top: 16, bottom: 10),
                        ),

                        "ul": Style(
                          margin: Margins.only(left: 6, bottom: 14),
                          padding: HtmlPaddings.only(left: 14),
                        ),

                        "ol": Style(
                          margin: Margins.only(left: 6, bottom: 14),
                          padding: HtmlPaddings.only(left: 14),
                        ),

                        "li": Style(
                          margin: Margins.only(bottom: 10),
                          fontSize: FontSize(15),
                          lineHeight: const LineHeight(1.6),
                        ),

                        "strong": Style(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF111827),
                        ),

                        "br": Style(
                          lineHeight: const LineHeight(1.5),
                        ),
                      },
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}