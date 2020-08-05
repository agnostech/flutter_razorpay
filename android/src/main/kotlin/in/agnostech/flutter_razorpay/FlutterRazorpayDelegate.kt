package `in`.agnostech.flutter_razorpay

import android.app.Activity
import android.content.Intent
import com.razorpay.*
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject
import java.lang.Exception


class FlutterRazorpayDelegate : PaymentResultWithDataListener, ExternalWalletListener {

    private var pendingReply: Map<String, Any>? = null
    private var pendingResult: MethodChannel.Result? = null

    fun openCheckout(activity: Activity, data: Map<String, Any>, result: MethodChannel.Result) {
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

    private fun sendResult(data: Map<String, Any>) {
        pendingReply = if (pendingResult != null) {
            pendingResult!!.success(data)
            null
        } else {
            data
        }
    }

    fun sync(result: MethodChannel.Result) {
        result.success(pendingReply)
        pendingReply = null
    }

    override fun onPaymentError(code: Int, description: String, p2: PaymentData) {
        val data = mapOf("status" to "payment.error", "data" to mapOf("code" to code, "message" to description))
        sendResult(data)
    }

    override fun onPaymentSuccess(paymentId: String, paymentData: PaymentData) {
        val data = mapOf(
                "status" to "payment.success",
                "data" to mapOf(
                        "orderId" to paymentData.orderId,
                        "paymentId" to paymentData.paymentId,
                        "signature" to paymentData.signature
                )
        )
        sendResult(data)
    }

    override fun onExternalWalletSelected(walletName: String?, paymentData: PaymentData) {
        val data = mapOf(
                "status" to "payment.external",
                "data" to mapOf(
                        "walletName" to walletName,
                        "orderId" to paymentData.orderId,
                        "paymentId" to paymentData.paymentId,
                        "signature" to paymentData.signature
                )
        )
        sendResult(data)
    }
}