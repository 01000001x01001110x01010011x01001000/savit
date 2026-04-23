import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savit/features/language/bloc/language_cubit.dart';
import 'package:savit/helper_classes/app_colors.dart';
import 'package:savit/localization/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const int _otpLength = 6;
  static const int _mobileLength = 10;

  late final TextEditingController _mobileController;
  late final FocusNode _mobileFocusNode;
  late final List<TextEditingController> _otpControllers;
  late final List<FocusNode> _otpFocusNodes;
  bool _isOtpSectionVisible = false;

  @override
  void initState() {
    super.initState();
    _mobileController = TextEditingController();
    _mobileFocusNode = FocusNode();
    _otpControllers = List<TextEditingController>.generate(
      _otpLength,
      (_) => TextEditingController(),
    );
    _otpFocusNodes = List<FocusNode>.generate(_otpLength, (_) => FocusNode());

    for (final TextEditingController controller in _otpControllers) {
      controller.addListener(_onOtpChanged);
    }
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _mobileFocusNode.dispose();
    for (final TextEditingController controller in _otpControllers) {
      controller
        ..removeListener(_onOtpChanged)
        ..dispose();
    }
    for (final FocusNode node in _otpFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onOtpChanged() {
    setState(() {});
  }

  String get _otpValue =>
      _otpControllers.map((TextEditingController c) => c.text).join();

  bool get _isOtpComplete =>
      _otpControllers.every((TextEditingController c) => c.text.isNotEmpty);

  void _handleOtpInput(String value, int index) {
    final String normalized = value.isEmpty ? '' : value[value.length - 1];
    _otpControllers[index]
      ..text = normalized
      ..selection = TextSelection.collapsed(offset: normalized.length);

    if (normalized.isNotEmpty && index < _otpLength - 1) {
      _otpFocusNodes[index + 1].requestFocus();
    }

    if (normalized.isEmpty && index > 0) {
      _otpFocusNodes[index - 1].requestFocus();
    }
  }

  void _sendOtp(AppLocalizations l10n) {
    final String mobile = _mobileController.text.trim();
    if (mobile.length != _mobileLength) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.phoneInvalid)),
      );
      _mobileFocusNode.requestFocus();
      return;
    }

    for (final TextEditingController controller in _otpControllers) {
      controller.clear();
    }
    setState(() {
      _isOtpSectionVisible = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.otpSent)),
    );
    _otpFocusNodes.first.requestFocus();
  }

  void _verifyOtp(AppLocalizations l10n) {
    if (_otpValue.length != _otpLength) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.otpInvalid)),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${l10n.otpSubmitted}: $_otpValue')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final String languageCode =
        context.watch<LanguageCubit>().state.languageCode;

    return Scaffold(
      backgroundColor: AppColors.onboardingBackground,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 18),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () =>
                                  context.read<LanguageCubit>().setHindi(),
                              child: Text(
                                l10n.hindiDisplay,
                                style: TextStyle(
                                  color: languageCode == 'hi'
                                      ? AppColors.baseGreenColor
                                      : const Color(0xFF2D3A34),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const Text(
                              ' / ',
                              style: TextStyle(
                                color: AppColors.baseGreenColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  context.read<LanguageCubit>().setEnglish(),
                              child: Text(
                                l10n.enShort,
                                style: TextStyle(
                                  color: languageCode == 'en'
                                      ? AppColors.baseGreenColor
                                      : const Color(0xFF2D3A34),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.5),
                            border: Border.all(
                                color: const Color(0xFFAFC0B7), width: 1.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 18,
                            ),
                            child: Column(
                              children: <Widget>[
                                const SizedBox(height: 8),
                                Container(
                                  width: 86,
                                  height: 86,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0A8C68),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: const Icon(
                                    Icons.medical_services_rounded,
                                    color: Colors.white,
                                    size: 46,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  l10n.loginTitle,
                                  style: const TextStyle(
                                    color: AppColors.baseGreenColor,
                                    fontSize: 68 / 2,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  l10n.loginSubtitle,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF2E3A36),
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    l10n.phoneNumber,
                                    style: const TextStyle(
                                      color: Color(0xFF131818),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  height: 40,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 106,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color(0xFFAFC0B7),
                                            width: 1.2,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4),
                                            bottomLeft: Radius.circular(4),
                                          ),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            '+91',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xFF222A2E),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color(0xFFAFC0B7),
                                              width: 1.2,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topRight: Radius.circular(4),
                                              bottomRight: Radius.circular(4),
                                            ),
                                          ),
                                          child: TextField(
                                            controller: _mobileController,
                                            focusNode: _mobileFocusNode,
                                            keyboardType: TextInputType.phone,
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              LengthLimitingTextInputFormatter(
                                                _mobileLength,
                                              ),
                                            ],
                                            decoration: InputDecoration(
                                              hintText: l10n.enterMobileNumber,
                                              hintStyle: const TextStyle(
                                                color: Color(0xFF6E7688),
                                                fontSize: 22 / 1.5,
                                              ),
                                              border: InputBorder.none,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 14,
                                                vertical: 11,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 26),
                                SizedBox(
                                  width: double.infinity,
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: () => _sendOtp(l10n),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.baseGreenColor,
                                      foregroundColor: Colors.white,
                                      shape: const RoundedRectangleBorder(),
                                    ),
                                    child: Text(
                                      l10n.sendOtp,
                                      style: const TextStyle(
                                        fontSize: 22 / 1.3,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                if (_isOtpSectionVisible) ...<Widget>[
                                  const SizedBox(height: 26),
                                  Row(
                                    children: <Widget>[
                                      const Expanded(
                                        child: Divider(
                                          color: Color(0xFFAFC0B7),
                                          thickness: 1.2,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 18,
                                        ),
                                        child: Text(
                                          l10n.or,
                                          style: const TextStyle(
                                            color: Color(0xFF232A2B),
                                            fontSize: 22 / 1.3,
                                          ),
                                        ),
                                      ),
                                      const Expanded(
                                        child: Divider(
                                          color: Color(0xFFAFC0B7),
                                          thickness: 1.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 26),
                                  Text(
                                    l10n.enterOtp,
                                    style: const TextStyle(
                                      color: Color(0xFF8A8E8F),
                                      fontSize: 22 / 1.3,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 18),
                                  Row(
                                    children: List<Widget>.generate(_otpLength,
                                        (int i) {
                                      return Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            right: i == _otpLength - 1 ? 0 : 6,
                                          ),
                                          child: _OtpInputBox(
                                            controller: _otpControllers[i],
                                            focusNode: _otpFocusNodes[i],
                                            onChanged: (String value) {
                                              _handleOtpInput(value, i);
                                            },
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                  const SizedBox(height: 28),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 64,
                                    child: OutlinedButton(
                                      onPressed: _isOtpComplete
                                          ? () => _verifyOtp(l10n)
                                          : null,
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color: _isOtpComplete
                                              ? AppColors.baseGreenColor
                                              : const Color(0xFFAEAEAE),
                                          width: 1.5,
                                        ),
                                        shape: const RoundedRectangleBorder(),
                                      ),
                                      child: Text(
                                        l10n.verify,
                                        style: TextStyle(
                                          color: _isOtpComplete
                                              ? AppColors.baseGreenColor
                                              : const Color(0xFF9FA2A3),
                                          fontSize: 22 / 1.25,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                const Spacer(),
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '${l10n.termsLine} ',
                                      style: const TextStyle(
                                        color: Color(0xFF2E3A36),
                                        fontSize: 22 / 1.3,
                                      ),
                                    ),
                                    Text(
                                      l10n.terms,
                                      style: const TextStyle(
                                        color: AppColors.baseGreenColor,
                                        fontSize: 22 / 1.3,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _OtpInputBox extends StatelessWidget {
  const _OtpInputBox({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD1D1D1), width: 1.2),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          onChanged: onChanged,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          style: const TextStyle(
            color: Color(0xFF2D3235),
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
