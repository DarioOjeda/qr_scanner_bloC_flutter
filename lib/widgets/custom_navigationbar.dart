import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_sqlite/main.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<PageCubit, int>(
      builder: (_, index) => BottomNavigationBar(
        currentIndex: index,
        elevation: 0,
        onTap: (indice) => context.read<PageCubit>().changePage(indice),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/compass.png'),),
            label: 'Direcciones',  
          ),
        ],
      ),
    );
  }
}