import { NativeModules } from 'react-native';

export type ResponseType = {
  code: String;
  message: String;
};

export type NetworkInfo = {
  ssid: String;
  bssid: String;
  securityType: Number;
  mac: String;
  id: Number;
  wifiStardard: Number;
};

export type NetworkInfoError = {
  error: String;
  message: String;
};

export type WifiManagerType = {
  suggestConnection(ssid: String, passphrase: String): Promise<ResponseType>;
};

const { WifiManager } = NativeModules;

export default WifiManager as WifiManagerType;
