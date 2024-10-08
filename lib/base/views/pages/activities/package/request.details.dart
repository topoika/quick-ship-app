part of "../../pages.dart";

class RequestDetails extends StatelessWidget {
  const RequestDetails({super.key});

  @override
  Widget build(BuildContext context) {
    int requestId = context.watch<DetailsItemCubit>().state.requestId!;
    return Scaffold(
      appBar: commonAppBar(
        context: context,
        title: "Request Details",
        onBack: () => Navigator.pop(context),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context
              .read<PackageRequestDetailsBloc>()
              .add(FetchPackageRequestDetailsEvent(id: requestId));
        },
        child: BlocBuilder<PackageRequestDetailsBloc, PackageRequestStates>(
          builder: (context, state) {
            if (state is PackageRequestLoadingState) {
              return const RequestDetailsLoading();
            } else if (state is PackageRequestErrorState) {
              return Center(
                child: ErrorNoDataWidget(
                  type: "error",
                  message: state.message,
                  onRetry: () {
                    context
                        .read<PackageRequestDetailsBloc>()
                        .add(FetchPackageRequestDetailsEvent(id: requestId));
                  },
                ),
              );
            } else if (state is PackageRequestDetailsLoadedState) {
              PackageRequest request = state.packageRequest;
              return ListView(
                children: <Widget>[
                  SliderWithIndicators(images: request.package?.images),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.horPad, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextVariation(
                              text: "Request #$requestId",
                              size: 17,
                              weight: FontWeight.w600,
                            ),
                            TextVariation(
                              text: formatCurrency(
                                  value: request.postageFee ?? 0),
                              size: 17,
                              weight: FontWeight.w500,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        statusTag(status: request.status ?? "pending"),
                        const SizedBox(height: 8),
                        TextVariation(
                          text:
                              "Date: ${tripDateFormat(date: request.trip?.departure!.dateAndTime ?? "")}",
                          size: 13,
                          weight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: context.primaryColor.withOpacity(.12),
                              ),
                              child: const Icon(
                                Icons.location_on_rounded,
                                color: Colors.redAccent,
                                size: 13,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: TextVariation(
                                text: getAddressName(request.trip!.departure!),
                                size: 13,
                                weight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 2),
                          alignment: Alignment.centerLeft,
                          height: 30,
                          child: VerticalDivider(
                            color: Colors.black.withOpacity(.9),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: context.primaryColor.withOpacity(.12),
                              ),
                              child: const Icon(
                                Icons.location_on_rounded,
                                color: Colors.redAccent,
                                size: 13,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: TextVariation(
                                text:
                                    getAddressName(request.trip!.destination!),
                                size: 13,
                                weight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Divider(
                          color: Colors.grey[300],
                          thickness: .8,
                          height: 40,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[400],
                                image: DecorationImage(
                                  image: NetworkImage(
                                    request.trip?.postman?.image ?? "",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              margin: const EdgeInsets.only(right: 10),
                              child: request.trip?.postman?.image == null
                                  ? const Icon(
                                      Icons.person,
                                      color: Colors.black,
                                      size: 15,
                                    )
                                  : const SizedBox(),
                            ),
                            TextVariation(
                              text: request.trip?.postman?.name ?? "",
                              size: 13,
                              weight: FontWeight.w600,
                            ),
                          ],
                        ),
                        request.status != "paid"
                            ? Visibility(
                                visible: request.status != "rejected",
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 30),
                                    child: Visibility(
                                      visible: request.status == "pending",
                                      replacement: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          const TextVariation(
                                            text: "Congratulations 🎉",
                                            size: 17,
                                            align: TextAlign.center,
                                            weight: FontWeight.w600,
                                            color: Colors.green,
                                          ),
                                          TextVariation(
                                            text:
                                                "Request accepted by ${request.trip?.postman?.name ?? "postman"}, Pay now to make an order",
                                            size: 12,
                                            align: TextAlign.center,
                                            weight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                      child: const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          TextVariation(
                                            text: "Awaiting response",
                                            size: 17,
                                            align: TextAlign.center,
                                            weight: FontWeight.w600,
                                          ),
                                          TextVariation(
                                            text:
                                                "Request was send to postman, waiting for response",
                                            size: 12,
                                            align: TextAlign.center,
                                            weight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(height: 5),
                        request.status == "rejected" || request.status == "paid"
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: PrimaryButtonUnfilled(
                                  text: "Message ",
                                  onPressed: () async {
                                    await messageUser(
                                        context: context,
                                        user: request.trip!.postman!);
                                  },
                                ),
                              )
                            : Visibility(
                                visible: request.status == "pending",
                                replacement: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: PrimaryButtonUnfilled(
                                        text: "Message ",
                                        onPressed: () {},
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child:
                                          BlocListener<OrderBloc, OrderStates>(
                                        listener: (context, state) {
                                          if (state is OrderCreated) {
                                            showCustomToast(
                                                message: "Order Created",
                                                type: "suc");
                                            context
                                                .read<ShipmentsBloc>()
                                                .add(FetchShipments());
                                            context
                                                .read<NavigatorCubit>()
                                                .setIndex(2);
                                            Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                AppRoutes.tabs,
                                                (route) => false);
                                          } else if (state is OrderError) {
                                            showCustomToast(
                                                message: state.message,
                                                type: "err");
                                          }
                                        },
                                        child:
                                            BlocBuilder<OrderBloc, OrderStates>(
                                          builder: (context, state) {
                                            return PrimaryButton(
                                              text: "Pay Now",
                                              loading: state is OrderLoading,
                                              onPressed: () {
                                                showMpesaNumberDialog(
                                                    context: context,
                                                    onsubmit: (val) {
                                                      Navigator.pop(context);
                                                      context
                                                          .read<OrderBloc>()
                                                          .add(CreateOrder(
                                                              requestId:
                                                                  requestId,
                                                              phone: val));
                                                    });
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: BlocListener<PackageRequestBloc,
                                          PackageRequestStates>(
                                        listener: (context, state) {
                                          if (state is RequestDeleted) {
                                            showCustomToast(
                                                message: "Request Deleted",
                                                type: "suc");
                                            context
                                                .read<PackageRequestBloc>()
                                                .add(FetchPackageRequestsEvent(
                                                    id: request.package!.id!));
                                            Navigator.pop(context);
                                          } else if (state
                                              is PackageRequestErrorState) {
                                            showCustomToast(
                                                message: state.message,
                                                type: "err");
                                          }
                                        },
                                        child: BlocBuilder<PackageRequestBloc,
                                            PackageRequestStates>(
                                          builder: (context, state) {
                                            return PrimaryButtonUnfilled(
                                              text: "Cancel ",
                                              loading: state
                                                  is PackageRequestLoadingState,
                                              color: Colors.red,
                                              onPressed: () {
                                                showCustomDialog(
                                                  context: context,
                                                  data: DialogData(
                                                    title: "Confirm Delete",
                                                    description:
                                                        "Are you sure you want to delete this request?",
                                                    noText: "Cancel",
                                                    yesText: "Delete",
                                                    yesOnPressed: () {
                                                      context
                                                          .read<
                                                              PackageRequestBloc>()
                                                          .add(
                                                              DeletePackageRequest(
                                                                  id: request
                                                                      .id!));
                                                      Navigator.pop(context);
                                                    },
                                                    noOnPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    type: "warning",
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: PrimaryButton(
                                        text: "Message",
                                        onPressed: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const RequestDetailsLoading();
            }
          },
        ),
      ),
    );
  }
}

class RequestDetailsLoading extends StatelessWidget {
  const RequestDetailsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      shimmerContainer(
        context,
        context.width * 0.85,
        context.width,
        0,
      ),
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.horPad,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                shimmerContainer(context, 25, context.width * 0.5, 0),
                shimmerContainer(context, 25, context.width * 0.2, 0),
              ],
            ),
            const SizedBox(height: 8),
            shimmerContainer(context, 25, context.width * 0.2, 40),
            const SizedBox(height: 8),
            shimmerContainer(context, 35, context.width * 0.8, 0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: shimmerContainer(context, 80, 2, 0),
            ),
            shimmerContainer(context, 35, context.width * 0.9, 0),
            Divider(color: Colors.grey[300], thickness: 1, height: 30),
            Row(
              children: <Widget>[
                shimmerContainer(context, 30, 30, 100),
                const SizedBox(width: 10),
                shimmerContainer(context, 25, context.width * 0.3, 0),
              ],
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                shimmerContainer(context, 30, context.width * 0.5, 0),
                const SizedBox(height: 8),
                shimmerContainer(context, 25, context.width * 0.8, 0),
                const SizedBox(height: 10),
                shimmerContainer(context, 50, context.width * 0.9, 5),
              ],
            )
          ],
        ),
      )
    ]);
  }
}
