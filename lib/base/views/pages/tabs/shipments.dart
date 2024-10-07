part of "../pages.dart";

class ShipmentsPage extends StatelessWidget {
  const ShipmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextVariation(
          text: "Shipments",
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
          context.read<ShipmentsBloc>().add(FetchShipments());
        },
        child: BlocBuilder<ShipmentsBloc, OrderStates>(
          builder: (context, state) {
            if (state is OrderLoading) {
              return const ListLoadingWidget(itemCount: 10, height: 150);
            } else if (state is OrdersLoaded) {
              if (state.orders.isEmpty) {
                return Center(
                  child: ErrorNoDataWidget(
                    type: "no-data",
                    message: "No shipments yet",
                    onRetry: () {
                      context.read<ShipmentsBloc>().add(FetchShipments());
                    },
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: state.orders.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: context.horPad),
                  itemBuilder: (context, index) {
                    return ShipmentItemWidget(order: state.orders[index]);
                  },
                );
              }
            } else if (state is OrderError) {
              return Center(
                child: ErrorNoDataWidget(
                  type: "error",
                  message: state.message,
                  onRetry: () {
                    context.read<ShipmentsBloc>().add(FetchShipments());
                  },
                ),
              );
            } else {
              return Center(
                child: ErrorNoDataWidget(
                  type: "no-data",
                  message: "No shipments yet",
                  onRetry: () {
                    context.read<ShipmentsBloc>().add(FetchShipments());
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
