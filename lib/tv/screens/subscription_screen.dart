import 'package:flutter/material.dart';

class TVSubscriptionScreen
    extends StatelessWidget {
  const TVSubscriptionScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF070B12),
      body: Center(
        child: Container(
          width: 520,
          padding:
              const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius:
                BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              const Icon(
                Icons.workspace_premium,
                color: Color(0xFFFFD54F),
                size: 72,
              ),
              const SizedBox(height: 24),
              const Text(
                'Dracin Premium',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Akses Full Drama, Sports, Live TV, dan kualitas terbaik tanpa batas.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                height: 56,
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 28,
                ),
                decoration: BoxDecoration(
                  color:
                      const Color(0xFF04D2FF),
                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
                ),
                child: const Row(
                  mainAxisSize:
                      MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.lock_open,
                      color: Colors.black,
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Mulai Berlangganan',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight:
                            FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
