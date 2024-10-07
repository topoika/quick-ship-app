part of "../export.provider.dart";

// PackageRequestBloc
class PackageRequestBloc
    extends Bloc<PackageRequestEvents, PackageRequestStates> {
  PackageRequestRepo repo = PackageRequestRepo();
  PackageRequestBloc() : super(PackageRequestInitState()) {
    on<CreatePackageRequestEvent>(createPackageRequest);
    on<FetchPackageRequestsEvent>(fetchPackageRequests);
    on<DeclinePackageRequestEvent>(declinePackageRequest);
    on<AcceptPackageRequestEvent>(acceptPackageRequest);
    on<DeletePackageRequest>(deleteRequest);
  }
  // create package request
  void createPackageRequest(event, emit) async {
    emit(PackageRequestLoadingState());
    try {
      final packageRequest = await repo.createPackageRequest(
          packageId: event.packageId, tripId: event.tripId);
      emit(PackageRequestCreatedState(packageRequest: packageRequest));
    } catch (e) {
      emit(PackageRequestErrorState(message: e.toString()));
    }
  }

  // delete request
  void deleteRequest(event, emit) async {
    emit(PackageRequestLoadingState());
    try {
      await repo.deletePackageRequest(id: event.id);
      emit(RequestDeleted());
    } catch (e) {
      emit(PackageRequestErrorState(message: e.toString()));
    }
  }

  // fetch package requests
  void fetchPackageRequests(event, emit) async {
    emit(PackageRequestLoadingState());
    try {
      final packageRequests = await repo.fetchPackageRequests(id: event.id);
      emit(PackageRequestLoadedState(packageRequests: packageRequests));
    } catch (e) {
      emit(PackageRequestErrorState(message: e.toString()));
    }
  }

  // accept package request
  void acceptPackageRequest(event, emit) async {
    emit(RequestAccepting());
    try {
      await repo.acceptPackageRequest(id: event.id);
      emit(PackageRequestAcceptedState());
    } catch (e) {
      emit(PackageRequestErrorState(message: e.toString()));
    }
  }

  // decline package request
  void declinePackageRequest(event, emit) async {
    emit(RequestDeclining());
    try {
      await repo.declinePackageRequest(id: event.id);
      emit(PackageRequestDeclinedState());
    } catch (e) {
      emit(PackageRequestErrorState(message: e.toString()));
    }
  }
}

class PackageRequestDetailsBloc
    extends Bloc<PackageRequestEvents, PackageRequestStates> {
  PackageRequestRepo repo = PackageRequestRepo();
  PackageRequestDetailsBloc() : super(PackageRequestInitState()) {
    on<FetchPackageRequestDetailsEvent>(fetchPackageRequestDetails);
  }

  void fetchPackageRequestDetails(event, emit) async {
    emit(PackageRequestLoadingState());
    try {
      final packageRequest =
          await repo.fetchPackageRequestDetails(id: event.id);
      emit(PackageRequestDetailsLoadedState(packageRequest: packageRequest));
    } catch (e) {
      emit(PackageRequestErrorState(message: e.toString()));
    }
  }
}
