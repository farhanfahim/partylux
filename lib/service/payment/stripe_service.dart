import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:partylux/Constants/app_constants.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:partylux/Utils/Network/tost.dart';

class StripeService {
  static const CURRENCY = "USD", MERCHANT_COUNTRY_CODE = "Us";

  static Future<void> init() async {
    Stripe.publishableKey = AppConstants.stripePublicKey;
    Stripe.merchantIdentifier = Platform.isIOS?AppConstants.applePayMerchantId:AppConstants.googlePayMerchantId;
    Stripe.urlScheme = 'flutterstripe';
    await Stripe.instance.applySettings();
  }

  static Future<String?> createPaymentMethod(String email) async {
    try {
      final billingDetails = BillingDetails(
        email: email,
/*        phone: '+48888000888',
        address: Address(
          city: 'Houston',
          country: 'US',
          line1: '1459  Circle Drive',
          line2: '',
          state: 'Texas',
          postalCode: '77063',
        ),*/
      ); //

      final paymentMethod = await Stripe.instance.createPaymentMethod(
          params: PaymentMethodParams.card(
        paymentMethodData: PaymentMethodData(
          billingDetails: billingDetails,
        ),
      ));
      log("paymentMethod: ${jsonEncode(paymentMethod.toJson())}");
      return paymentMethod.id;
    } catch (ex) {
      print("createPaymentMethod: $ex");
      Toast().error(massage: "createPaymentMethod: $ex");
    }
  }

  static Future<String?> openGooglePay(String name, double amount) async {
    try {
      final paymentMethod = await Stripe.instance.createPlatformPayPaymentMethod(
        params: PlatformPayPaymentMethodParams.googlePay(
          googlePayParams: GooglePayParams(
            testEnv: false,
            merchantName: 'Example Merchant Name',
            merchantCountryCode: MERCHANT_COUNTRY_CODE,
            currencyCode: CURRENCY,
          ),
          googlePayPaymentMethodParams: GooglePayPaymentMethodParams(amount: amount.toInt()),
        ),
      );
      print("google pay: ${paymentMethod.paymentMethod.toJson()}");
      return paymentMethod.paymentMethod.id;
    }catch (ex) {
      print("createPaymentMethod: $ex");
     //Toast().error(massage: "createPaymentMethod: $ex");
    }
  }

  static Future<String?> openApplePay(String name, double amount) async {
    try {
      final paymentMethod = await Stripe.instance.createPlatformPayPaymentMethod(
        params: PlatformPayPaymentMethodParams.applePay(
          applePayParams: ApplePayParams(
            cartItems: [
              ApplePayCartSummaryItem.immediate(
                label: name,
                amount: amount.toString(),
              ),
            ],
/*          requiredShippingAddressFields: [
            ApplePayContactFieldsType.postalAddress,
          ],
          shippingMethods: [
            ApplePayShippingMethod(
              identifier: 'free',
              detail: 'Arrives by July 2',
              label: 'Free Shipping',
              amount: '0.0',
            ),
            ApplePayShippingMethod(
              identifier: 'standard',
              detail: 'Arrives by June 29',
              label: 'Standard Shipping',
              amount: '3.21',
            ),
          ],*/
            merchantCountryCode: 'Us',
            currencyCode: 'USD',
          ),
        ),
      );
      print("apple pay: ${paymentMethod.paymentMethod.toJson()}");
      return paymentMethod.paymentMethod.id;
    }catch (ex) {
      print("createPaymentMethod: $ex");

    }
  }
}
