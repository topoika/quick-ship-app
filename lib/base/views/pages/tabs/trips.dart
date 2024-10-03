part of "../pages.dart";

class TripsPage extends StatelessWidget {
  const TripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextVariation(
          text: "My Trips",
          size: 15,
          weight: FontWeight.w600,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.horPad),
            child: const NotificationButton(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<TripBloc>().add(FetchUserTripsEvent());
        },
        child: BlocBuilder<TripBloc, TripStates>(
          builder: (context, state) {
            if (state is TripsLoaded) {
              return state.trips.isNotEmpty
                  ? ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: context.horPad),
                      itemCount: state.trips.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return TripItem(trip: state.trips[index]);
                      },
                    )
                  : Center(
                      child: ErrorNoDataWidget(
                        type: "no-data",
                        message: "No trips yet",
                        onRetry: () {
                          context.read<TripBloc>().add(FetchUserTripsEvent());
                        },
                      ),
                    );
            } else if (state is TripsLoading) {
              return const ListLoadingWidget(itemCount: 10);
            } else if (state is TripError) {
              return Center(
                child: ErrorNoDataWidget(
                  type: "error",
                  message: state.message,
                  onRetry: () {
                    context.read<TripBloc>().add(FetchUserTripsEvent());
                  },
                ),
              );
            } else {
              return Center(
                child: ErrorNoDataWidget(
                  type: "no-data",
                  message: "No trips yet",
                  onRetry: () {
                    context.read<TripBloc>().add(FetchUserTripsEvent());
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
