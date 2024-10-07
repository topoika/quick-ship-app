part of "../export.provider.dart";

class PackageRequestStates extends Equatable {
  const PackageRequestStates();
  @override
  List<Object> get props => [];
}

class PackageRequestInitState extends PackageRequestStates {}

class PackageRequestLoadingState extends PackageRequestStates {}

class PackageRequestErrorState extends PackageRequestStates {
  final String message;
  const PackageRequestErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

class PackageRequestLoadedState extends PackageRequestStates {
  final List<PackageRequest> packageRequests;
  const PackageRequestLoadedState({required this.packageRequests});
  @override
  List<Object> get props => [packageRequests];
}

class PackageRequestDetailsLoadedState extends PackageRequestStates {
  final PackageRequest packageRequest;
  const PackageRequestDetailsLoadedState({required this.packageRequest});
  @override
  List<Object> get props => [packageRequest];
}

class PackageRequestCreatedState extends PackageRequestStates {
  final PackageRequest packageRequest;
  const PackageRequestCreatedState({required this.packageRequest});
  @override
  List<Object> get props => [packageRequest];
}

class RequestDeclining extends PackageRequestStates {}

class RequestAccepting extends PackageRequestStates {}
class RequestDeleted extends PackageRequestStates {}
class PackageRequestAcceptedState extends PackageRequestStates {}

class PackageRequestDeclinedState extends PackageRequestStates {}
