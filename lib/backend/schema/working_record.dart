import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'working_record.g.dart';

abstract class WorkingRecord
    implements Built<WorkingRecord, WorkingRecordBuilder> {
  static Serializer<WorkingRecord> get serializer => _$workingRecordSerializer;

  @nullable
  String get description;

  @nullable
  String get cost;

  @nullable
  String get tax;

  @nullable
  String get earning;

  @nullable
  String get gig;

  @nullable
  String get duedate;

  @nullable
  String get image;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(WorkingRecordBuilder builder) => builder
    ..description = ''
    ..cost = ''
    ..tax = ''
    ..earning = ''
    ..gig = ''
    ..duedate = ''
    ..image = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('working');

  static Stream<WorkingRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  WorkingRecord._();
  factory WorkingRecord([void Function(WorkingRecordBuilder) updates]) =
      _$WorkingRecord;

  static WorkingRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(
          serializer, {...data, kDocumentReferenceField: reference});
}

Map<String, dynamic> createWorkingRecordData({
  String description,
  String cost,
  String tax,
  String earning,
  String gig,
  String duedate,
  String image,
}) =>
    serializers.toFirestore(
        WorkingRecord.serializer,
        WorkingRecord((w) => w
          ..description = description
          ..cost = cost
          ..tax = tax
          ..earning = earning
          ..gig = gig
          ..duedate = duedate
          ..image = image));
