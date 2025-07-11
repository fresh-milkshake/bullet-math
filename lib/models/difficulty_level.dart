/// Defines the difficulty levels for math problems.
enum DifficultyLevel {
  easy(
    name: 'easy',
    displayName: 'Easy',
    maxNumber: 10,
    description: 'Simple problems with small numbers (1-10)',
  ),
  medium(
    name: 'medium',
    displayName: 'Medium',
    maxNumber: 50,
    description: 'Moderate problems with medium numbers (1-50)',
  ),
  hard(
    name: 'hard',
    displayName: 'Hard',
    maxNumber: 100,
    description: 'Complex problems with large numbers (1-100)',
  );

  const DifficultyLevel({
    required this.name,
    required this.displayName,
    required this.maxNumber,
    required this.description,
  });

  final String name;
  final String displayName;
  final int maxNumber;
  final String description;
} 