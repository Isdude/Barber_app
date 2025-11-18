import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';


class PilihPegawaiPage extends StatefulWidget {
  const PilihPegawaiPage({super.key});

  @override
  State<PilihPegawaiPage> createState() => _PilihPegawaiPageState();
}

class _PilihPegawaiPageState extends State<PilihPegawaiPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),

      appBar: AppBar(
        title: Text(
          'Pilih Pegawai',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 3,
        backgroundColor: const Color(0xFF3773FF),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: db
            .collection('pegawai')
            .orderBy('createdAt', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final dataPegawai = snapshot.data!.docs;

          if (dataPegawai.isEmpty) {
            return Center(
              child: Text(
                "Belum ada data pegawai.",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            itemCount: dataPegawai.length,
            itemBuilder: (context, index) {
              final pegawai = dataPegawai[index];

              return Card(
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shadowColor: Colors.black.withOpacity(0.3),
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  leading: const Icon(
                    Icons.person,
                    color: Colors.black87,
                    size: 30,
                  ),
                  title: Text(
                    pegawai['nama'],
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    "No. HP: ${pegawai['noHp']}",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),

                  trailing: IconButton(
                    icon: const Icon(
                      Icons.add_circle_rounded,
                      color: Color(0xFF3773FF),
                      size: 28,
                    ),
                    onPressed: () {
                      showPegawaiDialog(
                        context,
                        pegawai['nama'],
                        pegawai['noHp'],
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void showPegawaiDialog(BuildContext context, String nama, String noHp) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Konfirmasi Pegawai',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama: $nama', style: GoogleFonts.poppins(fontSize: 15)),
              const SizedBox(height: 6),
              Text('No. HP: $noHp', style: GoogleFonts.poppins(fontSize: 15)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Batal",
                style: GoogleFonts.poppins(color: Colors.grey[700]),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3773FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, {'nama': nama, 'noHp': noHp});

                Get.snackbar(
                  "Berhasil",
                  'Pegawai "$nama" berhasil dipilih',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              },
              child: Text(
                "Simpan",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
