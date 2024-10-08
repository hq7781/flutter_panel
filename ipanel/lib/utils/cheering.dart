import 'dart:ui';

import 'package:flutter/material.dart';

class Cheering {
  final String? id;
  final String displayText;
  final int? backgroundColor;
  final int? beginTextColor;
  final int? endTextColor;
  final double? fontSizeScale;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final String? fontFamily;
  final int? flashMilliseconds;
  final double? scrollStep;

  Cheering({
    this.id,
    required this.displayText,
    this.backgroundColor,
    this.beginTextColor,
    this.endTextColor,
    this.fontWeight,
    this.fontSizeScale,
    this.textAlign,
    this.fontFamily,
    this.flashMilliseconds,
    this.scrollStep,
  });

  factory Cheering.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final displayText = json['display_text'];
    final backgroundColor = json['background_color'];
    final beginTextColor = json['begin_text_color'];
    final endTextColor = json['end_text_color'];
    double fontSizeScale = json['font_size_scale'];
    int fontWeightIndex = json['font_weight'];
    int textAlignIndex = json['text_align'];
    final fontFamily = json['font_family'];
    final flashMilliseconds = json['flash_milliseconds'];
    final scrollStep = json['scroll_step'];

    return Cheering(
      id: id,
      // userId: userId,
      displayText: displayText,
      backgroundColor: backgroundColor,
      beginTextColor: beginTextColor,
      endTextColor: endTextColor,
      fontSizeScale: fontSizeScale,
      fontWeight: FontWeight.values[fontWeightIndex],
      //fontSize: fontSize.toDouble(),
      textAlign: TextAlign.values[textAlignIndex],
      fontFamily: fontFamily,
      flashMilliseconds: flashMilliseconds,
      scrollStep: scrollStep,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'user_id': userId,
      'display_text': displayText,
      'background_color': backgroundColor,
      'begin_text_color': beginTextColor,
      'end_text_color': endTextColor,
      'font_size_scale': fontSizeScale, //?.toInt() ?? 28,
      'font_weight': fontWeight?.index,
      'text_align': textAlign?.index,
      'font_family': fontFamily,
      'flash_milliseconds': flashMilliseconds,
      'scroll_step': scrollStep,
    };
  }
}
