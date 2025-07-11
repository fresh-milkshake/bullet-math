import 'dart:math';
import '../models/math_problem.dart';
import '../models/difficulty_level.dart';

/// Service for generating mathematical problems.
class MathProblemGenerator {
  static final Random _randomNumberGenerator = Random();

  /// Generates a new math problem for the given difficulty.
  static MathProblem generateProblem(DifficultyLevel difficulty) {
    final operation = _selectRandomOperation();

    switch (operation) {
      case MathOperation.addition:
        return _createAdditionProblem(difficulty);
      case MathOperation.subtraction:
        return _createSubtractionProblem(difficulty);
      case MathOperation.multiplication:
        return _createMultiplicationProblem(difficulty);
      case MathOperation.division:
        return _createDivisionProblem(difficulty);
    }
  }

  /// Randomly selects a math operation.
  static MathOperation _selectRandomOperation() {
    final operationIndex =
        _randomNumberGenerator.nextInt(MathOperation.values.length);
    return MathOperation.values[operationIndex];
  }

  /// Creates an addition problem.
  static MathProblem _createAdditionProblem(DifficultyLevel difficulty) {
    final maxOperandValue = difficulty.maxNumber;
    final firstOperand = _randomNumberGenerator.nextInt(maxOperandValue) + 1;
    final secondOperand = _randomNumberGenerator.nextInt(maxOperandValue) + 1;
    final result = firstOperand + secondOperand;

    return MathProblem(
      firstOperand: firstOperand,
      secondOperand: secondOperand,
      operation: MathOperation.addition,
      correctAnswer: result,
      difficulty: difficulty,
    );
  }

  /// Creates a subtraction problem, ensuring the result is always positive.
  static MathProblem _createSubtractionProblem(DifficultyLevel difficulty) {
    final maxOperandValue = difficulty.maxNumber;
    final firstOperand = _randomNumberGenerator.nextInt(maxOperandValue) + 1;
    final secondOperand = _randomNumberGenerator.nextInt(firstOperand) + 1;
    final result = firstOperand - secondOperand;

    return MathProblem(
      firstOperand: firstOperand,
      secondOperand: secondOperand,
      operation: MathOperation.subtraction,
      correctAnswer: result,
      difficulty: difficulty,
    );
  }

  /// Creates a multiplication problem.
  static MathProblem _createMultiplicationProblem(DifficultyLevel difficulty) {
    final maxOperandValue = _getMultiplicationMaxValue(difficulty);

    final firstOperand = _randomNumberGenerator.nextInt(maxOperandValue) + 1;
    final secondOperand = _randomNumberGenerator.nextInt(maxOperandValue) + 1;
    final result = firstOperand * secondOperand;

    return MathProblem(
      firstOperand: firstOperand,
      secondOperand: secondOperand,
      operation: MathOperation.multiplication,
      correctAnswer: result,
      difficulty: difficulty,
    );
  }

  /// Creates a division problem that always results in a whole number.
  static MathProblem _createDivisionProblem(DifficultyLevel difficulty) {
    final limits = _getDivisionLimits(difficulty);
    final maxDivisorValue = limits.maxDivisor;
    final maxQuotientValue = limits.maxQuotient;

    final divisor = _randomNumberGenerator.nextInt(maxDivisorValue - 1) + 2; // Min divisor is 2
    final quotient = _randomNumberGenerator.nextInt(maxQuotientValue) + 1;
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
  static int _getMultiplicationMaxValue(DifficultyLevel difficulty) {
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
  static _DivisionLimits _getDivisionLimits(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.easy:
        return _DivisionLimits(maxDivisor: 5, maxQuotient: 5);
      case DifficultyLevel.medium:
        return _DivisionLimits(maxDivisor: 8, maxQuotient: 10);
      case DifficultyLevel.hard:
        return _DivisionLimits(maxDivisor: 12, maxQuotient: 15);
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
// TODO: Remove this alias in future versions
@Deprecated('Use MathProblemGenerator instead')
typedef MathService = MathProblemGenerator; 