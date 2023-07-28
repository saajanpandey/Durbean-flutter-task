class TodoModal {
  int? id;
  String? title;
  String? description;

  TodoModal({
    this.id,
    this.title,
    this.description,
  });

  // Map<String, Object?> toMap() {
  //   var map = <String, Object?>{
  //     'id': id,
  //     'description': description,
  //   };
  //   return map;
  // }

  // TodoModal();

  // TodoModal.fromMap(Map<String, Object?> map) {
  //   id = map['id'] as int?;
  //   description = map['description'] as String?;
  // }

  TodoModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
  }
}
