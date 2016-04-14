# My MOAI (v1.6 Stable) playground

Forked from: [moaiforge](https://github.com/moaiforge/moai-sdk).

Original readme: [here](https://github.com/moaiforge/moai-sdk/blob/1.6-stable/README.md).

Linux Build: [![Build Status](https://api.travis-ci.org/btatarov/moai-sdk.svg?branch=postmorph)](https://travis-ci.org/btatarov/moai-sdk)

## New features

### Core (libmoai)
* fmod as module (from [moai-fmod-studio](https://github.com/Vavius/moai-fmod-studio))
* spine as module (from [plugin-moai-spine](https://github.com/Vavius/plugin-moai-spine))
* openssl 1.0.2g
* luajit 2.0.4
* MOAIImage::loadDual (from [Stirfire Studios](https://github.com/StirfireStudios/moai-dev))
* TODO: move loadDual in a separate module (loader)
* TODO: facebook graph requests and user tokens (ios and android)

### Android
* CHANGE: LinearLayoutIMETrap -> RelativeLayoutIMETrap (for banner ad support)
* MOAIAppAndroid::isKindleFireDevice ()
* adcolony-2.3.4 (rewarded video)
* amazon ads (interstitial and banner)
* amazon billing v2
* amazon gamecircle
* admob-8.4.0 (interstitial and banner)
* chartboost-6.4.1 (interstitial)
* crittercism-5.5.5
* facebook-4.5.1 (4.6 and above require minSdkVersion=15)
* heyzap-9.4.5 (interstitial and rewarded video)
* google-play-services-8.4.0 (stripped)
* revmob-9.0.8 (interstitial and rewarded video)
* startapp-3.3.2 (interstitial, rewarded video, return ad and exit ad)
* twitter4j-4.0.4
* vungle-3.3.4 (rewarded video)
* util/host-android ([hosts.lua sample](https://github.com/btatarov/moai-sdk/blob/postmorph/util/host-android/hosts.lua.sample))
* no multi-dex build (via stripped google play services, see strip.sh)

### iOS
* WIP: framework directory separation (moved from 3rdparty to 3rdparty-ios)
* adcolony-2.6.1 (rewarded video)
* admob-7.7.1 (intersitial and banner)
* chartboost-6.4.2 (interstitial and rewarded video)
* crittercism-5.5.1
* facebook-4.10.1 (not fully tested, needs some more work)
* vungle-3.2.0 (rewarded video)
* util/host-ios ([hosts.lua sample](https://github.com/btatarov/moai-sdk/blob/postmorph/util/host-ios/hosts.lua.sample))
* TODO: missing samples

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
* ios-admob
* ios-vungle
* spine-attachment-vertices
* spine-boy
* spine-events
* spine-ffd
* spine-procedural
* spine-skins
