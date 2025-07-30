import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/difficulty_level.dart';
import '../models/math_problem.dart';
import '../services/math_service.dart';
import '../widgets/number_input_pad.dart';
import '../widgets/difficulty_toggle.dart';
import '../core/app_constants.dart';

/// Main screen of the math app.
class MathScreen extends StatefulWidget {
  const MathScreen({super.key});

  @override
  State<MathScreen> createState() => _MathScreenState();
}

class _MathScreenState extends State<MathScreen>
    with TickerProviderStateMixin {
  DifficultyLevel _selectedDifficulty = DifficultyLevel.easy;
  late MathProblem _activeProblem;
  String _userInput = '';
  bool _isShowingResult = false;
  bool _isAnswerCorrect = false;
  int _correctAnswerCount = 0;
  int _correctStreak = 0;

  late AnimationController _problemFadeController;
  late Animation<double> _problemFadeInAnimation;
  late AnimationController _streakController;
  late Animation<double> _streakScaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _generateNextProblem();
  }

  @override
  void dispose() {
    _problemFadeController.dispose();
    _streakController.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    _problemFadeController = AnimationController(
      duration: AppDurations.slow,
      vsync: this,
    );

    _problemFadeInAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _problemFadeController,
      curve: Curves.easeInOut,
    ));

    _streakController = AnimationController(
      duration: AppDurations.slow,
      vsync: this,
    );

    _streakScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _streakController,
      curve: Curves.easeInOut,
    ));
  }

  void _generateNextProblem() {
    _problemFadeController.reset();
    setState(() {
      _activeProblem =
          MathProblemGenerator.generateProblem(_selectedDifficulty);
      _userInput = '';
      _isShowingResult = false;
      _isAnswerCorrect = false;
    });
    _problemFadeController.forward();
  }

  void _handleNumberInput(String number) {
    if (_isShowingResult || _userInput.length >= 6) return;

    HapticFeedback.lightImpact();

    setState(() {
      _userInput += number;
    });
  }

  void _handleBackspace() {
    if (_isShowingResult || _userInput.isEmpty) return;

    HapticFeedback.selectionClick();

    setState(() {
      _userInput = _userInput.substring(0, _userInput.length - 1);
    });
  }

  void _handleClear() {
    if (_isShowingResult) return;

    HapticFeedback.mediumImpact();

    setState(() {
      _userInput = '';
    });
  }

  void _handleSubmitAnswer() {
    if (_isShowingResult || _userInput.isEmpty) return;

    final userAnswerInt = int.tryParse(_userInput);
    if (userAnswerInt == null) return;

    HapticFeedback.heavyImpact();

    setState(() {
      _isAnswerCorrect = userAnswerInt == _activeProblem.correctAnswer;
      _isShowingResult = true;
      if (_isAnswerCorrect) {
        _correctAnswerCount++;
        _correctStreak++;
        _streakController.forward();
      } else {
        _correctStreak = 0;
        _streakController.reverse();
      }
    });

    // Auto-advance to next problem
    Future.delayed(AppDurations.autoAdvance, () {
      if (mounted) {
        _generateNextProblem();
      }
    });
  }

  void _handleDifficultyChange(DifficultyLevel newDifficulty) {
    HapticFeedback.selectionClick();

    setState(() {
      _selectedDifficulty = newDifficulty;
      _correctStreak = 0;
    });
    _streakController.reverse();
    _generateNextProblem();
  }

  void _skipCurrentProblem() {
    if (_isShowingResult) return;

    HapticFeedback.lightImpact();
    setState(() {
      _correctStreak = 0;
    });
    _streakController.reverse();
    _generateNextProblem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.paddingLarge),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: (MediaQuery.of(context).size.height -
                         MediaQuery.of(context).padding.top -
                         MediaQuery.of(context).padding.bottom - 40).clamp(0, double.infinity),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                _buildDifficultySelector(),
                const SizedBox(height: AppSizes.paddingXLarge),
                _buildProblemSection(),
                const SizedBox(height: 10),
                _buildSkipButton(),
                const SizedBox(height: AppSizes.paddingSmall),
                _buildNumberPad(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Bullet Math', style: AppTextStyles.heading),
        Row(
          children: [
            _buildScoreContainer('$_correctAnswerCount', 'Total'),
            const SizedBox(width: AppSizes.paddingMedium),
            _buildScoreContainer('$_correctStreak', 'Streak'),
          ],
        ),
      ],
    );
  }

  Widget _buildScoreContainer(String value, String label) {
    final isStreak = label == 'Streak';
    final streakValue = isStreak ? int.tryParse(value) ?? 0 : 0;
    
    Color getStreakColor() {
      if (streakValue >= 15) return AppColors.success;
      if (streakValue >= 10) return AppColors.warning;
      if (streakValue >= 5) return AppColors.accent;
      return AppColors.accent;
    }
    
    Widget container = Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingMedium,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundDark,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
        boxShadow: [
          BoxShadow(
            color: (isStreak ? getStreakColor() : AppColors.accent).withOpacity(0.3),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value, 
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: isStreak ? getStreakColor() : AppColors.accent,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );

    if (isStreak) {
      return AnimatedBuilder(
        animation: _streakScaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _streakScaleAnimation.value,
            child: container,
          );
        },
      );
    }
    
    return container;
  }

  Widget _buildDifficultySelector() {
    return DifficultyToggle(
      currentDifficulty: _selectedDifficulty,
      onDifficultyChanged: _handleDifficultyChange,
    );
  }

  Widget _buildProblemSection() {
    return AnimatedBuilder(
      animation: _problemFadeInAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _problemFadeInAnimation.value,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingXLarge, vertical: 0),
            decoration: BoxDecoration(
              color: AppColors.backgroundDark,
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
            ),
            child: Column(
              children: [
                Text(
                  _isShowingResult && !_isAnswerCorrect 
                    ? '${_activeProblem.firstOperand} ${_activeProblem.operation.symbol} ${_activeProblem.secondOperand} = ${_activeProblem.correctAnswer}'
                    : _activeProblem.questionText,
                  style: AppTextStyles.questionText, 
                  textAlign: TextAlign.center
                ),
                const SizedBox(height: 24),
                _InteractiveAnswerInput(
                  userAnswer: _userInput,
                  showResult: _isShowingResult,
                  isCorrect: _isAnswerCorrect,
                  correctAnswer: _activeProblem.correctAnswer,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSkipButton() {
    return SizedBox(
      height: AppSizes.buttonHeight,
      child: Center(
        child: SizedBox(
          width: 120,
          height: 40,
          child: _InteractiveSkipButton(
            onPressed: _isShowingResult ? null : _skipCurrentProblem,
            enabled: !_isShowingResult,
          ),
        ),
      ),
    );
  }

  Widget _buildNumberPad() {
    return NumberInputPad(
      onNumberInput: _handleNumberInput,
      onBackspace: _handleBackspace,
      onClear: _handleClear,
      onSubmit: _handleSubmitAnswer,
    );
  }
}

/// An interactive skip button.
class _InteractiveSkipButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool enabled;

  const _InteractiveSkipButton({
    required this.onPressed,
    required this.enabled,
  });

  @override
  State<_InteractiveSkipButton> createState() => _InteractiveSkipButtonState();
}

class _InteractiveSkipButtonState extends State<_InteractiveSkipButton> {
  bool _isHovered = false;

  Color get _backgroundColor {
    if (!widget.enabled) {
      return AppColors.backgroundDark;
    }
    if (_isHovered) {
      return AppColors.accent.withOpacity(0.2);
    }
    return AppColors.accent.withOpacity(0.1);
  }

  Color get _textColor {
    if (!widget.enabled) {
      return AppColors.textTertiary;
    }
    if (_isHovered) {
      return AppColors.accent;
    }
    return AppColors.accent.withOpacity(0.8);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: widget.enabled ? (_) => setState(() => _isHovered = true) : null,
      onExit: widget.enabled ? (_) => setState(() => _isHovered = false) : null,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          width: double.infinity,
          height: AppSizes.buttonHeight,
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.skip_next_rounded,
                size: 20,
                color: _textColor,
              ),
              const SizedBox(width: 8),
              Text(
                'SKIP',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                  color: _textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// An interactive answer input field.
class _InteractiveAnswerInput extends StatefulWidget {
  final String userAnswer;
  final bool showResult;
  final bool isCorrect;
  final int correctAnswer;

  const _InteractiveAnswerInput({
    required this.userAnswer,
    required this.showResult,
    required this.isCorrect,
    required this.correctAnswer,
  });

  @override
  State<_InteractiveAnswerInput> createState() =>
      _InteractiveAnswerInputState();
}

class _InteractiveAnswerInputState extends State<_InteractiveAnswerInput> {
  bool _isHovered = false;

  Color get _borderColor {
    if (widget.showResult) {
      return widget.isCorrect ? AppColors.success : AppColors.error;
    }
    if (_isHovered) {
      return AppColors.accent.withOpacity(0.8);
    }
    return AppColors.accent;
  }

  Color get _shadowColor {
    if (widget.showResult) {
      return widget.isCorrect
          ? AppColors.success.withOpacity(0.3)
          : AppColors.error.withOpacity(0.3);
    }
    if (_isHovered) {
      return AppColors.accent.withOpacity(0.4);
    }
    return AppColors.accent.withOpacity(0.2);
  }

  double get _shadowBlur {
    if (_isHovered && !widget.showResult) {
      return 16;
    }
    return 12;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppDurations.normal,
        curve: Curves.easeOut,
        width: double.infinity,
        height: 80,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingXLarge,
          vertical: AppSizes.paddingMedium,
        ),
        decoration: BoxDecoration(
          color: AppColors.backgroundDark,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
          border: Border.all(
            color: _borderColor,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: _shadowColor,
              blurRadius: _shadowBlur,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.userAnswer.isEmpty && !widget.showResult)
              AnimatedDefaultTextStyle(
                duration: AppDurations.normal,
                curve: Curves.easeOut,
                style: TextStyle(
                  fontSize: 32,
                  color: _isHovered
                      ? AppColors.textHover
                      : AppColors.textSecondary,
                  fontWeight: FontWeight.w300,
                ),
                child: const Text('?'),
              )
            else
              Text(
                widget.userAnswer,
                style: AppTextStyles.answerText,
              ),
            if (widget.showResult) ...[
              const SizedBox(width: 16),
              Icon(
                widget.isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                color: widget.isCorrect ? AppColors.success : AppColors.error,
                size: AppSizes.iconSizeLarge,
              ),
            ],
          ],
        ),
      ),
    );
  }
} 