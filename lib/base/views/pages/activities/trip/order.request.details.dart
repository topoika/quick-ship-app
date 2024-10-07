// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "../../pages.dart";

class OrderRequestPage extends StatelessWidget {
  const OrderRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    int requestId = context.watch<DetailsItemCubit>().state.requestId!;

    return Scaffold(
      appBar: commonAppBar(
          context: context,
          title: "Order Request",
          onBack: () => Navigator.pop(context)),
      body: RefreshIndicator(
        onRefresh: () async {
          context
              .read<PackageRequestDetailsBloc>()
              .add(FetchPackageRequestDetailsEvent(id: requestId));
        },
        child: BlocBuilder<PackageRequestDetailsBloc, PackageRequestStates>(
          builder: (context, state) {
            if (state is PackageRequestLoadingState) {
              return const PackageLoadingWidget();
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
              return OrderRequestBody(request: state.packageRequest);
            } else {
              return Center(
                child: ErrorNoDataWidget(
                  type: "error",
                  message: "An error occurred",
                  onRetry: () {
                    context
                        .read<PackageRequestDetailsBloc>()
                        .add(FetchPackageRequestDetailsEvent(id: requestId));
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

class OrderRequestBody extends StatelessWidget {
  final PackageRequest request;
  const OrderRequestBody({
    super.key,
    required this.request,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SliderWithIndicators(images: request.package!.images),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.horPad, vertical: 5),
          child: Column(
            children: [
              PackageDetailsWidgetBody(package: request.package!),
              ContactShipper(package: request.package!),
              Visibility(
                visible: request.status == "pending",
                replacement: const SizedBox(height: 20),
                child: BlocListener<PackageRequestBloc, PackageRequestStates>(
                  listener: (context, state) {
                    if (state is PackageRequestErrorState) {
                      showCustomToast(message: state.message, type: "err");
                    } else if (state is PackageRequestAcceptedState) {
                      showCustomToast(
                          message:
                              "Request accepted, wait for the shipper to pay",
                          type: "suc");
                      context.read<PackageRequestDetailsBloc>().add(
                          FetchPackageRequestDetailsEvent(id: request.id!));
                    } else if (state is PackageRequestDeclinedState) {
                      showCustomToast(message: "Request declined", type: "suc");
                      context.read<PackageRequestDetailsBloc>().add(
                          FetchPackageRequestDetailsEvent(id: request.id!));
                    }
                  },
                  child: BlocBuilder<PackageRequestBloc, PackageRequestStates>(
                    builder: (context, state) {
                      return BlocBuilder<PackageRequestBloc,
                          PackageRequestStates>(
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: PrimaryButtonUnfilled(
                                    text: "Decline",
                                    loading: state is RequestDeclining,
                                    onPressed: () {
                                      showCustomDialog(
                                        context: context,
                                        data: DialogData(
                                          title: "Confirm Decline",
                                          description:
                                              "Are you sure you want to decline this pacakge request?",
                                          noText: "Cancel",
                                          yesText: "Decline",
                                          yesOnPressed: () {
                                            context
                                                .read<PackageRequestBloc>()
                                                .add(DeclinePackageRequestEvent(
                                                    id: request.id!));
                                            Navigator.pop(context);
                                          },
                                          noOnPressed: () {
                                            Navigator.pop(context);
                                          },
                                          type: "warning",
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: PrimaryButton(
                                    text: "Accept",
                                    loading: state is RequestAccepting,
                                    onPressed: () {
                                      context.read<PackageRequestBloc>().add(
                                          AcceptPackageRequestEvent(
                                              id: request.id!));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
