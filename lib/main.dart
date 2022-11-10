import 'package:flutter/material.dart';
import 'package:qr_scanner_sqlite/pages/home_page.dart';
import 'package:qr_scanner_sqlite/pages/mapa_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() { 
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
     return BlocProvider(
      create: (_) => PageCubit(),
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

