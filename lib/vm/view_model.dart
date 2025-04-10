import 'package:ad_purchase_sample_training/model/ad_manager.dart';
import 'package:ad_purchase_sample_training/model/in_app_purchase_manager.dart';
import 'package:flutter/foundation.dart';

class ViewModel extends ChangeNotifier {
  final adManager = AdManager();
  final inAppPurchaseManager = InAppPurchaseManager();

  void initAdmob() async {
    await adManager.initAdmob();
  }

  void loadBannerAd() {
    adManager.loadBannerAd();
  }

  void showInterstitialAd({required VoidCallback onAdClosed}) {
    adManager.showInterstitialAd(onAdClosed);
  }

  void showRewardedAd({required VoidCallback onRewardEarned}) {
    adManager.showRewardedAd(onRewardEarned);
  }
}
