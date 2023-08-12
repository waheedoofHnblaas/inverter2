class InverterCommandsModel {
  bool? success;
  List<CommandModel>? commandsList;

  InverterCommandsModel({this.success, this.commandsList});

  InverterCommandsModel.fromJson(Map<dynamic, dynamic> json) {
    success = json['Success'];
    if (json['command List'] != null) {
      commandsList = <CommandModel>[];
      json['command List'].forEach((v) {
        commandsList!.add(CommandModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Success'] = success;
    if (commandsList != null) {
      data['command List'] = commandsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommandModel {
  int? id;
  String? commandShortcut;
  String? commandShortcutInSettings;
  String? commandNumberInCatelog;
  String? commandDescription;
  String? boundriesPrefix;
  Boundries? boundries;
  String? increamental;

  CommandModel(
      {this.id,
        this.commandShortcut,
        this.commandShortcutInSettings,
        this.commandNumberInCatelog,
        this.commandDescription,
        this.boundriesPrefix,
        this.boundries,
        this.increamental});

  CommandModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    commandShortcut = json['command_shortcut'];
    commandShortcutInSettings = json['command_shortcut_in_settings'];
    commandNumberInCatelog = json['command_number_in_catelog'];
    commandDescription = json['command_description'];
    boundriesPrefix = json['boundries_prefix'];
    boundries = json['boundries'] != null
        ? Boundries.fromJson(json['boundries'])
        : null;
    increamental = json['increamental'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['command_shortcut'] = commandShortcut;
    data['command_shortcut_in_settings'] = commandShortcutInSettings;
    data['command_number_in_catelog'] = commandNumberInCatelog;
    data['command_description'] = commandDescription;
    data['boundries_prefix'] = boundriesPrefix;
    if (boundries != null) {
      data['boundries'] = boundries!.toJson();
    }
    data['increamental'] = increamental;
    return data;
  }
}

class Boundries {
  var min;
  var max;
  Map<dynamic,dynamic>? choices;

  Boundries({this.min, this.max, this.choices});

  Boundries.fromJson(Map<String, dynamic> json) {
    min = json['min'];
    max = json['max'];
    choices =
    json['choices']??{};
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['min'] = min;
    data['max'] = max;
    if (choices != null) {
      data['choices'] = choices;
    }
    return data;
  }
}
