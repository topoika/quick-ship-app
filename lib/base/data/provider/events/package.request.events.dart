part of "../export.provider.dart";

class PackageRequestEvents extends Equatable {
  const PackageRequestEvents();
  @override
  List<Object> get props => [];
}

class CreatePackageRequestEvent extends PackageRequestEvents {
  final int packageId;
  final int tripId;

  const CreatePackageRequestEvent(
      {required this.packageId, required this.tripId});

  @override
  List<Object> get props => [packageId, tripId];
}

class DeclinePackageRequestEvent extends PackageRequestEvents {
  final int id;

  const DeclinePackageRequestEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class AcceptPackageRequestEvent extends PackageRequestEvents {
  final int id;

  const AcceptPackageRequestEvent({required this.id});

  @override
  List<Object> get props => [id];
}
class DeletePackageRequest extends PackageRequestEvents {
  final int id;

  const DeletePackageRequest({required this.id});

  @override
  List<Object> get props => [id];
}

class FetchPackageRequestsEvent extends PackageRequestEvents {
  final int id;

  const FetchPackageRequestsEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class FetchPackageRequestDetailsEvent extends PackageRequestEvents {
  final int id;

  const FetchPackageRequestDetailsEvent({required this.id});

  @override
  List<Object> get props => [id];
}
