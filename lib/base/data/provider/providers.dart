part of "export.provider.dart";

List<SingleChildWidget> blocProvider({required BuildContext context}) => [
      // blocs
      BlocProvider(create: (context) => AuthBloc()..add(GetAuthUser())),

      // cubits
      BlocProvider(create: (context) => PasswordCubit()),
      BlocProvider(create: (context) => NavigatorCubit()),
      BlocProvider(create: (context) => NewItemCubit()),
    ];
