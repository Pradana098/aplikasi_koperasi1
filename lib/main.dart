import 'package:aplikasi_koperasi1/screens/anggota/bantuan_screen.dart';
import 'package:aplikasi_koperasi1/screens/anggota/pilihsimpanan_screen.dart';
import 'package:aplikasi_koperasi1/screens/anggota/simpananpokok_screen.dart';
import 'package:aplikasi_koperasi1/screens/anggota/simpananwajib_screen.dart';
import 'package:aplikasi_koperasi1/screens/home_screen.dart';
import 'package:aplikasi_koperasi1/screens/pengawas/dataanggota_screen.dart';
import 'package:aplikasi_koperasi1/screens/pengawas/laporankeuangan_screen.dart';
import 'package:aplikasi_koperasi1/screens/pengawas/laporanpinjaman_screen.dart';
import 'package:aplikasi_koperasi1/screens/pengawas/laporansimpanan_screen.dart';
import 'package:aplikasi_koperasi1/screens/pengawas/pengaturanaplikasi_screen.dart';
import 'package:aplikasi_koperasi1/screens/pengawas/perkembangankoperasi_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

// Import semua file
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/anggota/DashboardAnggota.dart';
import 'screens/anggota/riwayat_transaksi_screen.dart';
import 'screens/anggota/pengajuan_pinjaman_screen.dart';
import 'screens/profil_screen.dart';
import 'screens/anggota/notifikasi_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Wajib agar async bisa jalan
  await initializeDateFormatting('id_ID', null); // Inisialisasi format lokal

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
 Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Koperasi Simpan Pinjam',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(), 
      routes: {
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/dashboardAnggota':
            (context) => DashboardAnggota(dashboardData: {"saldo": 5000000}),
        '/riwayat': (context) => RiwayatTransaksiScreen(),
        '/pengajuan': (context) => PengajuanPinjamanScreen(),
        '/profil': (context) => const ProfilScreen(),
        '/notifikasi': (context) => const NotifikasiScreen(),
        '/bantuan': (context) => const BantuanScreen(),
        '/pilihsimpanan': (context) => const PilihSimpananScreen(),
        '/simpananpokok': (context) => const SimpananPokokScreen(),
        '/simpananwajib': (context) => const SimpananWajibScreen(),

        //pengawas
        '/laporan-keuangan': (context) => const LaporanKeuanganScreen(),
        '/laporan-simpanan': (context) => const LaporanSimpananScreen(),
        '/laporan-pinjaman': (context) => const LaporanPinjamanScreen(),
        '/perkembangan-koperasi':
            (context) => const PerkembanganKoperasiScreen(),
        '/data-anggota': (context) => const DataAnggotaScreen(),
        '/pengaturan': (context) => const PengaturanAplikasiScreen(),
      },
    );
  }
}
