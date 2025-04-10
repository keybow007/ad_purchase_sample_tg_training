import 'dart:io';
import 'dart:ui';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/1033173712";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4411468910";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/5224354917";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/1712485313";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  //-----

  BannerAd? bannerAd;
  InterstitialAd? interstitialAd;
  RewardedAd? rewardedAd;

  Future<void> initAdmob() async {
    print("AdManager#initAdmob");
    MobileAds.instance.initialize();
    initBannerAd();
    loadInterstitialAd();
    loadRewardedAd();
  }

  void initBannerAd() {
    print("initBannerAd");
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: bannerAdUnitId,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          print("バナー広告のロード成功");
        },
        onAdFailedToLoad: (ad, error) {
          print("バナー広告のロード失敗: ${error.message}");
        },
      ),
    );
  }

  void loadBannerAd() {
    print("loadBannerAd");
    bannerAd?.load();
  }

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          print("全画面広告のロード成功");
          interstitialAd = ad;
        },
        onAdFailedToLoad: (error) {
          print("全画面広告のロード失敗: ${error.code} | ${error.message}");
          interstitialAd = null;
        },
      ),
    );
  }

  void showInterstitialAd(VoidCallback onAdClosed) {
    interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        print("全画面広告閉じたで〜！");
        ad.dispose();
        loadInterstitialAd();
        onAdClosed();
      },
      onAdShowedFullScreenContent: (ad) {
        print("全画面広告の表示成功");
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print("全画面広告の表示失敗: ${error.code} | ${error.message}");
      },
    );

    interstitialAd?.show();
  }

  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          print("リワード広告のロード成功");
          rewardedAd = ad;
        },
        onAdFailedToLoad: (error) {
          print("リワード広告のロード失敗: ${error.code} | ${error.message}");
          rewardedAd = null;
        },
      ),
    );
  }

  void showRewardedAd(VoidCallback onRewardEarned) {
    rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        print("リワード広告閉じたで〜！");
        ad.dispose();
        loadRewardedAd();
      },
      onAdShowedFullScreenContent: (ad) {
        print("リワード広告の表示成功");
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print("リワード広告の表示失敗: ${error.code} | ${error.message}");
      },
    );

    rewardedAd?.show(
      onUserEarnedReward: (ad, _) {
        print("報酬獲得したで〜！");
        ad.dispose();
        loadRewardedAd();
        onRewardEarned();
      },
    );
  }
}
