import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class PilihLayananItemPage extends StatefulWidget {
  const PilihLayananItemPage({super.key});

  @override
  State<PilihLayananItemPage> createState() => _PilihLayananItemPageState();
}

class _PilihLayananItemPageState extends State<PilihLayananItemPage> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  int selectedIndex = 0; // 0 = Layanan, 1 = Item

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),

      appBar: AppBar(
        title: Text(
          'Pilih Layanan / Item',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 3,
        backgroundColor: const Color(0xFF3773FF),
      ),

      body: Column(
        children: [
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedIndex == 0
                      ? const Color(0xFF3773FF)
                      : Colors.grey[300],
                  foregroundColor:
                      selectedIndex == 0 ? Colors.white : Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => setState(() => selectedIndex = 0),
                child: Text("Layanan"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedIndex == 1
                      ? const Color(0xFF3773FF)
                      : Colors.grey[300],
                  foregroundColor:
                      selectedIndex == 1 ? Colors.white : Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => setState(() => selectedIndex = 1),
                child: Text("Item"),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Expanded(
            child: selectedIndex == 0
                ? buildListStream("menu") // Layanan
                : buildListStream("produk"), // Item
          ),
        ],
      ),
    );
  }

  Widget buildListStream(String koleksi) {
    return StreamBuilder<QuerySnapshot>(
      stream: db.collection(koleksi).orderBy('createdAt').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data!.docs;

        if (data.isEmpty) {
          return Center(
            child: Text(
              "Belum ada data.",
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];

            final nama = item['nama'];
            final harga = item['harga'] is int
                ? item['harga']
                : int.tryParse(item['harga'].toString().replaceAll('.', '')) ??
                    0;

            return Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              shadowColor: Colors.black.withOpacity(0.2),
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: const Icon(Icons.cut, size: 30, color: Color(0xFF3773FF)),
                title: Text(
                  nama,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  "Harga: Rp $harga",
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.add_circle_rounded,
                    color: Color(0xFF3773FF),
                    size: 28,
                  ),
                  onPressed: () {
                    showLayananDialog(context, nama, harga);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  void showLayananDialog(BuildContext context, String nama, int harga) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Konfirmasi',
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
              Text('Harga: Rp. $harga',
                  style: GoogleFonts.poppins(fontSize: 15)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Batal",
                  style: GoogleFonts.poppins(color: Colors.grey[700])),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3773FF),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, {'nama': nama, 'harga': harga});

                Get.snackbar(
                  "Berhasil",
                  "'$nama' ditambahkan.",
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              },
              child: Text(
                "Pilih",
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
