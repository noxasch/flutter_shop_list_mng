import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.freezed.dart';
part 'item.g.dart';

@freezed
class Item with _$Item {

  const factory Item({
    String? id,
    required String name,
    @Default(false) bool obtained,
  }) = _Item;

  // item.freezed already take care of toJson and copyWith
  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  factory Item.empty() => const Item(name: '');

  factory Item.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return Item.fromJson(data).copyWith(id: doc.id);
  }

  Map<String, dynamic> toDocument() => toJson()..remove(id);
}
