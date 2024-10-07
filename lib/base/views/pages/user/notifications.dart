part of "../pages.dart";

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
          context: context,
          title: "Notifications",
          onBack: () => Navigator.pop(context)),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<NotificationBloc>().add(FetchNotifications());
        },
        child: BlocBuilder<NotificationBloc, AppDataStates>(
          builder: (context, state) {
            if (state is LoadingAppDataState) {
              return const ListLoadingWidget(itemCount: 10, height: 85);
            } else if (state is ErrorAppDataState) {
              return Center(
                child: ErrorNoDataWidget(
                  type: "error",
                  message: state.message,
                  onRetry: () {
                    context.read<NotificationBloc>().add(FetchNotifications());
                  },
                ),
              );
            } else if (state is NotificationsLoadedAppDataState) {
              if (state.notifications.isNotEmpty) {
                return ListView.builder(
                  itemCount: state.notifications.length,
                  padding: EdgeInsets.symmetric(horizontal: context.horPad),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return NotificationItem(
                        notification: state.notifications[index]);
                  },
                );
              } else {
                return Center(
                  child: ErrorNoDataWidget(
                    type: "no-data",
                    message: "No notifications",
                    onRetry: () {
                      context
                          .read<NotificationBloc>()
                          .add(FetchNotifications());
                    },
                  ),
                );
              }
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
