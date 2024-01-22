import 'package:flutter/material.dart';

final class StatusCodeParser {
  static StatusCode toStatusCode(int status) {
    switch (status) {
      case 0:
        return StatusCode(
          colros: Colors.grey,
          status: 'Неизвестно',
        );
      case 1:
        return StatusCode(
          colros: Colors.green,
          status: 'Готов',
        );
      case 2:
        return StatusCode(
          colros: Colors.red,
          status: 'Тревога',
        );
      case 3:
        return StatusCode(
          colros: Colors.red,
          status: 'Пожар',
        );
      case 4:
        return StatusCode(
          colros: Colors.orange,
          status: 'Корпус открыт',
        );
      case 5:
        return StatusCode(
          colros: Colors.green,
          status: 'Корпус закрыт',
        );
      case 6:
        return StatusCode(
          colros: Colors.grey,
          status: 'Потерян',
        );
      case 7:
        return StatusCode(
          colros: Colors.orange,
          status: 'Низкий заряд батареи',
        );
      case 8:
        return StatusCode(
          colros: Colors.orange,
          status: 'Событие по температуре',
        );
      case 9:
        return StatusCode(
          colros: Colors.orange,
          status: 'Событие по влажности',
        );
      default:
        throw Exception('Unregistered StatusCode');
    }
  }
}

final class StatusCode {
  final Color colros;
  final String status;

  StatusCode({
    required this.colros,
    required this.status,
  });
}
