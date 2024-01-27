import 'package:bolid/core/services.dart';
import 'package:bolid/core/utils/validate.dart';
import 'package:bolid/src/domain/repositories/sensor_repository.dart';
import 'package:bolid/src/presentation/controllers/bloc/get_senser_bloc.dart';
import 'package:bolid/src/presentation/utils/change_status_code.dart';
import 'package:bolid/src/presentation/widget/list_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  final List<SensorInfo> listSensorInfo;

  const HomePage({
    super.key,
    required this.listSensorInfo,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget expandedContainer(double width, int index) {
    SensorModel sensorModel = widget.listSensorInfo[index].model;
    StatusCode statusCode = StatusCodeParser.toStatusCode(sensorModel.status);
    bool isEditingStates0 = widget.listSensorInfo[index].isEditingStates;
    bool isExpanded = widget.listSensorInfo[index].expandableState;
    TextEditingController textEditingController = widget.listSensorInfo[index].textEditingController;

    Duration duration = const Duration(milliseconds: 300);
    double smallContainerWidth = width * 0.4;
    double bigContainerWidth = width * 0.9;

    Widget renameName(bool isEditText, double width) {
      if (isEditText) {
        return Expanded(
            flex: 8,
            child: TextFormField(
              maxLength: null,
              cursorColor: Colors.black,
              controller: textEditingController,
              onChanged: (value) {
                final bool valid = validate(
                  textEditingController.text,
                  r'^[a-zA-Zа-яА-ЯёЁ0-9-_\.\s]{1,20}$',
                );

                if (valid) {
                  services<GetSenserBloc>().add(
                    ChangeNameSensorEvent(
                      index: index,
                      newName: value,
                    ),
                  );
                }
              },
              style: styleText(size: 30.0),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Введите имя',
              ),
            ));
      } else {
        return BlocBuilder<GetSenserBloc, GetSenserState>(
          builder: (context, state) {
            return Expanded(
              flex: 8,
              child: Text(
                'Имя - ${sensorModel.name != '' ? sensorModel.name : "N/A"}',
                overflow: TextOverflow.ellipsis,
              ),
            );
          },
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
                widget.listSensorInfo[index].isEditingStates = !isEditingStates0;
              });
            },
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          widget.listSensorInfo[index].expandableState = !isExpanded;
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
                      renameName(isEditingStates0, width),
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
              children: List.generate(widget.listSensorInfo.length, (index) {
                return expandedContainer(
                  width,
                  index,
                );
              }),
            ),
          ),
        ));
  }
}
