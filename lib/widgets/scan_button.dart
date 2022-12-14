import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../main.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return BlocBuilder<PageCubit, int>(
         builder: (_, index) => FloatingActionButton(
          elevation: 0,
          onPressed: () => context.read<PageCubit>().changePage(2),
          child: const Icon(Icons.filter_center_focus),
        ),
      );
  }
}