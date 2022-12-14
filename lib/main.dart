import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_scanner_sqlite/models/scan_model.dart';
import 'package:qr_scanner_sqlite/pages/home_page.dart';
import 'package:qr_scanner_sqlite/pages/mapa_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_sqlite/repositories/database/database_repository.dart';
import 'package:qr_scanner_sqlite/repositories/database/sqflite_database_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<void> main() async{ 
  await SqfliteDatabaseRepository.init();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
     return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) { return PageCubit(); }),
        BlocProvider(create: (_) => ScannerCubit(databaseRepository: SqfliteDatabaseRepository()))
      ],
      child: AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  AppView({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'QR Reader',
            initialRoute: 'home',
            routes: {
              'home': ( _ ) => HomePage(),
              'mapa': ( _ ) => MapaPage(),
            },
            theme: ThemeData(
              colorScheme: ColorScheme.light().copyWith( primary: Colors.green[900]),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.green[600]
              )
            ),
          );

  }
}

/// Event being processed by [CounterBloc].
abstract class PageEvent {}

class NavigateToMapasPressed extends PageEvent {}

class NavigateToDirectionsPressed extends PageEvent {}

/// {@template counter_bloc}
/// A simple [Bloc] that manages an `int` as its state.
/// {@endtemplate}
class PageCubit extends Cubit<int> {
  
  PageCubit() : super(0);

  void changePage(int page) => emit(page);
  
}

class ScannerCubit extends Cubit<ScannerState> {
  ScannerCubit({required DatabaseRepository databaseRepository}): 
        _databaseRepository = databaseRepository,
        super(ScannerState());
  
  final DatabaseRepository _databaseRepository;
  
  Future<void> load() async{
    final result = await _databaseRepository.loadAllScanner();

    emit(state.updateScannerList(result));
  }

  Future<void> insert(String tipo, String valor) async{
    await _databaseRepository.insertNewValue(tipo, valor);
    final result = await _databaseRepository.loadAllScanner();
    
    emit(state.updateScannerList(result));
  }
  
}

class ScannerState {
  final List<ScanModel> scannerList;

  ScannerState({ this.scannerList = const <ScanModel>[]});

  ScannerState updateScannerList(List<ScanModel> lista) {
    return ScannerState(scannerList: lista);
  }
}






