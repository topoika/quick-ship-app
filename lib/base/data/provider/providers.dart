part of "export.provider.dart";

List<SingleChildWidget> blocProvider({required BuildContext context}) => [
      // blocs
      BlocProvider(create: (context) => AuthBloc()..add(GetAuthUser())),
      BlocProvider(create: (context) => TripBloc()),
      BlocProvider(create: (context) => TripDetailsBloc()),

      // cubits
      BlocProvider(create: (context) => PasswordCubit()),
      BlocProvider(create: (context) => NavigatorCubit()),
      BlocProvider(create: (context) => NewItemCubit()),
      BlocProvider(create: (context) => DetailsItemCubit()),
    ];
