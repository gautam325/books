import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../custom_text_field_screen.dart';

// Riverpod provider to manage "save card" switch
final saveCardProvider = StateProvider<bool>((ref) => true);

class PaymentPage extends ConsumerStatefulWidget {
  const PaymentPage({super.key});

  @override
  ConsumerState<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends ConsumerState<PaymentPage> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Success: ${response.paymentId}")),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Failed: ${response.message}")),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Wallet Selected: ${response.walletName}")),
    );
  }

  void _startPayment() {
    var options = {
      'key': 'rzp_test_YourApiKey', // Replace with your Razorpay API key
      'amount': 50000, // in paise => ₹500.00
      'name': 'BookApp',
      'description': 'Test Payment',
      'prefill': {
        'contact': '9876543210',
        'email': 'user@example.com',
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final saveCard = ref.watch(saveCardProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          children: [
            CustomTextField(label: "Cardholder Name", icon: Icons.person),
            SizedBox(height: screenHeight * 0.025),
            CustomTextField(label: "Card Number", icon: Icons.credit_card, keyboardType: TextInputType.number),
            SizedBox(height: screenHeight * 0.025),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: "Expiry Date",
                    hintText: "MM/YY",
                    keyboardType: TextInputType.datetime,
                  ),
                ),
                SizedBox(width: screenWidth * 0.04),
                Expanded(
                  child: CustomTextField(
                    label: "CVV",
                    hintText: "***",
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.025),
            Row(
              children: [
                Switch(
                  value: saveCard,
                  onChanged: (val) {
                    ref.read(saveCardProvider.notifier).state = val;
                  },
                ),
                const Text(
                  "Save card for future",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.05),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _startPayment,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Pay Now", style: TextStyle(fontSize: 16,color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
