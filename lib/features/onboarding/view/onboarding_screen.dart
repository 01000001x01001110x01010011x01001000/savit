import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savit/features/auth/view/login_screen.dart';
import 'package:savit/features/language/bloc/language_cubit.dart';
import 'package:savit/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:savit/helper_classes/app_colors.dart';
import 'package:savit/helper_classes/app_text_styles.dart';
import 'package:savit/localization/app_localizations.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  static const int _indicatorCount = 3;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _completeOnboarding() {
    context.read<OnboardingBloc>().add(const OnboardingCompleted());
  }

  void _onPrimaryPressed() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOut,
      );
      return;
    }

    _completeOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final String languageCode = context.watch<LanguageCubit>().state.languageCode;

    return BlocListener<OnboardingBloc, OnboardingState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == OnboardingStatus.completed,
      listener: (context, state) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.onboardingBackground,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _completeOnboarding,
                    child: Text(l10n.skip, style: AppTextStyles.onboardingSkip),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (int index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    children: <Widget>[
                      _ManageLeadsPage(l10n: l10n),
                      _RunHealthEvaluationsPage(l10n: l10n),
                      _TrackCustomerProgressPage(
                        l10n: l10n,
                        languageCode: languageCode,
                        onSelectEnglish: () {
                          context.read<LanguageCubit>().setEnglish();
                        },
                        onSelectHindi: () {
                          context.read<LanguageCubit>().setHindi();
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(_indicatorCount, (int index) {
                    final bool isActive = index == _currentPage;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 6,
                      ),
                      child: isActive
                          ? Container(
                              width: 30,
                              height: 12,
                              decoration: BoxDecoration(
                                color: AppColors.baseGreenColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            )
                          : const _Dot(),
                    );
                  }),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 64,
                  child: ElevatedButton(
                    onPressed: _onPrimaryPressed,
                    style: Theme.of(context).elevatedButtonTheme.style,
                    child: _currentPage == 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                l10n.continueText,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Icon(Icons.arrow_forward, size: 28),
                            ],
                          )
                        : Text(
                            _currentPage == 1 ? l10n.next : l10n.getStarted,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ManageLeadsPage extends StatelessWidget {
  const _ManageLeadsPage({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(flex: 1),
        Container(
          height: 340,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.onboardingLightCard,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 42,
                left: 32,
                right: 32,
                bottom: 32,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.onboardingInnerCard,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Container(
                      width: 230,
                      height: 230,
                      decoration: BoxDecoration(
                        color: AppColors.baseGreenColor,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Icon(
                        Icons.groups_rounded,
                        color: Colors.white,
                        size: 68,
                      ),
                    ),
                  ),
                ),
              ),
              const Positioned(
                top: 44,
                right: 44,
                child: _MiniIcon(
                  color: AppColors.baseGreenColor,
                  icon: Icons.trending_up_rounded,
                ),
              ),
              const Positioned(
                left: 20,
                bottom: 50,
                child: _MiniIcon(
                  color: Color(0xFFC45F56),
                  icon: Icons.check_rounded,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 42),
        Text(l10n.manageLeadsTitle, style: AppTextStyles.onboardingTitleMedium),
        const SizedBox(height: 14),
        Text(
          l10n.manageLeadsSubtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF37444A),
            fontSize: 18,
            height: 1.4,
            fontWeight: FontWeight.w400,
          ),
        ),
        const Spacer(flex: 2),
      ],
    );
  }
}

class _RunHealthEvaluationsPage extends StatelessWidget {
  const _RunHealthEvaluationsPage({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(flex: 1),
        Container(
          width: 260,
          height: 260,
          decoration: BoxDecoration(
            color: AppColors.onboardingInnerCard,
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Center(
            child: Icon(
              Icons.assignment_ind_rounded,
              size: 96,
              color: AppColors.baseGreenColor,
            ),
          ),
        ),
        const SizedBox(height: 56),
        Text(
          l10n.evaluationsTitle,
          textAlign: TextAlign.center,
          style: AppTextStyles.onboardingTitle,
        ),
        const SizedBox(height: 20),
        Text(
          l10n.evaluationsSubtitle,
          textAlign: TextAlign.center,
          style: AppTextStyles.onboardingSubtitle,
        ),
        const Spacer(flex: 2),
      ],
    );
  }
}

class _TrackCustomerProgressPage extends StatelessWidget {
  const _TrackCustomerProgressPage({
    required this.l10n,
    required this.languageCode,
    required this.onSelectEnglish,
    required this.onSelectHindi,
  });

  final AppLocalizations l10n;
  final String languageCode;
  final VoidCallback onSelectEnglish;
  final VoidCallback onSelectHindi;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFAEC2B5), width: 1.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color(0xFFAEC2B5), width: 1.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    InkWell(
                      onTap: onSelectEnglish,
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: languageCode == 'en'
                            ? AppColors.onboardingInnerCard
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: <Widget>[
                          if (languageCode == 'en') ...<Widget>[
                            const Icon(
                              Icons.check_rounded,
                              size: 26,
                              color: Color(0xFF5F6A7D),
                            ),
                            const SizedBox(width: 8),
                          ],
                          Text(
                            l10n.english,
                            style: const TextStyle(
                              color: Color(0xFF5F6A7D),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ),
                    const SizedBox(width: 16),
                    InkWell(
                      onTap: onSelectHindi,
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: languageCode == 'hi'
                              ? AppColors.onboardingInnerCard
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: <Widget>[
                            if (languageCode == 'hi') ...<Widget>[
                              const Icon(
                                Icons.check_rounded,
                                size: 26,
                                color: Color(0xFF5F6A7D),
                              ),
                              const SizedBox(width: 8),
                            ],
                            Text(
                              l10n.hindi,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF242A2E),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ),
            const Spacer(flex: 2),
            Container(
              width: 230,
              height: 230,
              decoration: BoxDecoration(
                color: AppColors.baseGreenColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.trending_up_rounded,
                color: Colors.white,
                size: 88,
              ),
            ),
            const SizedBox(height: 58),
            Text(
              l10n.trackProgressTitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.onboardingTitle,
            ),
            const SizedBox(height: 20),
            Text(
              l10n.trackProgressSubtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.onboardingSubtitle,
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}

class _MiniIcon extends StatelessWidget {
  const _MiniIcon({required this.color, required this.icon});

  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white, size: 26),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: const BoxDecoration(
        color: Color(0xFFD3D8D5),
        shape: BoxShape.circle,
      ),
    );
  }
}
