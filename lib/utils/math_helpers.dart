class MathHelpers {
  static bool isValidInteger(String value) {
    if (value.isEmpty) return false;
    return int.tryParse(value) != null;
  }

  static int? parseUserInput(String input) {
    return int.tryParse(input.trim());
  }

  static String formatDivisionFraction(int dividend, int divisor) {
    return '$dividend ÷ $divisor';
  }

  static bool isDivisibleEvenly(int dividend, int divisor) {
    return divisor != 0 && dividend % divisor == 0;
  }

  static int greatestCommonDivisor(int a, int b) {
    while (b != 0) {
      int temp = b;
      b = a % b;
      a = temp;
    }
    return a.abs();
  }

  static String getOperationSymbol(String operation) {
    switch (operation.toLowerCase()) {
      case 'addition':
        return '+';
      case 'subtraction':
        return '-';
      case 'multiplication':
        return '×';
      case 'division':
        return '÷';
      default:
        return operation;
    }
  }

  static bool isPositiveInteger(int value) {
    return value > 0;
  }

  static int clampToRange(int value, int min, int max) {
    return value.clamp(min, max);
  }
} 