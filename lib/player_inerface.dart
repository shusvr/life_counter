import 'package:flutter/material.dart';
import 'player_card_components/player_card.dart';
import 'player_settings_card.dart';

class PlayerInerface extends StatefulWidget {
  final int playerId;
  final String colorHex;
  final int counter;
  final double aspectRatio;
  final VoidCallback topOnTap;
  final VoidCallback topOnLongTap;
  final VoidCallback bottomOnTap;
  final VoidCallback bottomOnLongTap;
  final VoidCallback onSettingsTap;

  const PlayerInerface({super.key, 
    required this.playerId,
    required this.colorHex,
    required this.counter,
    required this.aspectRatio,
    required this.topOnTap,
    required this.topOnLongTap,
    required this.bottomOnTap,
    required this.bottomOnLongTap,
    required this.onSettingsTap,
  });


  @override
  _PlayerInterfaceState createState() => _PlayerInterfaceState();
}

class _PlayerInterfaceState extends State<PlayerInerface> {
  bool _isTopCardVisible = true;
  double _topCardPosition = 0;
  double _bottomCardPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Bottom card
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: -_bottomCardPosition,
            right: _bottomCardPosition,
            top: 0,
            bottom: 0,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                if (!_isTopCardVisible) {
                  setState(() {
                    _bottomCardPosition -= details.delta.dx;
                    _bottomCardPosition = _bottomCardPosition.clamp(-100.0, 0.0);
                  });
                }
              },
              onHorizontalDragEnd: (details) {
                if (!_isTopCardVisible && _bottomCardPosition < -50) {
                  _showTopCard();
                } else {
                  _resetBottomCard();
                }
              }, //PlayerSettingsCard(playerId: widget.playerId),
              //the bottom card
              child: PlayerSettingsCard(
                playerId: widget.playerId,
                aspectRatio: widget.aspectRatio,
                onSettingsTap: widget.onSettingsTap,
              ),
            ),
          ),
          // Top card
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: -_topCardPosition,
            right: _topCardPosition,
            top: 0,
            bottom: 0,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                if (_isTopCardVisible) {
                  setState(() {
                    _topCardPosition -= details.delta.dx;
                    _topCardPosition = _topCardPosition.clamp(0.0, 100.0);
                  });
                }
              },
              onHorizontalDragEnd: (details) {
                if (_isTopCardVisible && _topCardPosition > 50) {
                  _hideTopCard();
                } else {
                  _resetTopCard();
                }
              },
              //the top card
              child: PlayerCard(
                playerId: widget.playerId,
                colorHex: widget.colorHex,
                counter: widget.counter,
                aspectRatio: widget.aspectRatio,
                topOnTap: widget.topOnTap,
                topOnLongTap: widget.topOnLongTap,
                bottomOnTap: widget.bottomOnTap,
                bottomOnLongTap: widget.bottomOnLongTap,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showTopCard() {
    setState(() {
      _isTopCardVisible = true;
      _topCardPosition = 0;
      _bottomCardPosition = 0;
    });
  }

  void _hideTopCard() {
    setState(() {
      _isTopCardVisible = false;
      _topCardPosition = MediaQuery.of(context).size.height;
      _bottomCardPosition = 0;
    });
  }

  void _resetTopCard() {
    setState(() {
      _topCardPosition = 0;
    });
  }

  void _resetBottomCard() {
    setState(() {
      _bottomCardPosition = 0;
    });
  }
}
