import 'package:flutter/material.dart';
import '/services/anggota_service.dart';

class PendingAnggotaScreen extends StatefulWidget {
  @override
  _PendingAnggotaScreenState createState() => _PendingAnggotaScreenState();
}

class _PendingAnggotaScreenState extends State<PendingAnggotaScreen> {
  final AnggotaService anggotaService = AnggotaService();
  List<dynamic> anggotaPending = [];
  bool isLoading = true;
  Set<int> loadingIds = {}; // Untuk loading saat approve/tolak per item

  @override
  void initState() {
    super.initState();
    loadPendingAnggota();
  }

  void loadPendingAnggota() async {
    setState(() => isLoading = true);
    try {
      final data = await anggotaService.fetchPendingAnggota();
      setState(() {
        anggotaPending = data;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() => isLoading = false);
    }
  }

  Future<void> konfirmasiAksi({required int id, required bool setuju}) async {
    final namaAksi = setuju ? "Setujui" : "Tolak";

    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("$namaAksi Anggota"),
            content: Text("Yakin ingin $namaAksi anggota ini?"),
            actions: [
              TextButton(
                child: Text("Batal"),
                onPressed: () => Navigator.pop(context, false),
              ),
              ElevatedButton(
                child: Text(namaAksi),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          ),
    );

    if (confirmed == true) {
      await aksiAnggota(id: id, setuju: setuju);
    }
  }

  Future<void> aksiAnggota({required int id, required bool setuju}) async {
    setState(() => loadingIds.add(id));

    try {
      if (setuju) {
        await anggotaService.approveAnggota(id);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Anggota berhasil disetujui")));
      } else {
        await anggotaService.rejectAnggota(id);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Anggota berhasil ditolak")));
      }
      loadPendingAnggota();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Terjadi kesalahan: $e")));
    } finally {
      setState(() => loadingIds.remove(id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Anggota Pending")),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : anggotaPending.isEmpty
              ? Center(child: Text("Tidak ada anggota pending."))
              : ListView.builder(
                itemCount: anggotaPending.length,
                itemBuilder: (context, index) {
                  final anggota = anggotaPending[index];
                  final isLoadingItem = loadingIds.contains(anggota['id']);
                  return Card(
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(
                        anggota['name']?.toString() ?? 'Nama tidak tersedia',
                      ),
                      subtitle: Text(
                        anggota['email']?.toString() ?? 'Email tidak tersedia',
                      ),
                      trailing:
                          isLoadingItem
                              ? SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                              : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    ),
                                    onPressed:
                                        () => konfirmasiAksi(
                                          id: anggota['id'],
                                          setuju: true,
                                        ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.close, color: Colors.red),
                                    onPressed:
                                        () => konfirmasiAksi(
                                          id: anggota['id'],
                                          setuju: false,
                                        ),
                                  ),
                                ],
                              ),
                    ),
                  );
                },
              ),
    );
  }
}
