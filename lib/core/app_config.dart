class AppConfig {
  static const String appName = 'Bullet Math';
  static const String appVersion = '1.0.0';
  
  static const int maxInputLength = 6;
  static const int maxAnswerValue = 999999;
  static const int minAnswerValue = -999999;
  
  static const bool enableHapticFeedback = true;
  static const bool enableAutoAdvance = true;
  
  static const Duration defaultAnimationDuration = Duration(milliseconds: 200);
  static const Duration autoAdvanceDuration = Duration(milliseconds: 1500);
  static const Duration fastAnimationDuration = Duration(milliseconds: 150);
  static const Duration slowAnimationDuration = Duration(milliseconds: 300);
  
  static const bool debugMode = false;
  
  static const Map<String, int> difficultyRanges = {
    'easy': 10,
    'medium': 50,
    'hard': 100,
  };
} 