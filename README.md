# My MOAI (v1.6 Stable) playground

Forked from: [moaiforge](https://github.com/moaiforge/moai-sdk).

Original readme: [here](https://github.com/moaiforge/moai-sdk/blob/1.6-stable/README.md).

Linux Build: [![Build Status](https://api.travis-ci.org/btatarov/moai-sdk.svg?branch=postmorph)](https://travis-ci.org/btatarov/moai-sdk)
macOS Build: [![Build Status](https://api.travis-ci.org/btatarov/moai-sdk.svg?branch=travis-osx)](https://travis-ci.org/btatarov/moai-sdk)
Windows Build: [![Build status](https://ci.appveyor.com/api/projects/status/skkhw3sjopdkj5vy?svg=true)](https://ci.appveyor.com/project/btatarov/moai-sdk)

## New features

### Core (libmoai)
* fmod as module (from [moai-fmod-studio](https://github.com/Vavius/moai-fmod-studio))
* spine as module (from [plugin-moai-spine](https://github.com/Vavius/plugin-moai-spine))
* curl 7.66.0
* libpng 1.4.19
* LuaJIT 2.1.0-beta3
* mbedtls 2.16.3 (openssl and crypto replacement)
* MOAIColor::setColorHSL
* MOAIImage::loadDual (from [Stirfire Studios](https://github.com/StirfireStudios/moai-dev))
* MOAIParticlePexPlugin::loadFromString
* MOAISim.exitApp (desktop hosts)
* TODO: move loadDual in a separate module (loader)

### Android
* Full screen mode with cutout (notch) support
* 64bit support
* CHANGE: LinearLayoutIMETrap -> RelativeLayoutIMETrap (for banner ad support)
* MOAIAppAndroid::closeApp ()
* MOAIObbDownloaderAndroid (downloading extension files for googleplay)
* adcolony-3.2.1 (rewarded video)
* amazon ads (interstitial and banner)
* amazon billing v2
* amazon gamecircle
* admob-8.4.0 (interstitial and banner)
* applovin-7.3.2 (interstitial and rewarded video)
* chartboost-6.4.1 (interstitial)
* crittercism-5.5.5
* facebook-4.5.1 (TODO: update to latest version)
* heyzap-9.13.3 (interstitial and rewarded video)
* google-play-services-r29 (also see [strip.sh](https://github.com/btatarov/moai-sdk/blob/postmorph/3rdparty-android/google-play-services-r29/lib/strip.sh))
* revmob-10.0.0 (interstitial and rewarded video)
* startapp-3.6.6 (interstitial, rewarded video, return ad and exit ad)
* twitter4j-4.0.4
* vungle-6.3.17 (rewarded video)
* util/host-android ([hosts.lua sample](https://github.com/btatarov/moai-sdk/blob/postmorph/util/host-android/hosts.lua.sample))
* no multi-dex build (via stripped google play services, see strip.sh)
* TODO: remove support for Chartboost and Vungle

### iOS
* CHANGE: framework directory separation (moved from 3rdparty to 3rdparty-ios)
* MOAILucidViewIOS (transparent view wrapper responding only to touches in child views)
* adcolony-3.2.1 (rewarded video)
* admob-7.24.0 (intersitial and banner)
* applovin-4.3.1 (interstitial and rewarded video)
* chartboost-7.0.1 (interstitial and rewarded video)
* crittercism-5.6.8
* facebook-4.26.0
* revmob-10.0.0 (interstitial, banner and rewarded video)
* startapp-3.5.0 (interstitial, banner and return ad)
* vungle-5.2.0 (rewarded video)
* util/host-ios ([hosts.lua sample](https://github.com/btatarov/moai-sdk/blob/postmorph/util/host-ios/hosts.lua.sample))

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
* ios-chartboost
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
