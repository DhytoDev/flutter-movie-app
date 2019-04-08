import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app/ui/base/base_bloc_widget.dart';

class BaseBlocScaffoldWidget extends BaseBlocWidget {
  final AppBar appBar;

  BaseBlocScaffoldWidget({BaseBloc bloc, Widget body, this.appBar})
      : super(bloc, body);

  @override
  Widget body(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: appBar ?? null,
        body: super.body(context),
      ),
    );
  }
}
