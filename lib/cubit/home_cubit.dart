import 'package:emergency_location/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<InitialState> {
  HomeCubit() :super (InitialState());

  haveClicked(){
    emit(isClicked(click: true));
  }

  cancel(){
    emit(isClicked(click: false));
  }

}


