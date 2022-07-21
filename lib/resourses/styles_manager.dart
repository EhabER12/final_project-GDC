
import 'package:flutter/cupertino.dart';

import 'fonts_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: FontConstants.fontFamily,
      fontWeight: fontWeight,
      color: color);
}
//Regular
TextStyle getRegularStyle({double fontSize=FontSize.s12,required Color color}){
  return _getTextStyle(fontSize, FontWeightManager.regular, color);
}
//Medium
//Light
TextStyle getLightStyle({double fontSize=FontSize.s12,required Color color}){
  return _getTextStyle(fontSize, FontWeightManager.light, color);
}
//SemiBold
TextStyle getSemiBoldStyle({double fontSize=FontSize.s12,required Color color}){
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
}
//Bold
TextStyle getBoldStyle({double fontSize=FontSize.s12,required Color color}){
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}