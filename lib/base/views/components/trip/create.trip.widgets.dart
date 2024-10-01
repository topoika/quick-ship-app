part of "../components.dart";

class YouAreAWidget extends StatelessWidget {
  const YouAreAWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Trip trip = context.watch<NewItemCubit>().trip;

    return Visibility(
      visible: ![1, 4].contains(trip.travelMethod?.id),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20),
          const TextVariation(
            text: "Select a Travel Method",
            size: 15,
            weight: FontWeight.w600,
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              radioItem("Driver", trip.travelRole, "Driver", (val) {
                trip.travelRole = val;
                setTrip(trip: trip, context: context);
              }),
              radioItem("Shipping Company", trip.travelRole, "Shipping Company",
                  (val) {
                trip.travelRole = val;
                setTrip(trip: trip, context: context);
              }),
            ],
          ),
          Row(
            children: <Widget>[
              radioItem("Passenger", trip.travelRole, "Passenger", (val) {
                trip.travelRole = val;
                setTrip(trip: trip, context: context);
              }),
              radioItem("Conductor", trip.travelRole, "Conductor", (val) {
                trip.travelRole = val;
                setTrip(trip: trip, context: context);
              }),
            ],
          ),
          const SizedBox(height: 15),
          const TextVariation(
            text: "Vehicle Details",
            size: 15,
            weight: FontWeight.w600,
          ),
          const SizedBox(height: 10),
          NewItemInputField(
            hint: "Vehicle Identity",
            type: "vehicle",
            onSaved: (value) {
              trip.vehicleIdentity = value;
              setTrip(trip: trip, context: context);
            },
          ),
          NewItemInputField(
            hint: "License Plate",
            type: "license",
            onSaved: (value) {
              trip.licenseNumber = value;
              setTrip(trip: trip, context: context);
            },
          ),
        ],
      ),
    );
  }
}

Widget radioItem(val, gVal, txt, onChange, {flex = 1}) {
  return Flexible(
    flex: flex,
    child: InkWell(
      splashColor: Colors.transparent,
      onTap: () => onChange(val),
      child: Row(
        children: [
          Transform.scale(
            scale: 1.12,
            child: Radio(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              activeColor: Colors.black,
              value: val,
              groupValue: gVal,
              onChanged: (value) => onChange(value),
            ),
          ),
          TextVariation(
            text: txt,
            size: 13,
            weight: FontWeight.w500,
          ),
        ],
      ),
    ),
  );
}

class TravelMethodWidget extends StatelessWidget {
  const TravelMethodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Trip trip = context.watch<NewItemCubit>().trip;
    return Wrap(
      spacing: context.width * 0.02,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      children: travelMethods.map((e) {
        bool selected = e.id == trip.travelMethod?.id;
        return GestureDetector(
          onTap: () {
            trip.travelMethod = e;
            setTrip(trip: trip, context: context);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? context.primaryColor : Colors.transparent,
                  border: Border.all(
                    width: 1,
                    color: selected ? context.primaryColor : Colors.black,
                  ),
                ),
                child: QImage(
                  imageUrl: e.icon ?? "",
                  height: 28,
                  color: selected ? Colors.white : Colors.black,
                ),
              ),
              TextVariation(
                text: e.name.toString(),
                size: 12,
                align: TextAlign.center,
                weight: selected ? FontWeight.w600 : FontWeight.w500,
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}

void setTrip({required Trip trip, required BuildContext context}) {
  context.read<NewItemCubit>().setTrip(trip);
}
