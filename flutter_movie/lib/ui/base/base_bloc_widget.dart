import 'package:flutter/material.dart';
import 'package:flutter_movie_app/ui/base/base_widget.dart';
import 'package:movie_bloc/movie_bloc.dart';

class BaseBlocWidget extends BaseWidget {
  final Widget _body;

  BaseBlocWidget(BaseBloc baseBloc, this._body) : super(baseBloc);

  @override
  Widget body(BuildContext context) {
    return _body;
  }
}
