import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app/ui/base/base_widget.dart';

class BaseBlocWidget extends BaseWidget {
  final Widget _body;

  BaseBlocWidget(BaseBloc baseBloc, this._body) : super(baseBloc);

  @override
  Widget body(BuildContext context) {
    return _body;
  }
}
