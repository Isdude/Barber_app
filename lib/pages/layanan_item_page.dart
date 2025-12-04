import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class LayananItemPage extends StatefulWidget {
  const LayananItemPage({super.key});

  @override
  State<LayananItemPage> createState() => _LayananItemPageState();
}

class _LayananItemPageState extends State<LayananItemPage> {
  final TextEditingController nama_controller = TextEditingController();
  final TextEditingController harga_controller = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;

  int selectedIndex = 0; // 0 = Layanan, 1 = Produk

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Kelola Layanan",
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF3773FF), Color(0xFF5AB2FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.cut_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "KasirKu Servis",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "BarberPro Studio & Grooming",
                        style: GoogleFonts.poppins(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 13.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 15),

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
                onPressed: () {
                  setState(() => selectedIndex = 0);
                },
                child: Text("Layanan", style: GoogleFonts.poppins()),
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
                onPressed: () {
                  setState(() => selectedIndex = 1);
                },
                child: Text("Produk", style: GoogleFonts.poppins()),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Expanded(
            child: selectedIndex == 0
                ? buildListLayanan()
                : buildListProduk(),
          ),
        ],
      ),

      floatingActionButton: Tooltip(
        message:
            selectedIndex == 0 ? "Tambah Layanan" : "Tambah Produk",
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF3773FF), Color(0xFF5AB2FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
          ),
          child: FloatingActionButton(
            elevation: 0,
            backgroundColor: Colors.transparent,
            onPressed: () {
              nama_controller.clear();
              harga_controller.clear();

              showDialog(
                context: context,
                builder: (_) => buildAddDialog(
                    context, selectedIndex == 0 ? "menu" : "produk"),
              );
            },
            child: const Icon(Icons.add, color: Colors.white, size: 28),
          ),
        ),
      ),
    );
  }

  Widget buildListLayanan() {
    return StreamBuilder<QuerySnapshot>(
      stream: db.collection('menu').orderBy('createdAt').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

        final dataMenu = snapshot.data!.docs;

        if (dataMenu.isEmpty) {
          return Center(
            child: Text(
              "Belum ada layanan",
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: dataMenu.length,
          itemBuilder: (context, index) {
            final menu = dataMenu[index];

            return buildItemCard(
              icon: Icons.cut,
              color: const Color(0xFF3773FF),
              nama: menu['nama'],
              harga: menu['harga'],
              onEdit: () {
                nama_controller.text = menu['nama'];
                harga_controller.text = menu['harga'];
                showDialog(
                  context: context,
                  builder: (_) => buildEditDialog(context, "menu", menu),
                );
              },
              onDelete: () {
                showDialog(
                  context: context,
                  builder: (_) => buildDeleteDialog(context, "menu", menu),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget buildListProduk() {
    return StreamBuilder<QuerySnapshot>(
      stream: db.collection('produk').orderBy('createdAt').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

        final dataProduk = snapshot.data!.docs;

        if (dataProduk.isEmpty) {
          return Center(
            child: Text(
              "Belum ada produk",
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: dataProduk.length,
          itemBuilder: (context, index) {
            final produk = dataProduk[index];

            return buildItemCard(
              icon: Icons.shopping_bag_rounded,
              color: const Color(0xFF3773FF),
              nama: produk['nama'],
              harga: produk['harga'],
              onEdit: () {
                nama_controller.text = produk['nama'];
                harga_controller.text = produk['harga'];
                showDialog(
                  context: context,
                  builder: (_) => buildEditDialog(context, "produk", produk),
                );
              },
              onDelete: () {
                showDialog(
                  context: context,
                  builder: (_) => buildDeleteDialog(context, "produk", produk),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget buildItemCard({
    required IconData icon,
    required Color color,
    required String nama,
    required String harga,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          nama,
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        subtitle: Text(
          "Rp $harga",
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
        ),
        trailing: Wrap(
          spacing: 6,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline_rounded, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAddDialog(BuildContext context, String tipe) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        tipe == "menu" ? 'Tambah Layanan' : 'Tambah Produk',
        style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 20),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nama_controller,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.label, color: Color(0xFF3773FF)),
              labelText: 'Nama',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: harga_controller,
            decoration: InputDecoration(
              prefixIcon:
                  const Icon(Icons.attach_money, color: Color(0xFF3773FF)),
              labelText: 'Harga',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(backgroundColor: Colors.grey.shade400),
          onPressed: () => Navigator.pop(context),
          child: Text("Batal", style: GoogleFonts.poppins(color: Colors.white)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3773FF)),
          onPressed: () async {
            await db.collection(tipe).add({
              'nama': nama_controller.text,
              'harga': harga_controller.text,
              'createdAt': FieldValue.serverTimestamp(),
            });

            Navigator.pop(context);

            Get.snackbar(
              "Berhasil",
              tipe == "menu"
                  ? "Layanan berhasil ditambahkan"
                  : "Produk berhasil ditambahkan",
              backgroundColor: Colors.green,
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
              duration: const Duration(seconds: 2),
              margin: const EdgeInsets.all(16),
              borderRadius: 12,
            );
          },
          child: Text("Simpan", style: GoogleFonts.poppins(color: Colors.white)),
        ),
      ],
    );
  }

  Widget buildEditDialog(
      BuildContext context, String tipe, QueryDocumentSnapshot item) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        tipe == "menu" ? 'Edit Layanan' : 'Edit Produk',
        style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 20),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nama_controller,
            decoration: InputDecoration(
              labelText: 'Nama',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: harga_controller,
            decoration: InputDecoration(
              labelText: 'Harga',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(backgroundColor: Colors.grey),
          onPressed: () => Navigator.pop(context),
          child: Text("Batal", style: GoogleFonts.poppins(color: Colors.white)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
          onPressed: () async {
            await db.collection(tipe).doc(item.id).update({
              'nama': nama_controller.text,
              'harga': harga_controller.text,
            });

            Navigator.pop(context);

            Get.snackbar(
              "Berhasil",
              tipe == "menu"
                  ? "Layanan berhasil diperbarui"
                  : "Produk berhasil diperbarui",
              backgroundColor: Colors.blue,
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
              duration: const Duration(seconds: 2),
              margin: const EdgeInsets.all(16),
              borderRadius: 12,
            );
          },
          child: Text("Simpan", style: GoogleFonts.poppins(color: Colors.white)),
        ),
      ],
    );
  }

  Widget buildDeleteDialog(
      BuildContext context, String tipe, QueryDocumentSnapshot item) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
          const SizedBox(width: 8),
          Text(
            'Hapus Item',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
        ],
      ),
      content: Text(
        'Apakah Anda yakin ingin menghapus "${item['nama']}"?',
        style: GoogleFonts.poppins(fontSize: 15),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(backgroundColor: Colors.grey),
          onPressed: () => Navigator.pop(context),
          child: Text("Batal", style: GoogleFonts.poppins(color: Colors.white)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
          onPressed: () async {
            await db.collection(tipe).doc(item.id).delete();
            Navigator.pop(context);
          },
          child: Text("Hapus", style: GoogleFonts.poppins(color: Colors.white)),
        ),
      ],
    );
  }
}
