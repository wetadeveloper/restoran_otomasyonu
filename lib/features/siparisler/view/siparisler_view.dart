import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_otomasyonu/core/constants/app_colors.dart';
import 'package:restoran_otomasyonu/core/constants/app_strings.dart';
import 'package:restoran_otomasyonu/features/siparisler/view/siparis_ekle_view.dart';
import 'package:restoran_otomasyonu/features/siparisler/viewmodel/siparisler_view_model.dart';
import 'package:restoran_otomasyonu/features/siparisler/widgets/siparis_card.dart';

class SiparislerView extends StatelessWidget {
  const SiparislerView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SiparislerViewModel()..getSiparisler(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.siparisler, style: TextStyle(color: AppColors.title, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: AppColors.primary,
          iconTheme: IconThemeData(color: AppColors.icon),
        ),
        body: Consumer<SiparislerViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewModel.errorMessage != null) {
              return Center(child: Text(viewModel.errorMessage!));
            }

            return ListView(
              children:
                  viewModel.siparislerGruplanmis.entries.map((entry) {
                    final masaId = entry.key;
                    final siparisListesi = entry.value;

                    return ExpansionTile(
                      title: Text("Masa $masaId"),
                      children:
                          siparisListesi.map((siparis) {
                            return SiparisCard(
                              siparis: siparis,
                              onDelete: () => viewModel.silSiparis(int.parse(siparis.id)),
                            );
                          }).toList(),
                    );
                  }).toList(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => SiparisEkleView()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
