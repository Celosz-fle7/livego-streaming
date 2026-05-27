import 'package:flutter/material.dart';

import '../../core/tv/tv_payment_controller.dart';

import '../widgets/tv_subscription_card.dart';

class TVPaymentScreen
    extends StatelessWidget {
  const TVPaymentScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final plans =
        TVPaymentController.plans;

    return Scaffold(
      backgroundColor:
          const Color(0xFF070B12),
      body: Padding(
        padding:
            const EdgeInsets.all(42),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih Paket Premium',
              style: TextStyle(
                color: Colors.white,
                fontSize: 38,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(height: 38),
            Expanded(
              child: Row(
                children: List.generate(
                  plans.length,
                  (i) {
                    final item =
                        plans[i];

                    return Padding(
                      padding:
                          const EdgeInsets.only(
                        right: 24,
                      ),
                      child:
                          TVSubscriptionCard(
                        name: item.name,
                        price: item.price,
                        features:
                            item.features,
                        focused: false,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
