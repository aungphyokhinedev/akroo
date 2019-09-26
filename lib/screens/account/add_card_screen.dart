import 'package:essential/serializers/account_category.dart';
import 'package:essential/store/application_model.dart';
import 'package:essential/utils/color_utils.dart';
import 'package:essential/utils/size_config.dart';
import 'package:essential/widgets/icon_picker.dart';
import 'package:essential/widgets/todo_badge.dart';
import 'package:flutter/material.dart';

import 'package:flutter_colorpicker/block_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AddCardScreen extends StatefulWidget {
  final ApplicationModel applicationModel;
  final bool isEditing;
  AddCardScreen(this.applicationModel, this.isEditing);

  @override
  State<StatefulWidget> createState() {
    return _AddCardScreenState();
  }
}

class _AddCardScreenState extends State<AddCardScreen> {
  String newTask;
  bool isProcessing = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Color taskColor;
  IconData taskIcon;
  TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = new TextEditingController();
    setState(() {
      if (widget.isEditing) {
        var _currentCat = widget.applicationModel.accountModel.category.accountCategory;
        newTask = _currentCat.name;
        textController.text = _currentCat.name;
        taskColor = ColorUtils.getColorFrom(id: _currentCat.color);
        taskIcon = IconData(
          _currentCat.logo,
          fontFamily: 'MaterialIcons',
        );
        isProcessing = false;
      } else {
        newTask = '';
        taskColor = ColorUtils.defaultColors[0];
        taskIcon = Icons.work;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: new IconButton(
          padding: EdgeInsets.only(left: 0),
          icon: new Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Observer(builder: (_) {
          return Text(
            widget.applicationModel.commonModel.lng['new_category'],
            style: TextStyle(
                color: Colors.black,
                fontSize: SizeConfig.blockSizeVertical * 2.5),
          );
        }),
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black26),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeVertical * 2,
            vertical: SizeConfig.blockSizeVertical * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Observer(builder: (_) {
              return Text(
                widget.applicationModel.commonModel.lng['add_category_desc'],
                style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.blockSizeVertical * 2.3),
              );
            }),
            Container(
              height: 16.0,
            ),
            Observer(builder: (_) {
              return TextField(
                controller: textController,
                onChanged: (text) {
                  setState(() => newTask = text);
                },
                cursorColor: taskColor,
                autofocus: true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget
                        .applicationModel.commonModel.lng['category_name'],
                    hintStyle: TextStyle(
                      color: Colors.black26,
                    )),
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: SizeConfig.blockSizeVertical * 4),
              );
            }),
            Container(
              height: 26.0,
            ),
            Row(
              children: [
                ColorPickerBuilder(
                    color: taskColor,
                    onColorChanged: (newColor) =>
                        setState(() => taskColor = newColor)),
                Container(
                  width: 22.0,
                ),
                IconPickerBuilder(
                    iconData: taskIcon,
                    highlightColor: taskColor,
                    action: (newIcon) => setState(() => taskIcon = newIcon)),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Builder(
        builder: (BuildContext context) {
          return FloatingActionButton.extended(
            heroTag: 'fab_new_card',
            icon: Icon(Icons.save),
            backgroundColor: isProcessing?Colors.grey: taskColor,
            label: Observer(builder: (_) {
              return Text(widget.applicationModel.commonModel
                  .lng[widget.isEditing ? 'submit' : 'add_category']);
            }),
            onPressed: () async {

              try {
              if (isProcessing) {
                return;
              }
               setState(() {
                  isProcessing = true;
                });

              if (newTask.isEmpty) {
                final snackBar = SnackBar(
                  content: Text(
                      'Ummm... It seems that you are trying to add an invisible task which is not allowed in this realm.'),
                  backgroundColor: taskColor,
                );
                Scaffold.of(context).showSnackBar(snackBar);
                // _scaffoldKey.currentState.showSnackBar(snackBar);
              } else {
                if (widget.isEditing) {
                  await widget.applicationModel.accountCategoryModel
                      .updateCategory(AccountCategory(
                    id: widget.applicationModel.accountModel.category.accountCategory.id,
                    color: taskColor.value,
                    logo: taskIcon.codePoint,
                    name: newTask,
                  ));
                  await widget.applicationModel.accountCategoryModel
                      .getCategoryList();
                 
                  Navigator.pop(context);
                  Navigator.pop(context);
                } else {
                  await widget.applicationModel.accountCategoryModel
                      .addCategory(AccountCategory(
                    color: taskColor.value,
                    logo: taskIcon.codePoint,
                    name: newTask,
                  ));
                  await widget.applicationModel.accountCategoryModel
                      .getCategoryList();
                }

                var cats = widget.applicationModel.accountCategoryModel.categories;
                if(cats.length > 0){
                   await widget.applicationModel.accountCategoryModel.loadSummaryInfo(
                   cats[0].accountCategory.id,
                    widget.applicationModel.accountModel.dateFilter);
                }
                
                setState(() {
                  isProcessing = false;
                });

                //  widget.commonModel.setBackColor(widget.toDoModel.categoriesData[0].color);
                // model.addTask(Task(
                //    newTask,
                //   codePoint: taskIcon.codePoint,
                //   color: taskColor.value
                // ));
                Navigator.pop(context);
                }
              }
                finally {
                  setState(() {
                  isProcessing = false;
                });
                }
              
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}

class ColorPickerBuilder extends StatelessWidget {
  final Color color;
  final ValueChanged<Color> onColorChanged;

  ColorPickerBuilder({@required this.color, @required this.onColorChanged});

  @override
  Widget build(BuildContext context) {
    //https://stackoverflow.com/questions/45424621/inkwell-not-showing-ripple-effect
    return ClipOval(
      child: Container(
        height: 32.0,
        width: 32.0,
        child: Material(
          color: color,
          child: InkWell(
            borderRadius: BorderRadius.circular(50.0),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Select a color'),
                    content: SingleChildScrollView(
                      child: BlockPicker(
                        availableColors: ColorUtils.defaultColors,
                        pickerColor: color,
                        onColorChanged: onColorChanged,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class IconPickerBuilder extends StatelessWidget {
  final IconData iconData;
  final ValueChanged<IconData> action;
  final Color highlightColor;

  IconPickerBuilder({
    @required this.iconData,
    @required this.action,
    Color highlightColor,
  }) : this.highlightColor = highlightColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50.0),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Select an icon'),
              content: SingleChildScrollView(
                child: IconPicker(
                  currentIconData: iconData,
                  onIconChanged: action,
                  highlightColor: highlightColor,
                ),
              ),
            );
          },
        );
      },
      child: TodoBadge(
        id: 'id',
        codePoint: iconData.codePoint,
        color: Colors.blueGrey,
        size: 24,
      ),
    );
  }
}

// Reason for wraping fab with builder (to get scafold context)
// https://stackoverflow.com/a/52123080/4934757
