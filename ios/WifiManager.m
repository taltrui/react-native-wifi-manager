#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(WifiManager, NSObject)

RCT_EXTERN_METHOD(connect:(NSString)ssid withPassphrase:(NSString)passphrase withIsWep:(BOOL)isWEP
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(getConnectedWifiInfo:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)

@end
