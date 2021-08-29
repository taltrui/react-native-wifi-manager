import { NativeModules } from 'react-native';

type WifiManagerType = {
  multiply(a: number, b: number): Promise<number>;
};

const { WifiManager } = NativeModules;

export default WifiManager as WifiManagerType;
