import 'package:ad_purchase_sample_training/main.dart';
import 'package:ad_purchase_sample_training/vm/view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RewardedScreen extends StatelessWidget {
  const RewardedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _backToHomeScreen(context);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => _backToHomeScreen(context),
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Center(
          child: Text("報酬ゲットしたで〜！"),
        ),
      ),
    );
  }

  void _backToHomeScreen(BuildContext context) {
    final vm = context.read<ViewModel>();
    vm.showInterstitialAd(
      onAdClosed: () {
        print("全画面広告閉じたで〜！[View側]");
        Navigator.pop(context);
      },
    );
  }
}
