part of "../components.dart";

class HomeStatsWidget extends StatelessWidget {
  const HomeStatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserStatsBloc, UserStates>(
      builder: (context, state) {
        if (state is UserLoading) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: context.horPad),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                shimmerContainer(context, 30, context.width * 0.4, 0),
                const SizedBox(height: 10),
                shimmerContainer(context, 150, context.width, 5),
              ],
            ),
          );
        } else if (state is UserError) {
          return Center(
            child: ErrorNoDataWidget(
              type: "error",
              message: state.message,
              onRetry: () {
                context.read<UserStatsBloc>().add(FetchUserStats());
              },
            ),
          );
        } else if (state is UserStatsLoaded) {
          UserWallet wallet = state.stats;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: context.horPad),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextVariation(
                  text: "Statistics",
                  size: 16,
                  weight: FontWeight.w600,
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: context.primaryColor.withOpacity(.09),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          HomeStatItem(
                            txt: "Available for withdrawal",
                            stat: formatCurrency(
                                value: wallet.availableForWithdrawal),
                          ),
                          HomeStatItem(
                            txt: "Total earnings",
                            stat:
                                formatCurrency(value: wallet.earningsForMonth),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          HomeStatItem(
                            txt: "Active orders",
                            stat: wallet.activeOrders.toString(),
                          ),
                          HomeStatItem(
                            txt: "Complete orders",
                            stat: wallet.completedOrders.toString(),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: ErrorNoDataWidget(
              type: "error",
              message: "Unknown error occurred",
              onRetry: () {
                context.read<UserStatsBloc>().add(FetchUserStats());
              },
            ),
          );
        }
      },
    );
  }
}
