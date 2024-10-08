import 'package:flutter/material.dart';
import 'package:ipanel/utils/cheering.dart';
import 'package:ipanel/utils/const.dart';

import 'package:wakelock/wakelock.dart';


class LedPanelPage extends StatefulWidget {
  const LedPanelPage({super.key, required this.cheering});

  final Cheering cheering;

  @override
  LedPanelPageState createState() => LedPanelPageState();
}

class LedPanelPageState extends State<LedPanelPage> {
  @override
  void initState() {
    super.initState();

    // 画面の向きを横向きに固定
    setLandscape();
    // Wakelock on to prevent screen from turning off
    Wakelock.enable();
  }

  @override
  void dispose() {
    Wakelock.disable(); // Disable wakelock when leaving the screen
    // 画面が離れたときに元に戻す
    setPortrait();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onDoubleTap: () => Navigator.of(context).pop(),
        child: LedPanel(cheering: widget.cheering),),
    );
  }
}

class LedPanel extends StatefulWidget {
  const LedPanel({super.key, this.width, this.height, required this.cheering});
  final double? width;
  final double? height;
  final Cheering cheering;

  @override
  LedPanelState createState() => LedPanelState();
}

class LedPanelState extends State<LedPanel>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScrollingText();
    });

    // ScrollController initialization
    _scrollController = ScrollController();
    // AnimationController for flash effect
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.cheering.flashMilliseconds ?? 300), // Flash every second
    )..repeat(reverse: true);
    _colorAnimation = ColorTween(begin: Colors.red,// Color(widget.cheering.beginTextColor ?? 0xFFFFFFFF),
        end: Colors.blue) //Color(widget.cheering.endTextColor ?? 0xFFFFFFFF))
        .animate(_animationController);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _startScrollingText() {
    // Continuous scrolling effect
    Future.delayed(const Duration(milliseconds: 50), () {
      if (_scrollController.hasClients) {
        _scrollController
            .animateTo(
          _scrollController.offset + (widget.cheering.scrollStep ?? 30.0), //5.0, // Scroll step
          duration: const Duration(milliseconds: 50),
          curve: Curves.linear,
        )
            .then((_) {
          if (_scrollController.hasClients) {
            if (_scrollController.offset >=
                _scrollController.position.maxScrollExtent) {
              _scrollController.jumpTo(0.0); // Loop the text
            }
          }
          _startScrollingText(); // Continue scrolling
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 画面サイズに合わせてレイアウトを調整
    final screenSize = MediaQuery.of(context).size;
    final panelWidth = widget.width ?? screenSize.width;
    final panelHeight = widget.height ?? screenSize.height;
    // 画面の高さに基づいて文字サイズを計算
    final fontSize = panelHeight * (widget.cheering.fontSizeScale ?? 0.6); // 画面の80%の高さに文字を設定
    final displayText = widget.cheering.displayText.isEmpty ? "This is demo text" : widget.cheering.displayText;
    return Container(
      color: Color(widget.cheering.backgroundColor ?? 0), // Background color to simulate LED display
      width: panelWidth,
      height: panelHeight,
      child: AnimatedBuilder(
        animation: _colorAnimation,
        builder: (context, child) {
          return ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal, // 横方向にスクロール
            itemCount: 1,
            itemBuilder: (context, index) {
              return Row(
                children: displayText
                    .split('')
                    .map((char) => Text(
                  char,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: widget.cheering.fontWeight, // 動的に計算した文字サイズ
                    color: _colorAnimation.value, // Flashing effect
                    decoration: TextDecoration.none, // アンダーラインなし
                  ),
                ))
                    .toList(),
              );
            },
          );
        },
      ),
    );
  }
}
