// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FaceData {
  final String uid;
  final String bytes;
  FaceData({
    required this.uid,
    required this.bytes,
  });

  FaceData copyWith({
    String? uid,
    String? bytes,
  }) {
    return FaceData(
      uid: uid ?? this.uid,
      bytes: bytes ?? this.bytes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'bytes': bytes,
    };
  }

  factory FaceData.fromMap(Map<String, dynamic> map) {
    return FaceData(
      uid: map['uid'] as String,
      bytes: map['bytes'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FaceData.fromJson(String source) =>
      FaceData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FaceData(uid: $uid, bytes: $bytes)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FaceData && other.uid == uid && other.bytes == bytes;
  }

  @override
  int get hashCode => uid.hashCode ^ bytes.hashCode;
}
