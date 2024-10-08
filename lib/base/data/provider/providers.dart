part of "export.provider.dart";

List<SingleChildWidget> blocProvider({required BuildContext context}) => [
      // blocs
      BlocProvider(create: (context) => AuthBloc()..add(GetAuthUser())),
      BlocProvider(create: (context) => UserBloc()),
      BlocProvider(create: (context) => UserStatsBloc()),
      BlocProvider(create: (context) => TripBloc()),
      BlocProvider(create: (context) => RouteTripsBloc()),
      BlocProvider(create: (context) => TripDetailsBloc()),
      BlocProvider(create: (context) => PackageBloc()),
      BlocProvider(create: (context) => PackageDetailsBloc()),
      BlocProvider(create: (context) => PackageRequestBloc()),
      BlocProvider(create: (context) => PackageRequestDetailsBloc()),
      BlocProvider(create: (context) => NotificationBloc()),
      BlocProvider(create: (context) => FaqBloc()..add(FetchFaqs())),
      BlocProvider(create: (context) => FeedBloc()..add(FetchFeeds())),
      BlocProvider(create: (context) => OrderBloc()),
      BlocProvider(create: (context) => MyOrderBloc()),
      BlocProvider(create: (context) => ShipmentsBloc()),

      // cubits
      BlocProvider(create: (context) => PasswordCubit()),
      BlocProvider(create: (context) => OtpCubit()),
      BlocProvider(create: (context) => ChatCubit()),
      BlocProvider(create: (context) => NavigatorCubit()),
      BlocProvider(create: (context) => NewItemCubit()),
      BlocProvider(create: (context) => DetailsItemCubit()),
    ];
