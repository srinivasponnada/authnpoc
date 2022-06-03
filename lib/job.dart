class Job {
  int? _id;
  late String _title;
  late String _description;
  late String _date;
  late int _priority;

  // Constructor for Creating new Class object
  Job(this._id, this._title, this._description, this._date, this._priority);

  // All the getters
  int? get id => _id;
  String get title => _title;
  String get description => _description;
  String get date => _date;
  int get priority => _priority;

//All the setters
  set setTitle(String newTitle) {
    if (newTitle.length <= 255) {
      _title = newTitle;
    }
  }

  set setDescription(String newDescription) {
    if (newDescription.length <= 255) {
      _description = newDescription;
    }
  }

  set setDate(String newDate) {
    _date = newDate;
  }

  set setPriority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 2) {
      _priority = newPriority;
    }
  }

  Map<String, Object?> toMap() {
    var map = <String, Object?>{};

    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['date'] = _date;
    map['priority'] = _priority;
    return map;
  }
}

