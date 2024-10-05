part of "../export.provider.dart";

class PackageStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class PackageInitial extends PackageStates {}

class PackageLoading extends PackageStates {}

class PackageError extends PackageStates {
  final String message;
  PackageError({required this.message});
}

class UserPackagesLoaded extends PackageStates {
  final List<Package> packages;
  UserPackagesLoaded({required this.packages});
}

class PackageCreated extends PackageStates {
  final Package package;
  PackageCreated({required this.package});
}

class PackageUpdated extends PackageStates {
  final Package package;
  PackageUpdated({required this.package});
}

class PackageDeleted extends PackageStates {}

class PackageDetailsLoaded extends PackageStates {
  final Package package;
  PackageDetailsLoaded({required this.package});
}
