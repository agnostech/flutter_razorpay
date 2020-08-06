package `in`.agnostech.flutter_razorpay

import android.app.Activity
import android.content.Context
import android.content.Intent
import com.razorpay.Checkout
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

class FlutterRazorpayMethodChannelHandler(private val context: Context) : MethodChannel.MethodCallHandler, PluginRegistry.ActivityResultListener {

    private var razorpayDelegate: FlutterRazorpayDelegate = FlutterRazorpayDelegate()
    private lateinit var activityContext: Activity

    fun setActivity(activity: Activity) {
        activityContext = activity
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        
        when (call.method) {
            "openCheckout" -> razorpayDelegate.openCheckout(activityContext, call.arguments as  Map<String, Any>, result)
            "sync" -> razorpayDelegate.sync(result)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        Checkout.handleActivityResult(activityContext, requestCode, resultCode, data, razorpayDelegate, razorpayDelegate)
        return true
    }

}