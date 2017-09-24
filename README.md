# My MOAI (v1.6 Stable) playground

Forked from: [moaiforge](https://github.com/moaiforge/moai-sdk).

Original readme: [here](https://github.com/moaiforge/moai-sdk/blob/1.6-stable/README.md).

Linux Build: [![Build Status](https://api.travis-ci.org/btatarov/moai-sdk.svg?branch=postmorph)](https://travis-ci.org/btatarov/moai-sdk)

## New features

### Core (libmoai)
* fmod as module (from [moai-fmod-studio](https://github.com/Vavius/moai-fmod-studio))
* spine as module (from [plugin-moai-spine](https://github.com/Vavius/plugin-moai-spine))
* openssl 1.0.2g
* libpng-1.4.19 (TODO: currently only for android)
* luajit 2.0.4
* MOAIImage::loadDual (from [Stirfire Studios](https://github.com/StirfireStudios/moai-dev))
* TODO: move loadDual in a separate module (loader)
* TODO: facebook setToken and graphRequest (android and ios)

### Android
* immersive mode
* CHANGE: LinearLayoutIMETrap -> RelativeLayoutIMETrap (for banner ad support)
* MOAIAppAndroid::closeApp ()
* MOAIObbDownloaderAndroid (downloading extension files for googleplay)
* adcolony-2.3.4 (rewarded video)
* amazon ads (interstitial and banner)
* amazon billing v2
* amazon gamecircle
* admob-8.4.0 (interstitial and banner)
* applovin-7.0.3-fireos (interstitial and rewarded video)
* chartboost-6.4.1 (interstitial)
* crittercism-5.5.5
* facebook-4.5.1 (TODO: update to latest version)
* heyzap-9.4.5 (interstitial and rewarded video)
* google-play-services-8.4.0 (stripped)
* revmob-9.0.8 (interstitial and rewarded video)
* startapp-3.3.2 (interstitial, rewarded video, return ad and exit ad)
* twitter4j-4.0.4
* vungle-3.3.4 (rewarded video)
* util/host-android ([hosts.lua sample](https://github.com/btatarov/moai-sdk/blob/postmorph/util/host-android/hosts.lua.sample))
* no multi-dex build (via stripped google play services, see strip.sh)

### iOS
* CHANGE: framework directory separation (moved from 3rdparty to 3rdparty-ios)
* MOAILucidViewIOS (transparent view wrapper responding only to touches in child views)
* adcolony-3.2.1 (rewarded video)
* admob-7.14.0 (intersitial and banner)
* applovin-4.3.1 (interstitial and rewarded video)
* chartboost-6.4.2 (interstitial and rewarded video)
* crittercism-5.5.1
* facebook-4.17.0
* revmob-10.0.0 (interstitial, banner and rewarded video)
* startapp-3.3.2 (interstitial, banner and return ad)
* vungle-5.2.0 (rewarded video)
* util/host-ios ([hosts.lua sample](https://github.com/btatarov/moai-sdk/blob/postmorph/util/host-ios/hosts.lua.sample))
* TODO: missing sample (chartboost)

### Samples
* android-adcolony
* android-admob
* android-amazonads
* android-billing-amazon
* android-chartboost
* android-facebook
* android-gamecircle
* android-heyzap
* android-play-services
* android-revmob
* android-startapp
* android-twitter
* android-vungle
* fmod
* ios-adcolony
* ios-admob
* ios-applovin
* ios-facebook
* ios-revmob
* ios-startapp
* ios-vungle
* spine-attachment-vertices
* spine-boy
* spine-events
* spine-ffd
* spine-procedural
* spine-skins
