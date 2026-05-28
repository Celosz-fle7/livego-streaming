import '../models/tv_subscription_plan.dart';

class TVPaymentController {
  static List<TVSubscriptionPlan>
      plans = [
    const TVSubscriptionPlan(
      name: 'Bulanan',
      price: 'Rp 49.000',
      features: [
        'Unlimited Drama',
        'Live Sports',
        'Live TV',
        '1080p Quality',
      ],
    ),
    const TVSubscriptionPlan(
      name: 'Tahunan',
      price: 'Rp 399.000',
      features: [
        'Unlimited Drama',
        'Live Sports',
        'Live TV',
        '1080p Quality',
        'Priority Access',
      ],
    ),
  ];
}
