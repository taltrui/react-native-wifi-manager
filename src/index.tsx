import { NativeModules } from 'react-native';

type WifiManagerType = {
  connect(
    ssid: String,
    passphrase: String,
    isWEP: Boolean
  ): Promise<{ ssid: String; passphrase: String; isWEP: Boolean }>;
};

const { WifiManager } = NativeModules;

export default WifiManager as WifiManagerType;
