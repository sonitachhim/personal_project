import 'package:flutter/material.dart';

class UpgradeButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final int upgradeCost;
  final int upgradeIncrement;
  final String description;

  const UpgradeButton({
    Key? key,
    required this.onPressed,
    required this.upgradeCost,
    required this.upgradeIncrement,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        '$description (+$upgradeIncrement) for $upgradeCost Coins',
        textAlign: TextAlign.center,
      ),
    );
  }
}
