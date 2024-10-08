
import 'package:flutter/material.dart';
import 'package:flutter_font_picker/flutter_font_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_button/group_button.dart';
import 'package:ipanel/panel_page.dart';
import 'package:ipanel/utils/cheering.dart';
import 'package:ipanel/utils/local_defaults.dart';

import 'utils/color_picker.dart';
import 'utils/const.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  Color backgroundColor = Colors.black;
  Color beginTextColor = Colors.white;
  Color endTextColor = Colors.white;

  double fontSize = 20;
  double fontSizeScale = 0.6;
  double scrollStep = 30.0;
  int flashMilliseconds = 500; //
  TextAlign textAlign = TextAlign.center;
  FontWeight fontWeight = FontWeight.normal;
  PickerFont? selectedFont = PickerFont(fontFamily: 'Inter');

  final fontSizeType = ['S', 'M', 'L', 'XL'];
  final textAlignType = ['L', 'C', 'R'];
  final fontWeightType = ['Normal', 'Bold'];
  // final flashMilliseconds = 300;
  // final scrollStep = 60.0;

  final fontWeightController = GroupButtonController(selectedIndex: 0);
  final textAlignController = GroupButtonController(selectedIndex: 1);
  final fontSizeController = GroupButtonController(selectedIndex: 1);

  var contentController = TextEditingController();
  var authorController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future(() async {
      await loadFromLocal();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> loadFromLocal() async {
    final text = await LocalDefaults.loadText();
    if(text.isNotEmpty) {
      contentController.text = text;
    }
  }

  Future<void> saveToLocal(Cheering cheering) async {
    LocalDefaults.saveText(cheering.displayText);
  }

  Widget buildDisplayText(double height) {
    return Column(
      children: [
        Container(
          height: height,
          padding: const EdgeInsets.symmetric(
            horizontal: 0.0,
            vertical: 0.0
          ),
          decoration: BoxDecoration(
            color: backgroundColor.withAlpha(50),
            // borderRadius: const BorderRadius.only(
            //   topLeft: Radius.circular(20),
            //   topRight: Radius.circular(20),
            // ),
          ),
          child: Center(
            child: IntrinsicWidth(
              child: TextField(
                controller: contentController,
                cursorColor: beginTextColor,
                style: selectedFont != null
                    ? selectedFont!.toTextStyle().copyWith(
                  color: beginTextColor,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                )
                    : const TextStyle().copyWith(
                  color: beginTextColor,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ),
                maxLines: null,
                minLines: null,
                expands: true,
                textAlign: textAlign,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Write a message here",
                  hintStyle: selectedFont != null
                      ? selectedFont!.toTextStyle().copyWith(
                    color: beginTextColor,
                    fontSize: fontSize,
                  )
                      : const TextStyle().copyWith(
                    fontWeight: fontWeight,
                    color: Colors.grey[200],
                    fontSize: fontSize,
                  ),
                  border: InputBorder.none,
                ),
                onChanged: (val) => {
                  setState(() {
                    debugPrint('edited');
                  })
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildRowTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        color: Colors.teal
      ),
    );
  }

  // font weight
  Widget get buildFontWeight => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildRowTitle("Font Weight"),
      const SizedBox(height: 10),
      GroupButton(
        buttons: fontWeightType,
        controller: fontWeightController,
        buttonIndexedBuilder: (selected, index, context) {
          FontWeight fontWeight = FontWeight.normal;

          if (index != 0) {
            fontWeight = FontWeight.bold;
          }

          return Container(
            width: 100,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: selected ? MyColors.secondary : Colors.white,
            ),
            child: Center(
              child: Text(
                fontWeightType[index],
                style: const TextStyle().copyWith(
                  fontWeight: fontWeight,
                ),
              ),
            ),
          );
        },
        options: GroupButtonOptions(
          selectedColor: MyColors.primary
        ),
        onSelected: (value, index, isSelected) {
          setState(() {
            if (index != 0) {
              fontWeight = FontWeight.bold;
            } else {
              fontWeight = FontWeight.normal;
            }
          });
        },
      ),
    ],
  );


  // buildTextAlign
  Widget get buildTextAlign => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildRowTitle("Text Align"),
      const SizedBox(height: 10),
      GroupButton(
        buttons: textAlignType,
        controller: textAlignController,
        buttonIndexedBuilder: (selected, index, context) {
          IconData? icon;
          switch (index) {
            case 0:
              icon = Icons.format_align_left;
              break;
            case 1:
              icon = Icons.format_align_center;
              break;
            case 2:
              icon = Icons.format_align_right;
              break;
            default:
          }

          return Container(
            width: 50,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: selected ? MyColors.secondary : Colors.white,
            ),
            child: Center(child: Icon(icon)),
          );
        },
        options: GroupButtonOptions(selectedColor: MyColors.primary),
        onSelected: (value, index, isSelected) {
          setState(() {
            switch (index) {
              case 0:
                textAlign = TextAlign.left;
                break;
              case 1:
                textAlign = TextAlign.center;
                break;
              case 2:
                textAlign = TextAlign.right;
                break;
              default:
            }
          });
        },
      ),
    ],
  );

  // Font Size
  Widget get buildFontSize => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildRowTitle("Font Size"),
      const SizedBox(height: 10),
      GroupButton(
        buttons: fontSizeType,
        controller: fontSizeController,
        buttonIndexedBuilder: (selected, index, context) {
          double? fontSize;
          switch (index) {
            case 0:
              fontSize = 12;
              break;
            case 1:
              fontSize = 14;
              break;
            case 2:
              fontSize = 16;
              break;
            case 3:
              fontSize = 18;
              break;
            default:
          }

          return Container(
            width: 50,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: selected ? MyColors.secondary : Colors.white,
            ),
            child: Center(
              child: Text(
                fontSizeType[index],
                style: const TextStyle().copyWith(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
        options: GroupButtonOptions(selectedColor: MyColors.primary),
        onSelected: (value, index, isSelected) {
          setState(() {
            switch (value) {
              case 'S':
                fontSize = 18;
                fontSizeScale = 0.2;
                break;
              case 'M':
                fontSize = 20;
                fontSizeScale = 0.4;
                break;
              case 'L':
                fontSize = 24;
                fontSizeScale = 0.6;
                break;
              case 'XL':
                fontSize = 28;
                fontSizeScale = 0.8;
                break;
              default:
            }
          });
        },
      )
    ],
  );

  // Font Family
  Widget get buildFontFamily => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildRowTitle("Font Family"),
      const SizedBox(height: 10),
      InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 40,
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  child: FontPicker(
                    googleFonts: myGoogleFonts,
                    initialFontFamily: selectedFont?.fontFamily,
                    showInDialog: true,
                    onFontChanged: (font) {
                      setState(() {
                        selectedFont = font;
                      });
                    },
                  ),
                ),
              );
            },
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[300]!,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              selectedFont != null
                  ? Text(
                selectedFont!.fontFamily,
                style: selectedFont!.toTextStyle(),
              )
                  : const Text(
                "Select font",
                style: TextStyle(),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    ],
  );

  // Scroll Step
  Widget get buildScrollStep => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      buildRowTitle("Scroll Step"),
      const SizedBox(height: 10),
      Text(
        scrollStep.toStringAsFixed(2),  // Sliderの値を表示
        style: const TextStyle(fontSize: 16.0),
      ),
      Slider(
        min : 5.0,
        max : 55.0,
        divisions: 10,
        value: scrollStep,   // 値を指定
        onChanged: (value) {  // 変更した値を代入
          setState(() {
            scrollStep = value;
          });
        },
      ),
    ],
  );

  // Flash Milliseconds
  Widget get buildFlashMilliseconds => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      buildRowTitle("Flash Milliseconds"),
      const SizedBox(height: 10),
      Text(
        flashMilliseconds.toStringAsFixed(2),  // Sliderの値を表示
        style: const TextStyle(fontSize: 16.0),
      ),
      Slider(
        min : 100.0,
        max : 1100.0,
        divisions: 10,
        value: flashMilliseconds.toDouble(),   // 値を指定
        onChanged: (value) {  // 変更した値を代入
          setState(() {
            flashMilliseconds = value.toInt();
          });
        },
      ),
    ],
  );

  // Begin Text Color
  Widget get buildBeginTextColor => ColorPicker(
    label: "Begin Text Color",
    selectedColor: beginTextColor,
    onColorSelected: (color) {
      setState(() {
        beginTextColor = color;
      });
    },
  );

  // End Text Color
  Widget get buildEndTextColor => ColorPicker(
    label: "End Text Color",
    selectedColor: endTextColor,
    onColorSelected: (color) {
      setState(() {
        endTextColor = color;
      });
    },
  );

  // Background Color
  Widget get buildBackgroundColor =>ColorPicker(
    label: "Background Color",
    selectedColor: backgroundColor,
    onColorSelected: (color) {
      setState(() {
        backgroundColor = color;
      });
    },
  );

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = Theme.of(context).textTheme.headlineMedium;

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final previewHeight = (screenWidth * screenWidth) / screenHeight;

    Widget buildPreview({required double width, required double height}) {
      // create cheering
      final cheering = Cheering(
        displayText: contentController.text,
        backgroundColor: backgroundColor.value,
        beginTextColor: beginTextColor.value,
        endTextColor: endTextColor.value,
        fontSizeScale: fontSizeScale,
        // fontSize: fontSize,
        fontWeight: fontWeight,
        textAlign: textAlign,
        fontFamily: selectedFont!.fontFamily,
        flashMilliseconds: flashMilliseconds,
        scrollStep: scrollStep,
      );
      return LedPanel(width: width, height: height, cheering: cheering);
    }

    return Scaffold(
      appBar: AppBar(elevation: 0,
          title: const Text('表示設定V0.1'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(previewHeight),
            child: buildPreview(width: screenWidth, height: previewHeight),
          ),
      ),
      body: SafeArea(
        child: closeKeyboardWidget(
          context,
          child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Write a Cheering", style: titleTextStyle),
                    const SizedBox(height: 20),
                    buildDisplayText(50),
                    const SizedBox(height: 10),
                    buildBeginTextColor,
                    const SizedBox(height: 10),
                    buildEndTextColor,
                    const SizedBox(height: 10),
                    buildBackgroundColor,
                    const SizedBox(height: 10),
                    buildScrollStep,
                    const SizedBox(height: 10),
                    buildFlashMilliseconds,
                    const SizedBox(height: 10),
                    // Font Weight
                    buildFontWeight,
                    const SizedBox(height: 10),
                    // Text Align
                    buildTextAlign,
                    const SizedBox(height: 10),
                    // Font Size
                    buildFontSize,
                    const SizedBox(height: 10),
                    buildFontFamily,
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: onPressRun,
        tooltip: 'run',
        child: const Icon(Icons.play_arrow),
      ),
    );
  }

  Future<void> onPressRun() async {
    // create cheering
    final cheering = Cheering(
        displayText: contentController.text,
        backgroundColor: backgroundColor.value,
        beginTextColor: beginTextColor.value,
        endTextColor: endTextColor.value,
        fontSizeScale: fontSizeScale,
        // fontSize: fontSize,
        fontWeight: fontWeight,
        textAlign: textAlign,
        fontFamily: selectedFont!.fontFamily,
        flashMilliseconds: flashMilliseconds,
        scrollStep: scrollStep,
    );

    saveToLocal(cheering).then((_) {
      Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => LedPanelPage(cheering: cheering),
        ),
      );
    });

  }
}
