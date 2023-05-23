import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class NoteModel extends Equatable {
  String? note;

  NoteModel({
    this.note,
  });

  NoteModel.fromJson(Map<dynamic, dynamic>? map) {
    if (map == null) {
      return;
    }
    note = map['note'];
  }
  toJson() {
    return {
      "note": note,
    };
  }

  NoteModel copyWith({
    String? note,
  }) {
    return NoteModel(
      note: note ?? this.note,
    );
  }

  @override
  List<Object?> get props => [
        note,
      ];
}
