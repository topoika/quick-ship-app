// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "../../pages.dart";

class PackageDetails extends StatelessWidget {
  const PackageDetails({super.key});

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
              onTap: () {
                // TODO: Navigate to edit package screen
              },
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
    bool mine = activeUser.value.id == package.shipper?.id!;
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextVariation(
                      text: package.name!,
                      size: 17,
                      weight: FontWeight.w600,
                      color: context.primaryColor,
                    ),
                    TextVariation(
                      text: "Item# ${package.id}",
                      size: 12,
                      weight: FontWeight.w500,
                      opacity: .7,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                CustomContainer(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            TextVariation(
                              text:
                                  "${package.weight?.toStringAsFixed(1) ?? "0"} Kg",
                              size: 14,
                              weight: FontWeight.w600,
                            ),
                            const TextVariation(
                              text: "Weight",
                              size: 10,
                              weight: FontWeight.w500,
                              opacity: .7,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 35,
                        width: 2,
                        decoration: BoxDecoration(
                          color: context.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            TextVariation(
                              text:
                                  "${package.dimLength?.ceil() ?? "0"}' ${package.dimWidth?.ceil() ?? "0"}' ${package.dimHeight?.ceil() ?? "0"}'",
                              size: 14,
                              weight: FontWeight.w600,
                            ),
                            const TextVariation(
                              text: "Dimensions",
                              size: 10,
                              weight: FontWeight.w500,
                              opacity: .7,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 35,
                        width: 2,
                        decoration: BoxDecoration(
                          color: context.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            TextVariation(
                              text: formatCurrency(value: package.value),
                              size: 14,
                              weight: FontWeight.w600,
                            ),
                            const TextVariation(
                              text: "Value",
                              size: 10,
                              weight: FontWeight.w500,
                              opacity: .7,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    TextVariation(
                      text: "Note to Postman",
                      size: 14,
                      weight: FontWeight.w500,
                      color: context.primaryColor,
                    ),
                    CustomContainer(
                      child: Column(
                        children: <Widget>[
                          detailsItem(txt: package.postManNote!, value: ""),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextVariation(
                  text: "Description",
                  size: 14,
                  weight: FontWeight.w500,
                  color: context.primaryColor,
                ),
                TextVariation(
                  text: package.description!,
                  size: 11,
                  weight: FontWeight.w400,
                  opacity: .7,
                ),
                const SizedBox(height: 10),
                TextVariation(
                  text: "Take off Address",
                  size: 14,
                  weight: FontWeight.w500,
                  color: context.primaryColor,
                ),
                CustomContainer(
                  child: Column(
                    children: <Widget>[
                      detailsItem(
                        txt: "Address",
                        value: package.sourceAddress?.nameAddress,
                      ),
                      detailsItem(
                        txt: "City",
                        value: package.sourceAddress?.city,
                      ),
                      detailsItem(
                        txt: "Meeting Point",
                        value: package.sourceAddress?.meetingPoint,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                TextVariation(
                  text: "Delivery Address",
                  size: 14,
                  weight: FontWeight.w500,
                  color: context.primaryColor,
                ),
                CustomContainer(
                  child: Column(
                    children: <Widget>[
                      detailsItem(
                        txt: "Address",
                        value: package.destinationAddress?.nameAddress,
                      ),
                      detailsItem(
                        txt: "City",
                        value: package.destinationAddress?.city,
                      ),
                      detailsItem(
                        txt: "Meeting Point",
                        value: package.destinationAddress?.meetingPoint,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                CustomContainer(
                  child: Column(
                    children: <Widget>[
                      detailsItem(
                        txt: "Date",
                        value: package.dateOfShipment,
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: !mine,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        margin: const EdgeInsets.only(top: 10, bottom: 15),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(.06),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextVariation(
                                text: "Shipper",
                                size: 14,
                                weight: FontWeight.w600,
                                color: context.primaryColor),
                            TextVariation(
                              text: package.shipper?.name ?? "Shipper",
                              size: 16,
                              weight: FontWeight.w600,
                              color: context.primaryColor,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: InkWell(
                          onTap: () {
                            // TODO: Navigate to chat screen
                            // Navigator.pushNamed(context, AppStrings.chat);
                          },
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                AppStrings.chatActive,
                                height: 22,
                                color: Colors.black,
                              ),
                              const SizedBox(width: 10),
                              TextVariation(
                                text: "Contact Shipper",
                                size: 14,
                                weight: FontWeight.w500,
                                color: context.primaryColor,
                              ),
                              const Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: context.primaryColor,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: mine,
                  replacement: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: PrimaryButtonUnfilled(
                            text: "Decline",
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
                                    Navigator.pop(context);
                                  },
                                  noOnPressed: () {
                                    Navigator.pop(context);
                                  },
                                  type: "warning",
                                ),
                              );
                              // TODO: Navigate to requests screen
                            },
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: PrimaryButton(
                            text: "Accept",
                            onPressed: () {
                              // TODO: Navigate to find postman screen
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: PrimaryButtonUnfilled(
                              text: "Requests",
                              onPressed: () {
                                // TODO: Navigate to requests screen
                              },
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: PrimaryButton(
                              text: "Find Postman",
                              onPressed: () {
                                // TODO: Navigate to find postman screen
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
                                        "Are you sure you want to delete this pacakge?",
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
          )
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
            context.width * 0.7,
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
