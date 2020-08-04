package `in`.agnostech.flutter_razorpay

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.util.Log
import com.razorpay.*
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject
import java.lang.Exception


class FlutterRazorpayDelegate : PaymentResultWithDataListener, ExternalWalletListener {

    private var pendingResult: MethodChannel.Result? = null

    fun openCheckout(activity: Activity, data: Map<String, Any>,  result: MethodChannel.Result) {
        pendingResult = result

        try {
            val options = JSONObject(data)

            val intent = Intent(activity, CheckoutActivity::class.java)
            intent.putExtra("OPTIONS", options.toString())
            intent.putExtra("FRAMEWORK", "flutter")
            activity.startActivityForResult(intent, Checkout.RZP_REQUEST_CODE)

        } catch (error: Exception) {
            result.error("error", error.message, error.localizedMessage)
        }
    }

    private fun sendResult(data: Map<String, Any>? ) {
        pendingResult?.success(true)
    }

    override fun onPaymentError(code: Int, description: String, p2: PaymentData) {
        Log.d("RAZORPAY FLUTTER ERROR", description)
        sendResult(null)
    }

    override fun onPaymentSuccess(paymentId: String, paymentData: PaymentData) {
        Log.d("RAZORPAY FLUTTER S", paymentData.data.toString())
        sendResult(null)
    }

    override fun onExternalWalletSelected(p0: String?, p1: PaymentData) {
        Log.d("RAZORPAY FLUTTER EW", p1.data.toString())
        sendResult(null)
    }
}