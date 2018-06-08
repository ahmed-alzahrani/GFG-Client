#  Goals For Good

### Purpose

This iOS application is to serve as a client in conjunction with the GFG-Webapp in order to facilitate charitable donations from users based on real world soccer results.

### Dependencies

1. You will need to install [Ruby Gems](https://rubygems.org/pages/download)

2. You will need to install [CoacoaPods](https://guides.cocoapods.org/using/getting-started.html), which manages library dependencies for Xcode projects, you will need this to install the Pods necessary to run the client. Install with the following command:

`sudo gem install cocoapods`

*If you do not want to grant RubyGems admin privileges for this process, visit the link above for details on Sudo-less installation*

3.  You will need to add the Supporting Files including the [Firebase Client SDK](https://firebase.google.com/docs/ios/setup). These can only be obtained from the author of this repo.

4. This client communicates with the [GFG-Webapp](https://console.firebase.google.com/), launch this web app (it automatically launches locally on the required port localhost:8080) in order for the client's communication with the app to be successful.


### Installation / Running

1. The pods will need to be installed for the app to build and run properly, this can be done once CoacoaPods has been installed with the following command from within the root directory of this project: `pod install`

2. `Goals For Good.xcworkspace` can be opened within XCode, and the application can be built and run from within Xcode with the simulator.
