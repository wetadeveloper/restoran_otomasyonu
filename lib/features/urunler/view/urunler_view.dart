import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_otomasyonu/core/constants/app_colors.dart';
import 'package:restoran_otomasyonu/core/constants/app_strings.dart';
import 'package:restoran_otomasyonu/features/urunler/view/urun_ekle_view.dart';
import 'package:restoran_otomasyonu/features/urunler/viewmodel/urunler_view_model.dart';
import 'package:restoran_otomasyonu/features/urunler/widgets/urun_card.dart';

class UrunlerView extends StatelessWidget {
  const UrunlerView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UrunlerViewModel()..fetchUrunler(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.urunler, style: TextStyle(color: AppColors.title, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: AppColors.primary,
          iconTheme: IconThemeData(color: AppColors.icon),
        ),
        body: Consumer<UrunlerViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewModel.errorMessage != null) {
              return Center(child: Text(viewModel.errorMessage!));
            }

            return ListView.builder(
              itemCount: viewModel.urunler.length,
              itemBuilder: (context, index) {
                final urun = viewModel.urunler[index];
                return UrunCard(urun: urun, onDelete: () => viewModel.deleteUrun(urun.id));
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => UrunEkleView()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
