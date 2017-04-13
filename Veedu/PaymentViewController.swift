//
//  PaymentViewController.swift
//  Veedu
//
//  Created by Kevin Tran on 4/10/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController, PayPalPaymentDelegate {
    
    //MARK: properties
    
    @IBOutlet weak var itemsCountLabel: UILabel!
    @IBOutlet weak var subtotalAmountLabel: UILabel!
    @IBOutlet weak var shippingAmountLabel: UILabel!
    @IBOutlet weak var estimatedTaxesLabel: UILabel!
    @IBOutlet weak var orderTotalLabel: UILabel!
    @IBOutlet weak var backButtonLabel: UIButton!
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var homeTabBar: UITabBarItem!
    @IBOutlet weak var browseTabBar: UITabBarItem!
    @IBOutlet weak var favoritesTabBar: UITabBarItem!
    @IBOutlet weak var cartTabBar: UITabBarItem!
    @IBOutlet weak var profileTabBar: UITabBarItem!
    
    var environment:String = PayPalEnvironmentNoNetwork {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
    
    var payPalConfig = PayPalConfiguration()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up payPalConfig
        payPalConfig.acceptCreditCards = false
        payPalConfig.merchantName = "Veedu Inc." //name of company
        //paypal merchant privacy urls
        payPalConfig.merchantPrivacyPolicyURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        
        //default language for paypal
        payPalConfig.languageOrLocale = Locale.preferredLanguages[0]
        
        //use paypal account shipping address or allow user to choose, or both!
        payPalConfig.payPalShippingAddressOption = .both
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PayPalMobile.preconnect(withEnvironment: environment)
    }
    
    @IBAction func paymentButton(_ sender: UIButton) {
        //sample app code
        //sample items
        let item1 = PayPalItem(name: "Old jeans with holes", withQuantity: 2, withPrice: NSDecimalNumber(string: "1.99"), withCurrency: "USD", withSku: "Hip-0037")
        let item2 = PayPalItem(name: "Free rainbow patch", withQuantity: 1, withPrice: NSDecimalNumber(string: "0.00"), withCurrency: "USD", withSku: "Hip-00066")
        let item3 = PayPalItem(name: "Long-sleeve plaid shirt (mustache not included)", withQuantity: 1, withPrice: NSDecimalNumber(string: "1.99"), withCurrency: "USD", withSku: "Hip-00291")
        
        let items = [item1, item2, item3]
        
        //price total
        let subtotal = PayPalItem.totalPrice(forItems: items)
        
        // Optional: include payment details
        let shipping = NSDecimalNumber(string: "1.99")
        let tax = NSDecimalNumber(string: "1.50")
        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
        
        //total price with shipping and taxes
        let total = subtotal.adding(shipping).adding(tax)
        
        //name of seller
        let payment = PayPalPayment(amount: total, currencyCode: "USD", shortDescription: "Veedu Inc.", intent: .sale)
        
        payment.items = items
        payment.paymentDetails = paymentDetails
        
        if (payment.processable) {
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
            present(paymentViewController!, animated: true, completion: nil)
        }
        else {
            // This particular payment will always be processable. If, for
            // example, the amount was negative or the shortDescription was
            // empty, this payment wouldn't be processable, and you'd want
            // to handle that here.
            print("Payment not processalbe: \(payment)")
        }
    }
    
    //sample app code
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        print("PayPal Payment Cancelled")
        //resultText = ""
        //successView.isHidden = true
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        print("PayPal Payment Success !")
        paymentViewController.dismiss(animated: true, completion: { () -> Void in
            // send completed confirmaion to your server
            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
        })
    }
    
    //MARK: actions
    @IBAction func backButtonPress(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
