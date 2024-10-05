part of "../export.provider.dart";

class PackageBloc extends Bloc<PackageEvents, PackageStates> {
  PackageRepo repo = PackageRepo();
  PackageBloc() : super(PackageInitial()) {
    on<FetchUserPackages>(getUserPackages);
    on<CreatePackageEvent>(createPackage);
    on<UpdatePackage>(updatePackage);
    on<DeletePackage>(deletePackage);
  }
  void createPackage(event, emit) async {
    emit(PackageLoading());
    try {
      final package = await repo.createPackage(
          package: event.package, images: event.images);
      if (package != null) {
        emit(PackageCreated(package: package));
      } else {
        emit(PackageError(message: "Error creating package"));
      }
    } catch (e) {
      emit(PackageError(message: e.toString()));
    }
  }

  void getUserPackages(event, emit) async {
    emit(PackageLoading());
    try {
      final packages = await repo.getUserPackages();
      emit(UserPackagesLoaded(packages: packages));
    } catch (e) {
      emit(PackageError(message: e.toString()));
    }
  }

  void updatePackage(event, emit) async {
    emit(PackageLoading());
    try {
      final package = await repo.updatePackage(
          package: event.package, images: event.images);
      if (package != null) {
        emit(PackageUpdated(package: package));
      } else {
        emit(PackageError(message: "Error updating package"));
      }
    } catch (e) {
      emit(PackageError(message: e.toString()));
    }
  }

  void deletePackage(event, emit) async {
    emit(PackageLoading());
    try {
      await repo.deletePackage(id: event.id);
      emit(PackageDeleted());
    } catch (e) {
      emit(PackageError(message: e.toString()));
    }
  }
}

// details bloc
class PackageDetailsBloc extends Bloc<PackageEvents, PackageStates> {
  PackageRepo repo = PackageRepo();
  PackageDetailsBloc() : super(PackageInitial()) {
    on<GetPackageDetails>(getPackageDetails);
  }
  void getPackageDetails(event, emit) async {
    emit(PackageLoading());
    try {
      final package = await repo.getPackageDetails(id: event.id);
      emit(PackageDetailsLoaded(package: package!));
    } catch (e) {
      emit(PackageError(message: e.toString()));
    }
  }
}
