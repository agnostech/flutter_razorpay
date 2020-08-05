package `in`.agnostech.flutter_razorpay

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.Registrar

/** FlutterRazorpayPlugin */
public class FlutterRazorpayPlugin : FlutterPlugin, ActivityAware {

    private lateinit var channel: MethodChannel
    private lateinit var methodHandler: FlutterRazorpayMethodChannelHandler
    private var pluginBinding: ActivityPluginBinding? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "in.agnostech.flutterrazorpay/flutter_razorpay")
        methodHandler = FlutterRazorpayMethodChannelHandler(flutterPluginBinding.applicationContext)
        channel.setMethodCallHandler(methodHandler)
    }

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "in.agnostech.flutterrazorpay/flutter_razorpay")
            val methodChannel = FlutterRazorpayMethodChannelHandler(registrar.activeContext());
            methodChannel.setActivity(registrar.activity())
            channel.setMethodCallHandler(methodChannel)
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onDetachedFromActivity() {
        pluginBinding?.removeActivityResultListener(methodHandler)
        pluginBinding = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        methodHandler.setActivity(binding.activity)
        pluginBinding = binding
        pluginBinding?.addActivityResultListener(methodHandler)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }
}
