import NetworkExtension
import SystemConfiguration.CaptiveNetwork

@objc(WifiManager)
class WifiManager: NSObject {
    
    @objc(connect:withPassphrase:withIsWep:withResolver:withRejecter:)
    func connect(ssid: String, passphrase: String, isWEP: Bool, resolve: @escaping RCTPromiseResolveBlock,reject: @escaping RCTPromiseRejectBlock) -> Void {
        
        func completionHandler(error: Error?) -> Void {
            
            
            if error != nil {
                reject(error.debugDescription, error?.localizedDescription, error)
                return
            }
            
            let currentWiFi = _getConnectedWifiInfo();
            
            if let currentSSID = currentWiFi?["SSID"] {
                if currentSSID as! String == ssid {
                    resolve("Connected to \(ssid)")
                    return
               }
            } else {
                resolve("Network configured, but not connected")
                return
            }
        
            resolve("Network configured, but can't confirm if connected")
            
            
        }
        
        let config = NEHotspotConfiguration(ssid: ssid, passphrase: passphrase, isWEP: false)

        config.joinOnce = true

        NEHotspotConfigurationManager.shared.apply(config, completionHandler: completionHandler)
        
//        resolve([["ssid":ssid, "passphrase": passphrase, "isWEP": isWEP]])
//        reject("Error", "Error desc", nil)
        }
    
    @objc(getConnectedWifiInfo:withRejecter:)
    func getConnectedWifiInfo(resolve: @escaping RCTPromiseResolveBlock,reject: @escaping RCTPromiseRejectBlock) -> Void {
        
        let info = _getConnectedWifiInfo();
        
        if info != nil {
            resolve(info)
        } else {
            reject("Couldn't get connected WiFi info", "", nil)
        }
    }
    
    private func _getConnectedWifiInfo() -> [AnyHashable: Any]? {
            if let ifs = CFBridgingRetain(CNCopySupportedInterfaces()) as? [String],
                let ifName = ifs.first as CFString?,
                let info = CFBridgingRetain( CNCopyCurrentNetworkInfo((ifName))) as? [AnyHashable: Any] {
                    return info
                }
            return nil
        }
    
}
