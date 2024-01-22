import 'package:bolid/src/domain/repositories/sensor_repository.dart';
import 'package:bolid/src/presentation/controllers/bloc/get_senser_bloc.dart';
import 'package:bolid/src/presentation/utils/change_status_code.dart';
import 'package:bolid/src/presentation/widget/list_text_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final List<SensorModel> listSensorModel;
  final List<TextEditingController> textEditingControllers;
  final List<bool> expandableState;
  final List<bool> isEditingStates;
  final int itemCount;
  final GetSenser bloc;

  const HomePage({
    super.key,
    required this.listSensorModel,
    required this.itemCount,
    required this.expandableState,
    required this.bloc,
    required this.textEditingControllers,
    required this.isEditingStates,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget expandedContainer(double width, int index) {
    SensorModel sensorModel = widget.listSensorModel[index];
    StatusCode statusCode = StatusCodeParser.toStatusCode(sensorModel.status);
    List<bool> isEditingStates0 = widget.isEditingStates;
    bool isExpanded = widget.expandableState[index];

    Duration duration = const Duration(milliseconds: 300);
    double smallContainerWidth = width * 0.4;
    double bigContainerWidth = width * 0.9;

    Widget renameName(bool isEditText) {
      if (isEditText) {
        return Expanded(
          flex: 8,
          child: TextFormField(
            cursorColor: Colors.black,
            controller: widget.textEditingControllers[index],
            onChanged: (value) {
              widget.bloc.updateName(value, index);
            },
            style: styleText(size: 30.0),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Введите имя',
            ),
          ),
        );
      } else {
        return Expanded(
          flex: 8,
          child: ValueListenableBuilder(
            valueListenable: widget.bloc.valueNotifier,
            builder: (context, value, child) {
              return Text(
                'Имя - ${sensorModel.name != '' ? sensorModel.name : "N/A"}',
                overflow: TextOverflow.ellipsis,
              );
            },
          ),
        );
      }
    }

    Widget buildEditIconButton(int index) {
      return Expanded(
        flex: 2,
        child: Visibility(
          visible: isExpanded,
          child: IconButton(
            disabledColor: Colors.red,
            icon: const Icon(
              Icons.drive_file_rename_outline_outlined,
              size: 36.0,
            ),
            onPressed: () {
              setState(() {
                isEditingStates0[index] = !isEditingStates0[index];
              });
            },
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          widget.expandableState[index] = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: duration,
        margin: const EdgeInsets.all(20.0),
        width: !isExpanded ? smallContainerWidth : bigContainerWidth,
        height: !isExpanded ? smallContainerWidth : bigContainerWidth,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            border: Border.all(
              width: 3.0,
              color: statusCode.colros,
            ),
            color: statusCode.colros.withOpacity(0.2),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 4.0,
              top: 4.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedDefaultTextStyle(
                  duration: duration,
                  style: !isExpanded ? styleText(size: 20.0) : styleText(size: 30.0),
                  child: Row(
                    children: [
                      renameName(isEditingStates0[index]),
                      const Spacer(),
                      buildEditIconButton(index),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 6.0,
                ),
                animatedDefaultTextStyle(
                  nameOfField: 'Статус',
                  text: sensorModel.status,
                  isExpanded: isExpanded,
                ),
                animatedDefaultTextStyle(
                  nameOfField: 'Температура',
                  text: sensorModel.temperature,
                  isExpanded: isExpanded,
                  isTemperature: true,
                ),
                animatedDefaultTextStyle(
                  nameOfField: 'Влажность',
                  text: sensorModel.humidity,
                  isExpanded: isExpanded,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedDefaultTextStyle(
                    duration: duration,
                    style: !isExpanded ? styleText(size: 20.0) : styleText(size: 30.0),
                    child: Text(
                      'ID: ${sensorModel.sensorId}',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('НВП Болид Mobile'),
        backgroundColor: Colors.grey,
      ),
      body: Align(
        child: SingleChildScrollView(
          child: Wrap(
            children: List.generate(widget.itemCount, (index) {
              return expandedContainer(
                width,
                index,
              );
            }),
          ),
        ),
      ),
    );
  }
}
