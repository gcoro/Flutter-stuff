package com.example.cat_app

import io.flutter.embedding.engine.plugins.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.Registrar

object WebViewPlugin {
    fun registerWith(registrar: Registrar) {
        registrar
                .platformViewRegistry()
                .registerViewFactory(
                        "webview", WebViewFactory(registrar.messenger()))
    }
}
