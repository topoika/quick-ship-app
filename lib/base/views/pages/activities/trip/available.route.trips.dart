part of "../../pages.dart";

class RouteTripsPage extends StatelessWidget {
  const RouteTripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Address from = context.watch<DetailsItemCubit>().state.from!;
    final Address to = context.watch<DetailsItemCubit>().state.to!;
    return Scaffold(
      appBar: commonAppBar(
          context: context,
          title: "Available Postmen",
          onBack: () => Navigator.pop(context)),
      body: RefreshIndicator(
        onRefresh: () async {
          context
              .read<RouteTripsBloc>()
              .add(FetchRouteTripsEvent(departure: from, destination: to));
        },
        child: BlocBuilder<RouteTripsBloc, TripStates>(
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
                        message: "No postmen available for your route",
                        onRetry: () {
                          context.read<RouteTripsBloc>().add(
                              FetchRouteTripsEvent(
                                  departure: from, destination: to));
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
                    context.read<RouteTripsBloc>().add(
                        FetchRouteTripsEvent(departure: from, destination: to));
                  },
                ),
              );
            } else {
              return Center(
                child: ErrorNoDataWidget(
                  type: "no-data",
                  message: "No trips yet",
                  onRetry: () {
                    context.read<RouteTripsBloc>().add(
                        FetchRouteTripsEvent(departure: from, destination: to));
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
