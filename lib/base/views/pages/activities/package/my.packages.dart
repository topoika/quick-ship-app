part of "../../pages.dart";

class MyPackages extends StatelessWidget {
  const MyPackages({super.key});

  @override
  Widget build(BuildContext context) {
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
          text: "My Packages",
          size: 15,
          weight: FontWeight.w600,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<PackageBloc>().add(FetchUserPackages());
        },
        child: BlocBuilder<PackageBloc, PackageStates>(
          builder: (context, state) {
            if (state is PackageLoading) {
              return const ListLoadingWidget(itemCount: 10, height: 130);
            } else if (state is PackageError) {
              return Center(
                child: ErrorNoDataWidget(
                  type: "error",
                  message: state.message,
                  onRetry: () {
                    context.read<PackageBloc>().add(FetchUserPackages());
                  },
                ),
              );
            } else if (state is UserPackagesLoaded) {
              if (state.packages.isEmpty) {
                return Center(
                  child: ErrorNoDataWidget(
                    type: "no-data",
                    message: "No Packages Yet",
                    onRetry: () {
                      context.read<PackageBloc>().add(FetchUserPackages());
                    },
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: state.packages.length,
                  padding: EdgeInsets.symmetric(horizontal: context.horPad),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return PackageListItem(package: state.packages[index]);
                  },
                );
              }
            } else {
              return Center(
                child: ErrorNoDataWidget(
                  type: "no-data",
                  message: "No Packages Yes",
                  onRetry: () {
                    context.read<PackageBloc>().add(FetchUserPackages());
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
