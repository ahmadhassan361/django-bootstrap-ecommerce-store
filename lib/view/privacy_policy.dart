import 'package:flutter/material.dart';
import 'package:quantum_genius/utils/colors.dart';
import 'package:quantum_genius/utils/fontsize.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
              color: Colors.black
          ),
          // The search area here
          title: Row(
            children: [
              SizedBox(
                  height: 70,
                  child: Center(child: Row(
                    children: [
                      GradientText(
                        'NEXGEN ',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30.0,
                            fontStyle: FontStyle.italic
                        ),
                        colors: const [
                          Color.fromRGBO(244, 84, 70, 1),
                          Color.fromRGBO(225, 42, 90, 1)
                        ],
                      ),
                      const SizedBox(width: 5,),
                      const Text("Shop", style: TextStyle(fontSize: 28,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic),)
                    ],
                  ),)),
              const Spacer(),

            ],
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Center(child: Text("Privacy Policy", style: TextStyle(
                      fontSize: BIG_HEADING_FONT_SIZE,
                      fontWeight: FontWeight.bold,
                      color: HEADING_COLOR),)),
                  SizedBox(height: 20,),
                  Text("Privacy Policy", style: TextStyle(fontSize: BIG_HEADING_FONT_SIZE,
                      color: HEADING_COLOR),),
                  SizedBox(height: 10,),
                  Text(
                    "At NexGenShop Pvt. Ltd., your privacy and the security of your data is our first priority. We will ensure that your privacy is protected when using our services. The following privacy policy applies to the entirety of NexGenShop's customer-facing interaction channels including this website and all pages associated with the www.nexgen-shop.com domain. This policy explains what we consider to be private data, who has access to it, and how that data is used in a secure manner. We will retain your personal data only for as long as is necessary for the purposes set out in this Privacy Policy. We will retain and use your personal data to the extent necessary to comply with our legal obligations (for example, if we are required to retain your data to comply with applicable laws), resolve disputes, and enforce our legal agreements and policies. We will also retain usage data for internal analysis purposes. Usage Data is generally retained for a shorter period of time, except when this data is used to strengthen the security or to improve the quality of our service, or we are legally obligated to retain this data for longer time periods. After the necessity to keep the data is over, the data is deleted from the system immediately and cannot be recovered by any users or our employees after this point. Data that has been deleted or otherwise destroyed cannot be recovered at any time. A sufficient warning is given to the account administrator before data are permanently deleted. Data may l remain in the systems' backup files, which will be deleted periodically. You can also request to have your data deleted by reaching out to us at nexgenshopofficial@gmail.com. We undertake to perform the deletion within one month (30 calendar days). Wherever possible, we will aim to complete the request in advance of the deadline.",
                    style: TextStyle(color: HEADING_COLOR),),
                  SizedBox(height: 20,),
                  Text("Personal Data", style: TextStyle(fontSize: BIG_HEADING_FONT_SIZE,
                      color: HEADING_COLOR),),
                  SizedBox(height: 10,),
                  Text(
                    "We take responsibility for all your personal data (such as your name, address, email address, phone number, and date of birth) that you provide us with, obtained when you subscribe to our newsletter or when you create a personal profile with us to place your order."
                    ,style: TextStyle(color: HEADING_COLOR),),
                  SizedBox(height: 20,),
                  Text("How is your personal data used?", style: TextStyle(fontSize: BIG_HEADING_FONT_SIZE,
                      color: HEADING_COLOR),),
                  SizedBox(height: 10,),
                  Text(
                    "We only use your personal data to enrich your shopping experience with us to ensure a level of service that NexGenShop prides itself on. This includes sending you product and service updates tailored to your needs. In order to provide you with relevant offers and information, we may analyze your personal data. We will only keep your data for as long as necessary to offer our services to you or for as long as we are required by law."
                    ,style: TextStyle(color: HEADING_COLOR),),
                  SizedBox(height: 20,),
                  Text("What information do we share with third parties?", style: TextStyle(fontSize: BIG_HEADING_FONT_SIZE,
                      color: HEADING_COLOR),),
                  SizedBox(height: 10,),
                  Text(
                    "NexGenShop may share your personal information with third parties or affiliates of NexGenShop who perform services on our behalf or process authorized transactions. The personal information we share with these companies to perform services on our behalf is protected via contractual agreements and cannot be shared. We do not sell your information to any third party nor do we disclose your personal information to unaffiliated third parties."
                    ,style: TextStyle(color: HEADING_COLOR),),
                  SizedBox(height: 20,),
                  Text("CHANGES TO OUR PRIVACY POLICY", style: TextStyle(fontSize: BIG_HEADING_FONT_SIZE,
                      color: HEADING_COLOR),),
                  SizedBox(height: 10,),
                  Text(
                    "Any changes we may make to our privacy policy in the future will be posted on this page and, where appropriate, notified to you by e-mail. Please check back frequently to see any updates or changes to our privacy policy."

                    ,style: TextStyle(color: HEADING_COLOR),),
                  SizedBox(height: 20,),
                  Text("FOR ASSISTANCE", style: TextStyle(fontSize: BIG_HEADING_FONT_SIZE,
                      color: HEADING_COLOR),),
                  SizedBox(height: 10,),
                  Text(
                    "CALL : +92 307 3939075 \nEMAIL : nexgenshopofficial@gmail.com"
                    ,style: TextStyle(color: HEADING_COLOR),),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
