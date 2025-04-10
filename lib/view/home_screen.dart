import 'package:ad_purchase_sample_training/view/rewarded_screen.dart';
import 'package:ad_purchase_sample_training/vm/view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final vm = context.read<ViewModel>();
    vm.loadBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    print("HomeScreen#build");
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: IconButton(
                onPressed: () => _goRewardedScreen(),
                icon: Icon(
                  Icons.play_circle,
                  size: 200.0,
                ),
              ),
            ),
          ),
          Consumer<ViewModel>(
            builder: (context, vm, child) {
              print("consumer: ${(vm.adManager.bannerAd != null)}");
              final bannerAd = vm.adManager.bannerAd;
              if (bannerAd == null) {
                return Container();
              } else {
                return Container(
                  width: bannerAd.size.width.toDouble(),
                  height: bannerAd.size.height.toDouble(),
                  child: AdWidget(
                    ad: bannerAd,
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }

  void _goRewardedScreen() {
    final vm = context.read<ViewModel>();
    vm.showRewardedAd(
      onRewardEarned: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RewardedScreen(),
          ),
        );
      },
    );
  }
}
