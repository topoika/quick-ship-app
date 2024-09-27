part of "export.provider.dart";

List<SingleChildWidget> blocProvider({required BuildContext context}) => [
      // BlocProvider<CllanBloc>(create: (context) => CllanBloc()),
      BlocProvider(create: (context) => PasswordCubit()),
    ];
