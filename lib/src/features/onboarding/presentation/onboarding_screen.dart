import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod_starter_template/src/gen/assets.gen.dart';
import 'package:flutter_riverpod_starter_template/src/localization/locale_keys.g.dart';
import 'package:flutter_riverpod_starter_template/src/shared/shared.dart';
import 'package:flutter_riverpod_starter_template/src/utils/extensions/context_extensions.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../routing/routing.dart';
import '../../../themes/themes.dart';
import '../application/onboarding_logic.dart';
import '../domain/onboarding_page_data.dart';
import 'onboarding_dot.dart';

class OnboardingScreen extends HookConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
    final currentPage = useState(0);

    final List<OnboardingPageData> pages = [
      OnboardingPageData(
        image: AppAssets.images.onboardingImage1.path,
        title: LocaleKeys.onboarding_pageOneTitle.tr(),
        description: LocaleKeys.onboarding_pageOneSubTitle.tr(),
      ),
      OnboardingPageData(
        image: AppAssets.images.onboardingImage2.path,
        title: LocaleKeys.onboarding_pageTwoTitle.tr(),
        description: LocaleKeys.onboarding_pageTwoSubTitle.tr(),
      ),
      OnboardingPageData(
        image: AppAssets.images.onboardingImage3.path,
        title: LocaleKeys.onboarding_pageThreeTitle.tr(),
        description: LocaleKeys.onboarding_pageThreeSubTitle.tr(),
      ),
    ];

    useEffect(() {
      void listener() {
        final page = pageController.page?.round() ?? 0;
        if (page != currentPage.value) {
          currentPage.value = page;
        }
      }

      pageController.addListener(listener);
      return () => pageController.removeListener(listener);
    }, [pageController]);

    void onBack() {
      if (currentPage.value > 0) {
        pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: pages.length,
              onPageChanged: (index) => currentPage.value = index,
              itemBuilder: (context, index) {
                final page = pages[index];
                return Column(
                  children: [
                    Image.asset(
                      page.image,
                      width: double.infinity,
                      height: context.screenHeight * 0.58,
                      cacheHeight: (context.screenHeight * 0.58).toInt(),
                      cacheWidth: (context.screenHeight * 0.46).toInt(),
                      fit: BoxFit.cover,
                    ),

                    _OnboardingPageContent(
                      title: page.title,
                      description: page.description,
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
            margin: EdgeInsets.only(bottom: 30),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ...List.generate(
                      pages.length,
                      (i) => OnboardingDot(isActive: i == currentPage.value),
                    ),
                    const Spacer(),
                    if (currentPage.value > 0)
                      TextButton(
                        onPressed: onBack,
                        style: TextButton.styleFrom(
                          overlayColor: Colors.transparent,
                        ),
                        child: Text(
                          context.tr(LocaleKeys.onboarding_back),
                          style: AppTextStyles.linkMedium.copyWith(
                            color: AppColors.darkBody,
                          ),
                        ),
                      ),

                    PrimaryButton(
                      width: currentPage.value == pages.length - 1 ? 142 : 85,
                      onPressed: () async {
                        if (currentPage.value < pages.length - 1) {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          ref
                              .read(startupNotifierProvider.notifier)
                              .completeOnboardingAndSetUnauthenticated();
                          // Mark onboarding as complete in shared preferences
                          await ref.read(completeOnboardingProvider.future);
                          if (!context.mounted) return;
                          // Use GoRouter to navigate to login
                          context.go(AppRoute.login.path);
                        }
                      },
                      label:
                          currentPage.value == pages.length - 1
                              ? LocaleKeys.onboarding_getStarted
                              : LocaleKeys.onboarding_next,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingPageContent extends StatelessWidget {
  const _OnboardingPageContent({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 24, right: 86),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: context.textTheme.onboardingTitle),

          Text(description, style: context.textTheme.onboardingDescription),
        ],
      ),
    );
  }
}
