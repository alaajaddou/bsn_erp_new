class BsnMenuItem {
  String type = '';
  String name = '';
  String label = '';
  String link = '';
  bool disabled = false;
  String icon = '';
  List<BsnMenuItem> children = [];

  BsnMenuItem();

  toJson() {
    print('type');
    print(this.type);
    print('name');
    print(this.name);
    print('label');
    print(this.label);
    print('link');
    print(this.link);
    print('disabled');
    print(this.disabled);
    print('icon');
    print(this.icon);

  }

  fromJson(dynamic element) {
    if (element.containsKey('type')) {
      type = element['type'];
    }
    if (element.containsKey('name')) {
      name = element['name'];
    }
    if (element.containsKey('label')) {
      label = element['label'];
    }
    if (element.containsKey('link')) {
      link = element['link'];
    }
    if (element.containsKey('disabled')) {
      disabled = element['disabled'];
    }
    if (element.containsKey('icon')) {
      icon = element['icon'];
    }
    if (element.containsKey('children')) {
      children = _getChildren(element['children']);
    }
    return this;
  }

  List<BsnMenuItem> _getChildren(List<dynamic> children) {
    List<BsnMenuItem> items = [];
    if (children.isNotEmpty) {
      for (var element in children) {
        items.add(BsnMenuItem().fromJson(element));
      }
    }

    return items;
  }
}
