package com.example.cat_app

import android.content.Context
import android.view.View
import android.widget.TextView
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView
import android.webkit.*
import android.net.http.SslError
import android.webkit.WebChromeClient
import android.webkit.WebView
import android.graphics.Bitmap
import android.webkit.WebViewClient

class MyWebView internal constructor(context: Context, messenger: BinaryMessenger, id: Int) : PlatformView, MethodCallHandler {
    private val webView: WebView
    private val methodChannel: MethodChannel

    override fun getView(): View {
        return webView
    }

    init {
        webView = WebView(context)

        methodChannel = MethodChannel(messenger, "webview$id")
        methodChannel.setMethodCallHandler(this)
    }

    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        when (methodCall.method) {
            "loadUrl" -> loadUrl(methodCall, result)
            else -> result.notImplemented()
        }
    }

    private fun loadUrl(methodCall: MethodCall, result: Result) {
        val url = methodCall.arguments as String
        webView.loadUrl(url)
        result.success(null)
    }

    override fun dispose() {
        // TODO dispose actions if needed
    }
}