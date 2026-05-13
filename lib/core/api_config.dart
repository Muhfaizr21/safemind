class ApiConfig {
  // Gunakan localhost untuk iOS Simulator / Chrome
  // Gunakan 10.0.2.2 untuk Android Emulator
  // Gunakan IP laptop (misal: 192.168.1.x) jika menggunakan HP Fisik
  static const String baseUrl = 'http://localhost:3000/api';
  
  static const String login = '$baseUrl/login';
  static const String register = '$baseUrl/register';
  static const String reports = '$baseUrl/reports';
  static const String updateProfile = '$baseUrl/update-profile';
  static const String changePassword = '$baseUrl/change-password';
  static const String sessions = '$baseUrl/sessions';
  static const String articles = '$baseUrl/articles';
  static const String videos = '$baseUrl/videos';
  static const String notifications = '$baseUrl/notifications';
  static const String psychologists = '$baseUrl/psychologists';
  static const String adminStats = '$baseUrl/admin/stats';
  static const String adminUsers = '$baseUrl/admin/users';
}
