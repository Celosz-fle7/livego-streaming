import 'package:flutter/material.dart';

class TVUserProfileCard
    extends StatelessWidget {

  final String name;

  final String avatar;

  const TVUserProfileCard({
    super.key,
    required this.name,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 320,

      padding:
          const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.black87,

        borderRadius:
            BorderRadius.circular(24),
      ),

      child: Row(
        children: [

          CircleAvatar(
            radius: 34,

            backgroundImage:
                NetworkImage(
              avatar,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Text(
              name,

              maxLines: 1,

              overflow:
                  TextOverflow.ellipsis,

              style:
                  const TextStyle(
                color: Colors.white,
                fontWeight:
                    FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
