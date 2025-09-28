import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_otomasyonu/core/constants/app_colors.dart';
import 'package:restoran_otomasyonu/core/constants/app_strings.dart';
import 'package:restoran_otomasyonu/features/masalar/viewmodel/masalar_view_model.dart';
import 'package:restoran_otomasyonu/features/masalar/widgets/masa_card.dart';

class MasalarView extends StatelessWidget {
  const MasalarView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MasalarViewModel()..fetchMasalar(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.masalar, style: TextStyle(color: AppColors.title, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: AppColors.primary,
          iconTheme: IconThemeData(color: AppColors.icon),
        ),
        body: Consumer<MasalarViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewModel.errorMessage != null) {
              return Center(child: Text(viewModel.errorMessage!));
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: viewModel.masalar.length,
              itemBuilder: (context, index) {
                final masa = viewModel.masalar[index];
                return MasaCard(masa: masa, onTap: () => viewModel.toggleMasaDurum(masa.id));
              },
            );
          },
        ),
      ),
    );
  }
}
