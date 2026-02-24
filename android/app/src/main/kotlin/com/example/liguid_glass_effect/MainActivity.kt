package com.example.liguid_glass_effect

import android.content.ComponentName
import android.content.pm.PackageManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.example.liguid_glass_effect/icon"

    private val allAliases = listOf("DEFAULT", "CLONE_DEFAULT", "dark", "blue", "red", "green", "gold")

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "setIcon" -> {
                    val iconName = call.argument<String?>("iconName") ?: "DEFAULT"
                    try {
                        setAppIcon(iconName)
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("ICON_ERROR", e.message, null)
                    }
                }
                "getIcon" -> {
                    result.success(getCurrentIcon())
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun setAppIcon(targetAlias: String) {
        val pm = packageManager
        val pkg = packageName

        // Step 1: Disable MainActivity's own launcher entry
        val mainComponent = ComponentName(pkg, "$pkg.MainActivity")
        pm.setComponentEnabledSetting(
            mainComponent,
            PackageManager.COMPONENT_ENABLED_STATE_DISABLED,
            PackageManager.DONT_KILL_APP
        )

        // Step 2: Disable ALL aliases
        for (alias in allAliases) {
            val component = ComponentName(pkg, "$pkg.$alias")
            pm.setComponentEnabledSetting(
                component,
                PackageManager.COMPONENT_ENABLED_STATE_DISABLED,
                PackageManager.DONT_KILL_APP
            )
        }

        // Step 3: Enable target
        if (targetAlias == "DEFAULT") {
            // For default: re-enable both MainActivity and DEFAULT alias
            pm.setComponentEnabledSetting(
                mainComponent,
                PackageManager.COMPONENT_ENABLED_STATE_ENABLED,
                PackageManager.DONT_KILL_APP
            )
            pm.setComponentEnabledSetting(
                ComponentName(pkg, "$pkg.DEFAULT"),
                PackageManager.COMPONENT_ENABLED_STATE_ENABLED,
                PackageManager.DONT_KILL_APP
            )
        } else {
            // For any other icon: enable only that alias
            val target = ComponentName(pkg, "$pkg.$targetAlias")
            pm.setComponentEnabledSetting(
                target,
                PackageManager.COMPONENT_ENABLED_STATE_ENABLED,
                PackageManager.DONT_KILL_APP
            )
        }
    }

    private fun getCurrentIcon(): String {
        val pm = packageManager
        val pkg = packageName
        for (alias in allAliases) {
            val component = ComponentName(pkg, "$pkg.$alias")
            val state = pm.getComponentEnabledSetting(component)
            if (state == PackageManager.COMPONENT_ENABLED_STATE_ENABLED) {
                return alias
            }
        }
        return "DEFAULT"
    }
}