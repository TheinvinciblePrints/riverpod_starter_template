import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_starter_template/src/gen/assets.gen.dart';
import 'package:flutter_riverpod_starter_template/src/localization/locale_keys.g.dart';
import 'package:flutter_riverpod_starter_template/src/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../themes/themes.dart';
import '../data/onboarding_page_data.dart';
import 'widgets/onboarding_dot.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPageData> _pages = [
    OnboardingPageData(
      image: AppAssets.images.onboardingImage1.path,
      title: 'Lorem Ipsum is simply dummy',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    ),
    OnboardingPageData(
      image: AppAssets.images.onboardingImage2.path,
      title: 'Lorem Ipsum is simply dummy',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    ),
    OnboardingPageData(
      image: AppAssets.images.onboardingImage3.path,
      title: 'Lorem Ipsum is simply dummy',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    ),
  ];

  void _onNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // TODO: Handle Get Started (navigate to home or login)
    }
  }

  void _onBack() {
    if (_currentPage > 0) {
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemBuilder: (context, index) {
                final page = _pages[index];
                return Column(
                  children: [
                    Image.asset(
                      page.image,
                      width: double.infinity,
                      height: 584.h, // Using ScreenUtil for responsive design
                      cacheHeight: 584.h.toInt(),
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
          SafeArea(
            top: false,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 32),
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(24),
                  Row(
                    children: [
                      ...List.generate(
                        _pages.length,
                        (i) => OnboardingDot(isActive: i == _currentPage),
                      ),
                      const Spacer(),
                      if (_currentPage > 0)
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
                        width: _currentPage == _pages.length - 1 ? 142 : 85,
                        onPressed: _onNext,
                        label:
                            _currentPage == _pages.length - 1
                                ? LocaleKeys.onboarding_getStarted
                                : LocaleKeys.onboarding_next,
                      ),
                    ],
                  ),
                ],
              ),
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
          Text(
            title,
            style: AppTextStyles.displaySmallBold.copyWith(color: Colors.black),
          ),

          Text(
            description,
            style: AppTextStyles.textMedium.copyWith(color: AppColors.bodyText),
          ),
        ],
      ),
    );
  }
}
