import 'package:flutter/material.dart';
import 'package:flutter_movie_app/ui/base/base_bloc_widget.dart';
import 'package:movie_bloc/src/bloc/base_bloc.dart';

class BaseBlocScaffoldWidget extends BaseBlocWidget {
  final AppBar appBar;

  BaseBlocScaffoldWidget({BaseBloc bloc, Widget body, this.appBar})
      : super(bloc, body);

  @override
  Widget body(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: super.body(context),
      ),
    );
  }
}
