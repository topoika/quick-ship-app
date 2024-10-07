part of "../pages.dart";

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

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
          text: "My Orders",
          size: 15,
          weight: FontWeight.w600,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<MyOrderBloc>().add(FetchOrders());
        },
        child: BlocBuilder<MyOrderBloc, OrderStates>(
          builder: (context, state) {
            if (state is OrderLoading) {
              return const ListLoadingWidget(itemCount: 10, height: 130);
            } else if (state is OrdersLoaded) {
              if (state.orders.isEmpty) {
                return Center(
                  child: ErrorNoDataWidget(
                    type: "no-data",
                    message: "No orders yet",
                    onRetry: () {
                      context.read<MyOrderBloc>().add(FetchOrders());
                    },
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: state.orders.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: context.horPad),
                  itemBuilder: (context, index) {
                    return OrderItemWidget(order: state.orders[index]);
                  },
                );
              }
            } else if (state is OrderError) {
              return Center(
                child: ErrorNoDataWidget(
                  type: "error",
                  message: state.message,
                  onRetry: () {
                    context.read<MyOrderBloc>().add(FetchOrders());
                  },
                ),
              );
            } else {
              return Center(
                child: ErrorNoDataWidget(
                  type: "no-data",
                  message: "No orders yet",
                  onRetry: () {
                    context.read<MyOrderBloc>().add(FetchOrders());
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
