import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/gen/assets.gen.dart';
import 'package:flutter_riverpod_starter_template/src/localization/locale_keys.g.dart';
import 'package:flutter_riverpod_starter_template/src/shared/shared.dart';
import 'package:flutter_riverpod_starter_template/src/utils/extensions/context_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../routing/routing.dart';
import '../../../themes/themes.dart';
import '../data/onboarding_page_data.dart';
import 'onboarding_controller.dart';
import 'onboarding_dot.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();

  final List<OnboardingPageData> _pages = [
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

  // Use Riverpod state for current page
  late final StateProvider<int> _currentPageProvider;

  @override
  void initState() {
    super.initState();
    _currentPageProvider = StateProvider<int>((_) => 0);
  }

  void _onBack() {
    final currentPage = ref.read(_currentPageProvider);
    if (currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentPage = ref.watch(_currentPageProvider);
    final onboardingState = ref.watch(onboardingProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged:
                  (index) =>
                      ref.read(_currentPageProvider.notifier).state = index,
              itemBuilder: (context, index) {
                final page = _pages[index];
                return Column(
                  children: [
                    Image.asset(
                      page.image,
                      width: double.infinity,
                      height: 544.h,
                      cacheHeight: 544.h.toInt(),
                      cacheWidth: 428.w.toInt(),
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
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 32),
            margin: EdgeInsets.only(bottom: 20),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(24),
                Row(
                  children: [
                    ...List.generate(
                      _pages.length,
                      (i) => OnboardingDot(isActive: i == currentPage),
                    ),
                    const Spacer(),
                    if (currentPage > 0)
                      TextButton(
                        onPressed: _onBack,
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
                      width: currentPage == _pages.length - 1 ? 142 : 85,
                      onPressed: () async {
                        final currentPage = ref.read(_currentPageProvider);
                        if (currentPage < _pages.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          ref
                              .read(startupNotifierProvider.notifier)
                              .completeOnboardingAndSetUnauthenticated();
                          // Mark onboarding as complete in shared preferences
                          await ref
                              .read(onboardingProvider.notifier)
                              .completeOnboarding();
                          if (!context.mounted) return;
                          // Use GoRouter to navigate to login
                          context.go(AppRoute.login.path);
                        }
                      },
                      label:
                          currentPage == _pages.length - 1
                              ? LocaleKeys.onboarding_getStarted
                              : LocaleKeys.onboarding_next,
                    ),
                  ],
                ),
                if (onboardingState is AsyncLoading)
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                if (onboardingState is AsyncError)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      onboardingState.error.toString(),
                      style: const TextStyle(color: Colors.red),
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
