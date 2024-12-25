import 'dart:async';
import 'package:flutter/material.dart';
import 'widgets/earn_button.dart';
import 'widgets/upgrade_button.dart';

class ClickerGame extends StatefulWidget {
  const ClickerGame({super.key});

  @override
  State<ClickerGame> createState() => _ClickerGameState();
}

class _ClickerGameState extends State<ClickerGame> {
  int _coins = 0; // Total coins
  int _coinsPerClick = 5; // Coins earned per click
  int _coinsPerSecond = 3; // Coins earned passively per second
  Timer? _passiveTimer;

  // Upgrade costs and increments
  int _clickUpgradeCost = 50; // Cost to increase coins per click
  final int _clickUpgradeIncrement = 2; // Increment for coins per click

  int _passiveUpgrade1Cost =
      100; // Cost to increase passive earnings (upgrade 1)
  final int _passiveUpgrade1Increment =
      3; // Increment for passive earnings (upgrade 1)

  int _passiveUpgrade2Cost =
      200; // Cost to increase passive earnings (upgrade 2)
  final int _passiveUpgrade2Increment =
      5; // Increment for passive earnings (upgrade 2)

  @override
  void initState() {
    super.initState();
    _startPassiveEarnings();
  }

  @override
  void dispose() {
    _passiveTimer?.cancel();
    super.dispose();
  }

  void _startPassiveEarnings() {
    _passiveTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _coins += _coinsPerSecond;
      });
    });
  }

  void _earnCoins() {
    setState(() {
      _coins += _coinsPerClick;
    });
  }

  void _upgradeCoinsPerClick() {
    if (_coins >= _clickUpgradeCost) {
      setState(() {
        _coins -= _clickUpgradeCost;
        _coinsPerClick += _clickUpgradeIncrement;
        _clickUpgradeCost = (_clickUpgradeCost * 1.5).toInt();
      });
    }
  }

  void _upgradePassiveEarnings1() {
    if (_coins >= _passiveUpgrade1Cost) {
      setState(() {
        _coins -= _passiveUpgrade1Cost;
        _coinsPerSecond += _passiveUpgrade1Increment;
        _passiveUpgrade1Cost = (_passiveUpgrade1Cost * 1.5).toInt();
      });
    }
  }

  void _upgradePassiveEarnings2() {
    if (_coins >= _passiveUpgrade2Cost) {
      setState(() {
        _coins -= _passiveUpgrade2Cost;
        _coinsPerSecond += _passiveUpgrade2Increment;
        _passiveUpgrade2Cost = (_passiveUpgrade2Cost * 1.5).toInt();
      });
    }
  }

  void _shop(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Text(
                    'UPGRADE SHOP',
                    style: TextStyle(fontSize: 14),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the modal
                    },
                    child: const Text("Close"),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              //put the upgrade button
              UpgradeButton(
                onPressed:
                    _coins >= _clickUpgradeCost ? _upgradeCoinsPerClick : null,
                upgradeCost: _clickUpgradeCost,
                upgradeIncrement: _clickUpgradeIncrement,
                description: 'Increase Coins per Click',
              ),
              const SizedBox(height: 20),
              UpgradeButton(
                onPressed: _coins >= _passiveUpgrade1Cost
                    ? _upgradePassiveEarnings1
                    : null,
                upgradeCost: _passiveUpgrade1Cost,
                upgradeIncrement: _passiveUpgrade1Increment,
                description: 'Boost Passive Earnings (Upgrade 1)',
              ),
              const SizedBox(height: 20),
              UpgradeButton(
                onPressed: _coins >= _passiveUpgrade2Cost
                    ? _upgradePassiveEarnings2
                    : null,
                upgradeCost: _passiveUpgrade2Cost,
                upgradeIncrement: _passiveUpgrade2Increment,
                description: 'Boost Passive Earnings (Upgrade 2)',
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 70,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //currency
                  Column(

                    children: [
                      //amount
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //icon
                          Image.asset(
                            'assets/currency.jpg',
                            height: 50,
                            width: 50,
                          ),
                          //amount
                          Text('$_coins'),
                        ],
                      ),
                      //per sec
                      Text('$_coinsPerSecond/sec'),
                    ],
                  ),
                  //shop
                  GestureDetector(
                    onTap: () {
                      _shop(context); // Open shop
                    },
                    child: Image.asset(
                      'assets/shop.jpg', // Replace with your shop icon
                      height: 50,
                      width: 50,
                    ),
                  )
                ],
              ),
            ),
            EarnButton(onPressed: _earnCoins, coinsPerClick: _coinsPerClick),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
