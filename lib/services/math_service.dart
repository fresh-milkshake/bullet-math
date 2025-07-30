import 'dart:math';
import '../models/math_problem.dart';
import '../models/difficulty_level.dart';

/// Service for generating mathematical problems.
class MathProblemGenerator {
  static final Random _rng = Random();

  /// Generates a new math problem for the given difficulty.
  static MathProblem generateProblem(
    DifficultyLevel difficulty, {
    MathOperation? operation,
  }) {
    final op = operation ?? _randomOperationForDifficulty(difficulty);
    switch (op) {
      case MathOperation.addition:
        return _additionProblem(difficulty);
      case MathOperation.subtraction:
        return _subtractionProblem(difficulty);
      case MathOperation.multiplication:
        return _multiplicationProblem(difficulty);
      case MathOperation.division:
        return _divisionProblem(difficulty);
    }
  }

  /// Randomly selects a math operation, optionally weighted by difficulty.
  static MathOperation _randomOperationForDifficulty(
    DifficultyLevel difficulty,
  ) {
    // Optionally, weight operations by difficulty for a better experience.
    // For now, all operations are equally likely.
    const ops = MathOperation.values;
    return ops[_rng.nextInt(ops.length)];
  }

  /// Creates an addition problem.
  static MathProblem _additionProblem(DifficultyLevel difficulty) {
    final max = difficulty.maxNumber;
    final a = _rng.nextInt(max) + 1;
    final b = _rng.nextInt(max) + 1;
    return MathProblem(
      firstOperand: a,
      secondOperand: b,
      operation: MathOperation.addition,
      correctAnswer: a + b,
      difficulty: difficulty,
    );
  }

  /// Creates a subtraction problem, ensuring the result is non-negative.
  static MathProblem _subtractionProblem(DifficultyLevel difficulty) {
    final max = difficulty.maxNumber;
    int a = _rng.nextInt(max) + 1;
    int b = _rng.nextInt(max) + 1;
    if (b > a) {
      // Swap to avoid negative results
      final tmp = a;
      a = b;
      b = tmp;
    }
    return MathProblem(
      firstOperand: a,
      secondOperand: b,
      operation: MathOperation.subtraction,
      correctAnswer: a - b,
      difficulty: difficulty,
    );
  }

  /// Creates a multiplication problem.
  static MathProblem _multiplicationProblem(DifficultyLevel difficulty) {
    final max = _multiplicationMax(difficulty);
    final a = _rng.nextInt(max) + 1;
    final b = _rng.nextInt(max) + 1;
    return MathProblem(
      firstOperand: a,
      secondOperand: b,
      operation: MathOperation.multiplication,
      correctAnswer: a * b,
      difficulty: difficulty,
    );
  }

  /// Creates a division problem that always results in a whole number.
  static MathProblem _divisionProblem(DifficultyLevel difficulty) {
    final limits = _divisionLimits(difficulty);
    final divisor = _rng.nextInt(limits.maxDivisor - 1) + 2; // Min divisor is 2
    final quotient = _rng.nextInt(limits.maxQuotient) + 1;
    final dividend = divisor * quotient;
    return MathProblem(
      firstOperand: dividend,
      secondOperand: divisor,
      operation: MathOperation.division,
      correctAnswer: quotient,
      difficulty: difficulty,
    );
  }

  /// Returns the max operand value for multiplication to keep results manageable.
  static int _multiplicationMax(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.easy:
        return 5;
      case DifficultyLevel.medium:
        return 8;
      case DifficultyLevel.hard:
        return 12;
    }
  }

  /// Returns the divisor and quotient limits for division based on difficulty.
  static _DivisionLimits _divisionLimits(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.easy:
        return const _DivisionLimits(maxDivisor: 5, maxQuotient: 5);
      case DifficultyLevel.medium:
        return const _DivisionLimits(maxDivisor: 8, maxQuotient: 10);
      case DifficultyLevel.hard:
        return const _DivisionLimits(maxDivisor: 12, maxQuotient: 15);
    }
  }
}

/// Internal class to hold division operation limits.
class _DivisionLimits {
  const _DivisionLimits({
    required this.maxDivisor,
    required this.maxQuotient,
  });

  final int maxDivisor;
  final int maxQuotient;
}

// Legacy alias for backward compatibility
@Deprecated('Use MathProblemGenerator instead')
typedef MathService = MathProblemGenerator;
