import 'difficulty_level.dart';

/// Represents the available mathematical operations.
enum MathOperation {
  addition('+', 'Addition'),
  subtraction('-', 'Subtraction'),
  multiplication('×', 'Multiplication'),
  division('÷', 'Division');

  const MathOperation(this.symbol, this.displayName);

  final String symbol;
  final String displayName;
}

/// Represents a single mathematical problem.
class MathProblem {
  final int firstOperand;
  final int secondOperand;
  final MathOperation operation;
  final int correctAnswer;
  final DifficultyLevel difficulty;

  const MathProblem({
    required this.firstOperand,
    required this.secondOperand,
    required this.operation,
    required this.correctAnswer,
    required this.difficulty,
  });

  /// Formatted question text (e.g., "5 + 3 = ?").
  String get questionText => '$firstOperand ${operation.symbol} $secondOperand = ?';

  /// Description for debugging purposes.
  String get debugDescription =>
      'MathProblem(${operation.displayName}: $firstOperand ${operation.symbol} $secondOperand = $correctAnswer, Difficulty: ${difficulty.displayName})';
} 