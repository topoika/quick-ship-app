part of "../components.dart";

class JoinComminityWidget extends StatelessWidget {
  const JoinComminityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: context.horPad, horizontal: 15)
          .copyWith(top: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(colors: [
            Color(0xff1BC07A),
            Color(0xff217b55),
          ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.asset(
              AppStrings.makeMoneyImage,
              opacity: const AlwaysStoppedAnimation(.59),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: context.width * 0.15),
                  child: const TextVariation(
                    text:
                        "Join ${AppStrings.appName} community and, Make money for every trip you make",
                    color: Colors.white,
                    size: 17,
                    weight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 7,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const TextVariation(
                    text: "Learn More",
                    color: Colors.white,
                    size: 13,
                    weight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InviteFriendsWidget extends StatelessWidget {
  const InviteFriendsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: context.horPad, horizontal: 15)
          .copyWith(top: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(colors: [
            Color(0xff1BC07A),
            Color(0xff217b55),
          ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.asset(
              AppStrings.inviteFriendsImage,
              opacity: const AlwaysStoppedAnimation(.65),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: context.width * 0.15),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextVariation(
                        text: "Invite your friends",
                        color: Colors.white,
                        size: 18,
                        weight: FontWeight.w700,
                      ),
                      // message to invite friends
                      TextVariation(
                        text:
                            "Invite your friends to join ${AppStrings.appName} and make money for every trip they make together",
                        color: Colors.white,
                        size: 12,
                        weight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 7,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const TextVariation(
                    text: "Invite Now",
                    color: Colors.white,
                    size: 13,
                    weight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
