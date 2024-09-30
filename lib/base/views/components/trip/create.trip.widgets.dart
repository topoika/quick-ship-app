part of "../components.dart";

class YouAreAWidget extends StatelessWidget {
  const YouAreAWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Trip trip = Trip();
    return Visibility(
      visible: ![1, 4].contains(3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20),
          const TextVariation(
            text: "Select a Travel Method",
            size: 16,
            weight: FontWeight.w600,
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              radioItem("Driver", "Driver", "Driver", (val) {}),
              radioItem(
                  "Shipping Company", "driver", "Shipping Company", (val) {}),
            ],
          ),
          Row(
            children: <Widget>[
              radioItem("Passenger", "driver", "Passenger", (val) {}),
              radioItem("Conductor", "driver", "Conductor", (val) {}),
            ],
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
    return Wrap(
      spacing: context.width * 0.02,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      children: travelMethods.map((e) {
        bool selected = e.id == 2;
        return GestureDetector(
          onTap: () {},
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
                  height: 30,
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
