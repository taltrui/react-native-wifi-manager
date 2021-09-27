import * as React from 'react';

import { StyleSheet, View, Text, TextInput, Button } from 'react-native';
import WifiManager, { ResponseType } from 'react-native-wifi-manager';

export default function App() {
  const [result, setResult] = React.useState<ResponseType>();
  const [error, setError] = React.useState<ResponseType>();
  const [ssid, setSSID] = React.useState<String | undefined>();
  const [pass, setPass] = React.useState<String | undefined>();
  const [wifiInfo, setWifiResult] =
    React.useState<{ ssid: String; passphrase: String; isWEP: Boolean }>();
  const [wifiError, setWifiError] = React.useState<String>();

  const connect = async () => {
    try {
      const a = await WifiManager.suggestConnection(ssid || '', pass || '');
      setResult(a);
    } catch (e) {
      setError(e);
    }
  };

  return (
    <View style={styles.container}>
      <Text>Result: {JSON.stringify(result)}</Text>
      <Text>Error: {JSON.stringify(error)}</Text>
      <Text>Wifi Result: {JSON.stringify(wifiInfo)}</Text>
      <Text>Wifi Error: {wifiError}</Text>

      <TextInput onChangeText={setSSID} placeholder="SSID" />
      <TextInput onChangeText={setPass} placeholder="Pass" />
      <Button title="set wifi" onPress={connect} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
