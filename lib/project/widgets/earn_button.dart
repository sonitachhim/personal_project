import 'package:flutter/material.dart';

class EarnButton extends StatelessWidget {
  final VoidCallback onPressed;
  final int coinsPerClick;

  const EarnButton({
    super.key,
    required this.onPressed,
    required this.coinsPerClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Image.asset('assets/background.jpg', height: 670,),
      //child: Text('Earn $coinsPerClick Coins!'),
    );
  }
}
