part of "../../pages.dart";

class PackageRequests extends StatelessWidget {
  const PackageRequests({super.key});

  @override
  Widget build(BuildContext context) {
    int packageId = context.watch<DetailsItemCubit>().state.packageId!;
    return Scaffold(
      appBar: commonAppBar(
          context: context,
          title: "Package Requests",
          onBack: () => Navigator.pop(context)),
      body: RefreshIndicator(
        onRefresh: () async {
          context
              .read<PackageRequestBloc>()
              .add(FetchPackageRequestsEvent(id: packageId));
        },
        child: BlocBuilder<PackageRequestBloc, PackageRequestStates>(
          builder: (context, state) {
            if (state is PackageRequestLoadingState) {
              return const ListLoadingWidget(itemCount: 10, height: 130);
            } else if (state is PackageRequestErrorState) {
              return Center(
                child: ErrorNoDataWidget(
                  type: "error",
                  message: state.message,
                  onRetry: () {
                    context
                        .read<PackageRequestBloc>()
                        .add(FetchPackageRequestsEvent(id: packageId));
                  },
                ),
              );
            } else if (state is PackageRequestLoadedState) {
              if (state.packageRequests.isNotEmpty) {
                return ListView.builder(
                  itemCount: state.packageRequests.length,
                  padding: EdgeInsets.symmetric(horizontal: context.horPad),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return PackageRequestListItem(
                        packageRequest: state.packageRequests[index]);
                  },
                );
              } else {
                return Center(
                  child: ErrorNoDataWidget(
                    type: "no-data",
                    message:
                        "No requests\nClick on Find Postmen to send requests",
                    onRetry: () {
                      context
                          .read<PackageRequestBloc>()
                          .add(FetchPackageRequestsEvent(id: packageId));
                    },
                  ),
                );
              }
            } else {
              return Center(
                child: ErrorNoDataWidget(
                  type: "no-data",
                  message:
                      "No requests\nClick on Find Postmen to send requests",
                  onRetry: () {
                    context
                        .read<PackageRequestBloc>()
                        .add(FetchPackageRequestsEvent(id: packageId));
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
