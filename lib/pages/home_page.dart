import 'package:barber_app/pages/pengeluaran_page.dart';
import 'package:barber_app/pages/riwayat_page.dart';
import 'package:barber_app/pages/transaksi_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'layanan_item_page.dart';
import 'pegawai_page.dart';
import 'pelanggan_page.dart';
import 'settings_page.dart';

class HomeBarberPage extends StatefulWidget {
  const HomeBarberPage({super.key});

  @override
  State<HomeBarberPage> createState() => _HomeBarberPageState();
}

class _HomeBarberPageState extends State<HomeBarberPage> {
  final List<Map<String, dynamic>> menuItems = [
    {"icon": Icons.cut, "label": "Layanan / Item"},
    {"icon": Icons.history, "label": "Riwayat"},
    {"icon": Icons.bar_chart, "label": "Laporan"},
    {"icon": Icons.people, "label": "Pelanggan"},
    {"icon": Icons.person, "label": "Pegawai"},
    {"icon": Icons.money_off, "label": "Pengeluaran"},
    {"icon": Icons.settings, "label": "Settings"},
  ];

  /// Dropdown popup custom
  void _openMenuDropdown(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    showMenu(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      position: RelativeRect.fromRect(
        Rect.fromPoints(
          button.localToGlobal(const Offset(-20, 40), ancestor: overlay),
          button.localToGlobal(const Offset(20, 40), ancestor: overlay),
        ),
        Offset.zero & overlay.size,
      ),
      items: [
        _popupItem(Icons.cut, "Layanan / Item", () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (c) => const LayananItemPage()),
          );
        }),
        _popupItem(Icons.history, "Riwayat", () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (c) => const RiwayatPage()),
          );
        }),
        _popupItem(Icons.bar_chart, "Laporan", () {}),
        _popupItem(Icons.people, "Pelanggan", () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (c) => const PelangganPage()),
          );
        }),
        _popupItem(Icons.person, "Pegawai", () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (c) => const PegawaiPage()),
          );
        }),
        _popupItem(Icons.money_off, "Pengeluaran", () {}),
        _popupItem(Icons.settings, "Settings", () {
        }),
      ],
    );
  }

  PopupMenuItem _popupItem(IconData icon, String label, VoidCallback onTap) {
    return PopupMenuItem(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.black87),
          const SizedBox(width: 12),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Column(
        children: [
          // ===================== HEADER ==========================
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF0047FF),
                  Color(0xFF3797FF),
                  Color(0xFF5AD2FF),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 45, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER TOP
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withOpacity(0.4),
                              ),
                            ),
                            child: const Icon(
                              Icons.content_cut_rounded,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "KasirKu Servis",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),

                      /// MENU BUTTON
                      Builder(
                        builder: (context) => InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () => _openMenuDropdown(context),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.menu_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  // SLOGAN
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          "Setiap potongan, penuh kepercayaan.\nSetiap layanan, penuh kepuasan.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.white.withOpacity(0.95),
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 15),

          // ================= BUSINESS CARD ===================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Card(
              elevation: 6,
              shadowColor: Colors.black.withOpacity(0.12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF3773FF),
                            Color(0xFF639BFF),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.storefront_rounded,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        "KasirKu Barbershop",
                        style: GoogleFonts.poppins(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 15),

          // ===================== GRID MENU =====================
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: GridView.builder(
                itemCount: menuItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 22,
                ),
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      final label = item['label'];

                      if (label == "Layanan / Item") {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (c) => const LayananItemPage()));
                      } else if (label == "Pegawai") {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (c) => const PegawaiPage()));
                      } else if (label == "Pelanggan") {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (c) => const PelangganPage()));
                      } else if (label == "Riwayat") {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (c) => const RiwayatPage()));
                      }else if (label == "Settings") {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (c) => const SettingsPage()));
                      }else if (label == "Pengeluaran") {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (c) => const PengeluaranPage()));
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.07),
                            blurRadius: 10,
                            offset: const Offset(3, 4),
                          ),
                        ],
                        border:
                            Border.all(color: Colors.grey.withOpacity(0.15)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [Color(0xFF3773FF), Color(0xFF5AB2FF)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Icon(
                              item['icon'],
                              size: 28,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            item['label'],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // ===================== BUTTON TRANSAKSI =====================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => const TransaksiPage()),
                  );
                },
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF3773FF), Color(0xFF5AB2FF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.shopping_cart_checkout,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Transaksi",
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
