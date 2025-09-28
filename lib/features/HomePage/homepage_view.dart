import 'package:flutter/material.dart';
import 'package:restoran_otomasyonu/features/masalar/view/masalar_view.dart';
import 'package:restoran_otomasyonu/features/odeme/view/odeme_view.dart';
import 'package:restoran_otomasyonu/features/urunler/view/urunler_view.dart';
import 'package:restoran_otomasyonu/features/siparisler/view/siparisler_view.dart';
import 'package:restoran_otomasyonu/core/constants/app_colors.dart';
import 'package:restoran_otomasyonu/core/constants/app_strings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color dashboardCardColor = Color(0xFF8B4513);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(AppStrings.appName, style: TextStyle(color: AppColors.title, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(color: AppColors.icon),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildDashboardCard(
              context,
              icon: Icons.table_bar,
              title: 'Masalar',
              color: dashboardCardColor,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MasalarView())),
            ),
            _buildDashboardCard(
              context,
              icon: Icons.receipt_long,
              title: 'Siparişler',
              color: dashboardCardColor,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SiparislerView())),
            ),
            _buildDashboardCard(
              context,
              icon: Icons.fastfood,
              title: 'Ürünler',
              color: dashboardCardColor,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UrunlerView())),
            ),
            _buildDashboardCard(
              context,
              title: 'Ödeme',
              icon: Icons.payment,
              color: dashboardCardColor,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OdemeView())),
            ),
            _buildDashboardCard(
              context,
              title: 'Mutfak',
              icon: Icons.kitchen,
              color: dashboardCardColor,
              onTap: () {
                // Mutfak sayfası
              },
            ),
            _buildDashboardCard(
              context,
              icon: Icons.bar_chart,
              title: 'Raporlar',
              color: dashboardCardColor,
              onTap: () {
                // Raporlar sayfası
              },
            ),
            _buildDashboardCard(
              context,
              icon: Icons.info,
              title: 'Hakkında',
              color: dashboardCardColor,
              onTap: () {
                // Hakkında sayfası
              },
            ),
            _buildDashboardCard(
              context,
              icon: Icons.settings,
              title: 'Ayarlar',
              color: dashboardCardColor,
              onTap: () {
                // Ayarlar sayfası
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: color,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48, color: Colors.white),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
