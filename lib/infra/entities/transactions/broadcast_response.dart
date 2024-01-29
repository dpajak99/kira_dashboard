import 'package:equatable/equatable.dart';

class BroadcastResponse extends Equatable {
  final BroadcastTx checkTx;
  final BroadcastTx deliverTx;
  final String hash;
  final String height;

  const BroadcastResponse({
    required this.checkTx,
    required this.deliverTx,
    required this.hash,
    required this.height,
  });

  factory BroadcastResponse.fromJson(Map<String, dynamic> json) {
    return BroadcastResponse(
      checkTx: BroadcastTx.fromJson(json['check_tx'] as Map<String, dynamic>),
      deliverTx: BroadcastTx.fromJson(json['deliver_tx'] as Map<String, dynamic>),
      hash: json['hash'] as String,
      height: json['height'] as String,
    );
  }

  @override
  List<Object?> get props => <Object?>[checkTx, deliverTx, hash, height];
}

class BroadcastTx extends Equatable {
  final int code;
  final String codespace;
  final List<Event> events;
  final String info;
  final String log;
  final String? data;

  const BroadcastTx({
    required this.code,
    required this.codespace,
    required this.events,
    required this.info,
    required this.log,
    this.data,
  });

  factory BroadcastTx.fromJson(Map<String, dynamic> json) {
    return BroadcastTx(
      code: json['code'] as int,
      codespace: json['codespace'] as String,
      events: (json['events'] as List<dynamic>).map((dynamic e) => Event.fromJson(e as Map<String, dynamic>)).toList(),
      info: json['info'] as String,
      log: json['log'] as String,
      data: json['data'] as String?,
    );
  }

  @override
  List<Object?> get props => <Object?>[code, codespace, events, info, log, data];
}

class Event extends Equatable {
  final List<EventAttribute> attributes;
  final String type;

  const Event({
    required this.attributes,
    required this.type,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      attributes: (json['attributes'] as List<dynamic>).map((dynamic e) => EventAttribute.fromJson(e as Map<String, dynamic>)).toList(),
      type: json['type'] as String,
    );
  }

  @override
  List<Object?> get props => <Object?>[attributes, type];
}

class EventAttribute extends Equatable {
  final bool index;
  final String key;
  final String value;

  const EventAttribute({
    required this.index,
    required this.key,
    required this.value,
  });

  factory EventAttribute.fromJson(Map<String, dynamic> json) {
    return EventAttribute(
      index: json['index'] as bool,
      key: json['key'] as String,
      value: json['value'] as String,
    );
  }

  @override
  List<Object?> get props => <Object>[index, key, value];
}
