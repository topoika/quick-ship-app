part of "../../pages.dart";

class TripDetails extends StatelessWidget {
  const TripDetails({super.key});

  @override
  Widget build(BuildContext context) {
    int id = context.watch<DetailsItemCubit>().state.id ?? 0;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 72,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin:
                EdgeInsets.symmetric(horizontal: context.horPad, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey[300]!,
              ),
            ),
            height: 10,
            width: 10,
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
          ),
        ),
        title: const TextVariation(
          text: "Trip Details",
          size: 15,
          weight: FontWeight.w600,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<TripDetailsBloc>().add(FetchTripDetailsEvent(id: id));
        },
        child: BlocBuilder<TripDetailsBloc, TripStates>(
          builder: (context, state) {
            if (state is TripDetailsLoaded) {
              return TripDetailsBody(trip: state.trip);
            } else if (state is TripError) {
              return Center(
                  child: ErrorNoDataWidget(
                type: "error",
                message: state.message,
                onRetry: () {
                  context
                      .read<TripDetailsBloc>()
                      .add(FetchTripDetailsEvent(id: id));
                },
              ));
            } else if (state is TripsLoading) {
              return const TripLoading();
            } else {
              return Center(
                child: ErrorNoDataWidget(
                  type: "no-data",
                  message: "No Data found",
                  onRetry: () {
                    context
                        .read<TripDetailsBloc>()
                        .add(FetchTripDetailsEvent(id: id));
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

class TripDetailsBody extends StatelessWidget {
  final Trip trip;
  const TripDetailsBody({
    super.key,
    required this.trip,
  });

  @override
  Widget build(BuildContext context) {
    bool mine = trip.postman!.id == activeUser.value.id;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.horPad, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    height: context.width * 0.3,
                    width: context.width * 0.3,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    child: const Icon(Icons.person, size: 30),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextVariation(
                        text: trip.postman!.name ?? "",
                        size: 18,
                        weight: FontWeight.w600,
                      ),
                      Visibility(
                        visible: trip.postman!.verified ?? false,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2, left: 3),
                          child: Icon(
                            Icons.verified,
                            color: Colors.blue[700],
                            size: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: context.primaryColor, size: 18),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: TextVariation(
                          text: "5.0",
                          size: 12,
                          weight: FontWeight.w600,
                        ),
                      ),
                      const TextVariation(
                        text: "(116 Reviews)",
                        size: 12,
                        color: Colors.grey,
                        weight: FontWeight.w500,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            CustomContainer(
              child: Column(
                children: <Widget>[
                  detailsItem(
                    txt: "Postage Fee",
                    value: formatCurrency(value: trip.postageFee),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextVariation(
                          text: "Vehicle Type",
                          size: 12,
                          weight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: context.primaryColor.withOpacity(.1),
                                ),
                                child: QImage(
                                  imageUrl: trip.travelMethod!.icon!,
                                  height: 10,
                                  color: context.primaryColor,
                                ),
                              ),
                              const SizedBox(width: 5),
                              TextVariation(
                                text: trip.travelMethod!.name ?? "",
                                size: 12.5,
                                weight: FontWeight.w600,
                                align: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            CustomContainer(
              child: Column(
                children: <Widget>[
                  detailsItem(
                    txt: "Departure Address",
                    value: trip.departure!.nameAddress ?? "",
                  ),
                  detailsItem(
                    txt: "Departure City",
                    value:
                        "${trip.departure!.city ?? ""} ${trip.departure!.country ?? ""}",
                  ),
                  detailsItem(
                    txt: "Meeting Point",
                    value: trip.departure!.meetingPoint,
                  ),
                ],
              ),
            ),
            CustomContainer(
              child: Column(
                children: <Widget>[
                  detailsItem(
                    txt: "Date",
                    value: trip.departure?.dateAndTime?.split(" ")[0],
                  ),
                  detailsItem(
                    txt: "Time",
                    value: trip.departure?.dateAndTime?.split(" ")[1],
                  ),
                ],
              ),
            ),
            CustomContainer(
              child: Column(
                children: <Widget>[
                  Visibility(
                    visible: !mine,
                    child: detailsItem(
                      txt: "Distance from Departure",
                      value: "2 KM",
                    ),
                  ),
                  detailsItem(
                    txt: "Guide to Meeting Point",
                    value: trip.guideToMeetingPoint,
                  ),
                ],
              ),
            ),
            CustomContainer(
              child: Column(
                children: <Widget>[
                  detailsItem(
                    txt: "Destination Address",
                    value: trip.destination!.nameAddress ?? "",
                  ),
                  detailsItem(
                    txt: "Destination City",
                    value:
                        "${trip.destination!.city ?? ""} ${trip.destination!.country ?? ""}",
                  ),
                  detailsItem(
                    txt: "Meeting Point",
                    value: trip.destination!.meetingPoint,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Visibility(
              visible: !mine,
              replacement: Row(
                children: <Widget>[
                  Expanded(
                    child: BlocListener<TripBloc, TripStates>(
                      listener: (context, state) {
                        if (state is TripError) {
                          showCustomToast(message: state.message, type: "err");
                        } else if (state is TripDeleted) {
                          showCustomToast(message: "Trip Deleted", type: "suc");
                          context.read<TripBloc>().add(FetchUserTripsEvent());
                          Navigator.pop(context);
                        }
                      },
                      child: BlocBuilder<TripBloc, TripStates>(
                        builder: (context, state) {
                          return PrimaryButtonUnfilled(
                            text: "Delete",
                            loading: state is TripLoading,
                            onPressed: () {
                              showCustomDialog(
                                context: context,
                                data: DialogData(
                                  title: "Confirm Delete",
                                  description:
                                      "Are you sure you want to delete this trip?",
                                  noText: "Cancel",
                                  yesText: "Delete",
                                  yesOnPressed: () {
                                    context
                                        .read<TripBloc>()
                                        .add(DeleteTripEvent(id: trip.id!));
                                    Navigator.pop(context);
                                  },
                                  noOnPressed: () {
                                    Navigator.pop(context);
                                  },
                                  type: "warning",
                                ),
                              );
                            },
                            color: Colors.red[400],
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: PrimaryButton(
                      text: "Edit Trip",
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: PrimaryButtonUnfilled(
                      text: "Message",
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: PrimaryButton(
                      text: "Send Request",
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final Widget child;
  const CustomContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[200],
      ),
      child: child,
    );
  }
}

class TripLoading extends StatelessWidget {
  const TripLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.horPad, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  shimmerContainer(
                    context,
                    context.width * 0.3,
                    context.width * 0.3,
                    100,
                  ),
                  const SizedBox(height: 5),
                  shimmerContainer(
                    context,
                    35,
                    context.width * 0.4,
                    0,
                  ),
                  const SizedBox(height: 5),
                  shimmerContainer(
                    context,
                    25,
                    context.width * 0.3,
                    0,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            shimmerContainer(
              context,
              100,
              context.width,
              5,
            ),
            const SizedBox(height: 10),
            shimmerContainer(
              context,
              140,
              context.width,
              5,
            ),
            const SizedBox(height: 10),
            shimmerContainer(
              context,
              100,
              context.width,
              5,
            ),
            const SizedBox(height: 10),
            shimmerContainer(
              context,
              50,
              context.width,
              5,
            ),
            const SizedBox(height: 10),
            shimmerContainer(
              context,
              100,
              context.width,
              5,
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: shimmerContainer(
                    context,
                    50,
                    context.width * 0.4,
                    5,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: shimmerContainer(
                    context,
                    50,
                    context.width * 0.4,
                    5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
