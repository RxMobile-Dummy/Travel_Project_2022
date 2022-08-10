import 'package:flutter/material.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/utils/extensions/sizedbox/sizedbox_extension.dart';

class PrivacyAndSecurity extends StatelessWidget {
  const PrivacyAndSecurity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy and Security",
            style: const TextStyle(
                color: MakeMyTripColors.colorBlack,
                fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 15.0, left: 30, right: 20, bottom: 20),
          child: Column(
            children: [
              const Text(
                'Privacy And Security',
                style: AppTextStyles.labelNameTextStyle,
              ),
              30.verticalSpace,
              const Text(
                """We "Travelsy", are committed to protecting the privacy and security of your personal information. Your privacy is important to us and maintaining your trust is paramount.

This privacy policy explains how we collect, use, process and disclose information about you. By using our app and affiliated services, you consent to the terms of our privacy policy (“Privacy Policy”) in addition to our ‘Terms of Use.’ We encourage you to read this privacy policy to understand the collection, use, and disclosure of your information from time to time, to keep yourself updated with the changes and updates that we make to this policy.

This privacy policy describes our privacy practices for all websites, products and services that are linked to it. However this policy does not apply to those affiliates and partners that have their own privacy policy. In such situations, we recommend that you read the privacy policy on the applicable site.""",
                textAlign: TextAlign.justify,
              ),
              20.verticalSpace,
              const Text(
                'the collection, storage and use of information related to you',
                style: AppTextStyles.unselectedLabelStyle,
              ),
              10.verticalSpace,
              const Text(
                """We may automatically store certain information including but not limited to information about your web browser, IP address, cookies stored on your device and other information about you based upon your behaviour on the website. We use this information to do internal research on our users’ demographics, interests and behaviour to better understand, protect and serve our users. This information is compiled and analyzed on an aggregated basis. This information may include the URL that you just came from (whether this URL is on the website or not), which URL you next go to (whether this URL is on the website or not), your computer browser information, your IP address, and other information associated with your interaction with the website.

We may also share your Mobile IP/Device IP with third party(ies) and to the best of our knowledge, be-life and representations given to us by these third party(ies) this information is not stored by them.

We also collect and store personal information provided by you from time to time on the app. We only collect and use such information from you that we consider necessary for achieving a seamless, efficient and safe experience, customized to your needs including:

To enable the provision of services opted by you;
To communicate necessary account and service related information from time to time;
To allow you to receive quality customer care services;
To undertake necessary fraud and money laundering prevention checks, and comply with the highest security standards;
To comply with applicable laws, rules and regulations; and
To provide you with information and offers on products and services, on updates, on promotions, on related, affiliated or associated service providers and partners, that we believe would be of interest to you
Where any service requested by you involves a third party, such information as is reasonably necessary by the Company to carry out your service request, may be shared with such third party.

We also do use your contact information to send you notifications based on the tasks allotted to you and also based on your interests and prior activity. The Company may also use contact information internally to direct its efforts for product improvement, to contact you as a survey respondent, to notify you if you win any contest; and to send you promotional materials from its contest sponsors or advertisers.

Contacts Permissions: If you allow us to access your contact list information including you and your contacts’ e-mail ids and any other details saved therein, it enables us to provide social features to you and your friends/contacts such as sharing your orders with your friends/contacts, inviting your contacts to try our app, send across referral links to your friends/contacts, etc. We may also use this information to make recommendations for groceries. This information will be synced from your phone and stored on our servers.

Further, you may from time to time choose to provide payment related financial information (credit card, debit card, bank account details, name, billing address, shipping address, phone number etc.) on the website. We are committed to keeping all such sensitive data/information safe at all times and ensure that such data/information is only transacted over secure websites of approved payment gateways which are digitally encrypted and provide the highest possible degree of care available under the technology presently in use.

The Company will not use your financial information for any purpose other than to complete a transaction with you. Additionally, your information may be used to communicate with you, screen orders for potential risk or fraud, use of preferences related information for advertising purposes and site optimization.

Device information: We may need your device permission to get information about your device, like OS (operating system) name, mobile network, hardware model, unique device identifier, etc. Based on these inputs, we intend to optimize your order experience and thereby serve you better.

Location:  This permission enables us to give you the benefit of providinng hotels near you and also to provide location specific deals with personalized in-funnel experience.  

Phone: The app requires access to make phone calls so that you can make phone calls to our customer contact centres directly through the app.

Email ID: If you allow us to access your email id then, it enables us to send various deals and offers directly to your email.

Photo/ Media/ Files: We take media storage permissions to cache the Blinkit images to provide seamless and fast experience while browsing Blinkit app.

Wi-Fi connection information: When you allow us the permission to detect your Wi-Fi connection, we optimize your experience such as more detailing on maps, better image loading etc.

Camera: You can grant camera permission as well to take pictures from your camera like that of the invoice, issues etc., in our customer chat feature through email.

To the extent possible, we provide you the option of not divulging any specific information that you wish for us not to collect, store or use. You may also choose not to use a particular service or feature on the website/application and opt out of any non-essential communications from the Company.

Further, transacting over the internet has inherent risks which can only be avoided by following security practices yourself, such as not revealing account/login related information to any other person and informing our customer care team about any suspicious activity or where your account has/may have been compromised.

""",
                textAlign: TextAlign.justify,
              ),
              const Text(
                """choices available regarding the collection, use and distribution of information""",
                style: AppTextStyles.unselectedLabelStyle,
              ),
              10.verticalSpace,
              const Text(
                """To protect against the loss, misuse and alteration of the information under its control, the Company has in place appropriate physical, electronic and managerial procedures. For example, the Company servers are accessible only to authorized personnel and your information is shared with employees and authorized personnel on a need to know basis to complete the transaction and to provide the services requested by you. Although the Company endeavours to safeguard the confidentiality of your personally identifiable information, transmissions made by means of the Internet cannot be made absolutely secure. By using the website, you agree that the Company will have no liability for disclosure of your information due to errors in transmission and/or unauthorized acts of third parties.

We may share certain information with governmental agencies or other third parties, where we are:

Obligated under the applicable laws or in good faith to respond to court orders and processes; or
Detecting and preventing against actual or potential occurrence of identity theft, fraud, abuse of Services and other illegal acts;
Responding to claims that an advertisement, posting or other content violates the intellectual property rights of a third party;
Under a duty to disclose or share your personal data in order to enforce our Terms of Use and other agreements, policies or to protect the rights, property, or safety of the Company, our customers, or others, or in the event of a claim or dispute relating to your use of our Services. This includes exchanging information with other companies and organisations for the purposes of fraud detection and credit risk reduction.
Please note that the Company will not ask you to share any sensitive data or information via email or telephone. If you receive any such request by email or telephone, please do not respond/divulge any sensitive data or information and forward the information relating to the same to rxtrainee22@gmail.com for necessary action.""",
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
