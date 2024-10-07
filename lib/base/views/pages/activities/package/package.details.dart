part of "../../pages.dart";

class PackageDetails extends StatelessWidget {
  const PackageDetails({super.key});

  @override
  Widget build(BuildContext context) {
    int id = context.watch<DetailsItemCubit>().state.packageId ?? 0;

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
          text: "Package Details",
          size: 15,
          weight: FontWeight.w600,
        ),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: context.horPad),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: GestureDetector(
              onTap: () {},
              child: const QImage(
                imageUrl: AppStrings.editIcon,
                height: 20,
              ),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<PackageDetailsBloc>().add(GetPackageDetails(id: id));
        },
        child: BlocBuilder<PackageDetailsBloc, PackageStates>(
          builder: (context, state) {
            if (state is PackageLoading) {
              return const PackageLoadingWidget();
            } else if (state is PackageError) {
              return Center(
                child: ErrorNoDataWidget(
                  type: "error",
                  message: state.message,
                  onRetry: () {
                    context
                        .read<PackageDetailsBloc>()
                        .add(GetPackageDetails(id: id));
                  },
                ),
              );
            } else if (state is PackageDetailsLoaded) {
              return PackageDetailsWidget(package: state.package);
            } else {
              return Center(
                child: ErrorNoDataWidget(
                  type: "error",
                  message: "Unable to load package details",
                  onRetry: () {
                    context
                        .read<PackageDetailsBloc>()
                        .add(GetPackageDetails(id: id));
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

class PackageDetailsWidget extends StatelessWidget {
  final Package package;
  const PackageDetailsWidget({
    super.key,
    required this.package,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SliderWithIndicators(images: package.images),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.horPad, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PackageDetailsWidgetBody(package: package),
                const SizedBox(height: 10),
                Visibility(
                  visible: package.status == "active",
                  replacement: const SizedBox.shrink(),
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: PrimaryButtonUnfilled(
                              text: "Requests",
                              onPressed: () {
                                context.read<PackageRequestBloc>().add(
                                    FetchPackageRequestsEvent(id: package.id!));
                                Navigator.pushNamed(
                                    context, AppRoutes.packageRequest);
                              },
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: PrimaryButton(
                              text: "Find Postman",
                              onPressed: () {
                                context.read<RouteTripsBloc>().add(
                                    FetchRouteTripsEvent(
                                        departure: package.sourceAddress!,
                                        destination:
                                            package.destinationAddress!));
                                context
                                    .read<DetailsItemCubit>()
                                    .setAddreses(package);
                                Navigator.pushNamed(
                                    context, AppRoutes.routeTripsPage);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      BlocListener<PackageBloc, PackageStates>(
                        listener: (context, state) {
                          if (state is PackageDeleted) {
                            showCustomToast(
                                message: "Package deleted successfully",
                                type: "suc");
                            context
                                .read<PackageBloc>()
                                .add(FetchUserPackages());
                            Navigator.pop(context);
                          } else if (state is PackageError) {
                            showCustomToast(
                                message: state.message, type: "err");
                          }
                        },
                        child: BlocBuilder<PackageBloc, PackageStates>(
                          builder: (context, state) {
                            return GestureDetector(
                              onTap: () {
                                showCustomDialog(
                                  context: context,
                                  data: DialogData(
                                    title: "Confirm Delete",
                                    description:
                                        "Are you sure you want to delete this package?",
                                    noText: "Cancel",
                                    yesText: "Delete",
                                    yesOnPressed: () {
                                      context
                                          .read<PackageBloc>()
                                          .add(DeletePackage(id: package.id!));
                                      Navigator.pop(context);
                                    },
                                    noOnPressed: () {
                                      Navigator.pop(context);
                                    },
                                    type: "warning",
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Visibility(
                                    visible: state is PackageLoading,
                                    replacement: const Icon(Icons.delete,
                                        color: Colors.redAccent, size: 18),
                                    child: const SizedBox(
                                      height: 15,
                                      width: 15,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Colors.redAccent,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Text(
                                    "Delete Package",
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
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

class PackageLoadingWidget extends StatelessWidget {
  const PackageLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
                    shimmerContainer(
                      context,
                      30,
                      context.width * 0.3,
                      0,
                    ),
                    shimmerContainer(
                      context,
                      25,
                      context.width * 0.2,
                      0,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                shimmerContainer(
                  context,
                  90,
                  context.width,
                  5,
                ),
                const SizedBox(height: 10),
                shimmerContainer(
                  context,
                  30,
                  context.width * 0.5,
                  0,
                ),
                const SizedBox(height: 5),
                shimmerContainer(
                  context,
                  60,
                  context.width,
                  5,
                ),
                const SizedBox(height: 10),
                shimmerContainer(
                  context,
                  30,
                  context.width * 0.5,
                  0,
                ),
                const SizedBox(height: 5),
                shimmerContainer(
                  context,
                  140,
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
                  50,
                  context.width,
                  5,
                ),
                const SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    );
  }
}
