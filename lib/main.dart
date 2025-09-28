import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_otomasyonu/core/services/navigation_service.dart';
import 'package:restoran_otomasyonu/features/HomePage/homepage_view.dart';
import 'package:restoran_otomasyonu/features/odeme/viewmodel/odeme_view_model.dart';
import 'package:restoran_otomasyonu/features/siparisler/viewmodel/siparisler_view_model.dart';
import 'package:restoran_otomasyonu/features/urunler/viewmodel/urunler_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationService = NavigationService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SiparislerViewModel()..getSiparisler()),
        ChangeNotifierProvider(create: (_) => UrunlerViewModel()..fetchUrunler()),
        ChangeNotifierProvider(create: (_) => OdemeViewModel()..fetchOdemeler()),
      ],
      child: MaterialApp(
        navigatorKey: navigationService.navigatorKey,
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomePage(),
      ),
    );
  }
}
