package com.reactnativewifimanager

import android.content.Context
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities
import android.net.NetworkRequest
import android.net.wifi.WifiNetworkSpecifier
import android.os.Build
import android.os.PatternMatcher
import androidx.annotation.RequiresApi
import com.facebook.react.bridge.*

class WifiManagerModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {
  private val context = reactApplicationContext.applicationContext;

  override fun getName(): String {
    return "WifiManager"
  }

  @RequiresApi(Build.VERSION_CODES.Q)
  @ReactMethod
  fun suggestConnection(ssid: String, passphrase: String, promise: Promise) {
    val specifier = WifiNetworkSpecifier.Builder().setSsidPattern(PatternMatcher(ssid, PatternMatcher.PATTERN_PREFIX)).setWpa2Passphrase(passphrase).build();

    val networkRequest = NetworkRequest.Builder().addTransportType(NetworkCapabilities.TRANSPORT_WIFI).setNetworkSpecifier(specifier).build();

    val manager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

    val networkCallback = object : ConnectivityManager.NetworkCallback() {
      override fun onAvailable(network: Network) {
        val response = WritableNativeMap();
        response.putString("code", "CONNECTED");
        response.putString("message", "Successfully connected to $ssid")
        promise.resolve(response)
      }

      override fun onUnavailable() {
        promise.reject("UNABLE_TO_CONNECT", "Couldn't connect to $ssid. This may be caused because the network wasn't found or the user cancelled the operation")
      }
    }
    manager.requestNetwork(networkRequest, networkCallback)
  }

  @ReactMethod
  fun getCurrentNetworkInfo(promise: Promise) {
    
  }
}
