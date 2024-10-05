part of "../../pages.dart";

class CreateTrip extends StatelessWidget {
  const CreateTrip({super.key});

  @override
  Widget build(BuildContext context) {
    Trip trip = context.watch<NewItemCubit>().trip;
    bool isEdit = trip.id != null;
    return PopScope(
      canPop: true,
      onPopInvoked: (val) {
        homeSysSettings();
      },
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 72,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin:
                  EdgeInsets.symmetric(horizontal: context.horPad, vertical: 7),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey[300]!,
                ),
              ),
              height: 10,
              width: 10,
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              ),
            ),
          ),
          title: TextVariation(
            text: isEdit ? "Edit Trip" : "Create Trip",
            size: 15,
            weight: FontWeight.w600,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.horPad),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 15),
                  const TextVariation(
                    text: "Select a Travel Method",
                    size: 15,
                    weight: FontWeight.w600,
                  ),
                  const SizedBox(height: 10),
                  const TravelMethodWidget(),
                  const YouAreAWidget(),
                  const SizedBox(height: 10),
                  const TextVariation(
                    text: "Departure Details",
                    size: 15,
                    weight: FontWeight.w600,
                  ),
                  SelectInputField(
                    hint: "Departure Address",
                    value: trip.departure?.nameAddress,
                    hasValue: trip.departure?.nameAddress != null,
                    onTap: () async {
                      await pickLocation(
                              context: context, address: trip.departure)
                          .then((value) {
                        if (value != null) {
                          trip.departure = value;
                          setTrip(trip: trip, context: context);
                        }
                      });
                    },
                  ),
                  NewItemInputField(
                    hint: "Meeting Point",
                    type: "address",
                    init: trip.departure?.meetingPoint,
                    onSaved: (value) {
                      trip.departure?.meetingPoint = value;
                    },
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SelectInputField(
                          hint: "Date",
                          value: trip.departure?.date,
                          hasValue: trip.departure?.date != null,
                          onTap: () async {
                            await pickDate(context).then((value) {
                              if (value != null) {
                                trip.departure?.date =
                                    formatToDate(date: value);
                                setTrip(trip: trip, context: context);
                              }
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SelectInputField(
                          hint: "Time",
                          value: trip.departure?.time,
                          hasValue: trip.departure?.time != null,
                          onTap: () async {
                            await pickTime(context).then((value) {
                              if (value != null) {
                                trip.departure?.time =
                                    formatToTime(date: value);
                                setTrip(trip: trip, context: context);
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const TextVariation(
                    text: "Destination Details",
                    size: 15,
                    weight: FontWeight.w600,
                  ),
                  SelectInputField(
                    hint: "Destination Address",
                    value: trip.destination?.nameAddress,
                    hasValue: trip.destination?.nameAddress != null,
                    onTap: () async {
                      await pickLocation(
                              context: context, address: trip.destination)
                          .then((value) {
                        if (value != null) {
                          trip.destination = value;
                          setTrip(trip: trip, context: context);
                        }
                      });
                    },
                  ),
                  NewItemInputField(
                    hint: "Meeting Point",
                    type: "address",
                    init: trip.destination?.meetingPoint,
                    onSaved: (value) {
                      trip.destination?.meetingPoint = value;
                    },
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SelectInputField(
                          hint: "Date",
                          value: trip.destination?.date,
                          hasValue: trip.departure?.date != null,
                          onTap: () async {
                            await pickDate(context).then((value) {
                              if (value != null) {
                                trip.destination?.date =
                                    formatToDate(date: value);
                                setTrip(trip: trip, context: context);
                              }
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SelectInputField(
                          hint: "Time",
                          value: trip.destination?.time,
                          hasValue: trip.destination?.time != null,
                          onTap: () async {
                            await pickTime(context).then((value) {
                              if (value != null) {
                                trip.destination?.time =
                                    formatToTime(date: value);
                                setTrip(trip: trip, context: context);
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const TextVariation(
                    text: "Package Preferences",
                    size: 15,
                    weight: FontWeight.w600,
                  ),
                  DropDownInputWidget(
                    required: true,
                    init: capitalize(trip.packagePreference),
                    items: const [
                      "Small",
                      "Medium",
                      "Large",
                      "Extra Large",
                      "Envelopes"
                    ],
                    onSaved: (value) {
                      trip.packagePreference =
                          value.replaceAll(" ", "-").toLowerCase();
                    },
                  ),
                  const SizedBox(height: 10),
                  const TextVariation(
                    text: "Guide to meet Shipper",
                    size: 15,
                    weight: FontWeight.w600,
                  ),
                  NewItemInputField(
                    hint: "Guide to meet Shipper",
                    type: "description",
                    init: trip.guideToMeetingPoint,
                    onSaved: (value) {
                      trip.guideToMeetingPoint = value;
                    },
                  ),
                  const SizedBox(height: 10),
                  const TextVariation(
                    text: "Postage Fee",
                    size: 15,
                    weight: FontWeight.w600,
                  ),
                  NewItemInputField(
                    hint: "Postage Fee",
                    init: trip.postageFee?.toString(),
                    type: "money",
                    onSaved: (value) {
                      trip.postageFee = double.parse(value!);
                    },
                  ),
                  const SizedBox(height: 20),
                  BlocListener<TripBloc, TripStates>(
                    listener: (context, state) {
                      if (state is TripCreated) {
                        showCustomToast(
                            message: "Trip Created Successfully", type: "suc");
                        context.read<NavigatorCubit>().setIndex(1);
                        context.read<NewItemCubit>().clear();
                        context.read<TripBloc>().add(FetchUserTripsEvent());
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppRoutes.tabs, (route) => false);
                      }
                      if (state is TripUpdated) {
                        showCustomToast(
                            message: "Trip Updated Successfully", type: "suc");
                        context.read<NavigatorCubit>().setIndex(1);
                        context.read<NewItemCubit>().clear();
                        context.read<TripBloc>().add(FetchUserTripsEvent());
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppRoutes.tabs, (route) => false);
                      }
                      if (state is TripError) {
                        showCustomToast(message: state.message, type: "err");
                      }
                    },
                    child: BlocBuilder<TripBloc, TripStates>(
                      builder: (context, state) {
                        return PrimaryButton(
                          text: "Go Live",
                          loading: state is TripsLoading,
                          onPressed: () {
                            validationErrors.clear();
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              setTrip(trip: trip, context: context);
                              context.read<TripBloc>().add(isEdit
                                  ? UpdateTripEvent(trip: trip)
                                  : CreateTripEvent(trip: trip));
                            } else {
                              if (validationErrors.isNotEmpty) {
                                showCustomToast(
                                  message: validationErrors[0],
                                  type: "err",
                                );
                              }
                            }
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
