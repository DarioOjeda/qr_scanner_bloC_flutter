import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_sqlite/pages/direcciones_page.dart';
import 'package:qr_scanner_sqlite/pages/mapas_pages.dart';
import 'package:qr_scanner_sqlite/pages/qr_page.dart';
import 'package:qr_scanner_sqlite/widgets/custom_navigationbar.dart';
import 'package:qr_scanner_sqlite/widgets/scan_button.dart';

import '../main.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Historial'),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon( Icons.delete_forever))
        ],
      ),
      body: BlocBuilder<PageCubit, int>(
        builder: (_, page) => _HomePageBody(page: page)
      ),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
   );
  }
}

class _HomePageBody extends StatelessWidget {

  const _HomePageBody({Key? key, required this.page}) : super(key: key);
  final int page;

  @override
  Widget build(BuildContext context) {

        switch( page ) {

          case 0:
            return const MapasPage();

          case 1:
            return const DireccionesPage();  

          case 2:
            return const QRPage(); 

          default:
            return const MapasPage();
        } 
      }

        
  }