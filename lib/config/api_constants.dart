class ApiConstants {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  static const register = '$baseUrl/register';
  static const String login = '$baseUrl/login';
  static const String logout = '$baseUrl/logout';

  static const String dashboardPengawas = '$baseUrl/dashboard/pengawas';
  static const String dashboardPengurus = '$baseUrl/dashboard/pengurus';
  static const String dashboardAnggota = '$baseUrl/dashboard/anggota';

  static const String anggotaPending = '$baseUrl/anggota/pending';
  static const String approveAnggota = '$baseUrl/anggota';
  static const String rejectAnggota = '$baseUrl/anggota';
  static const String jumlahAnggotaUrl = '$baseUrl/pengurus/jumlah-anggota';

  // static const String approveAnggota = '$baseUrl/anggota/{id}/approve';
  // static const String rejectAnggota = '$baseUrl/anggota/{id}/reject';
}
