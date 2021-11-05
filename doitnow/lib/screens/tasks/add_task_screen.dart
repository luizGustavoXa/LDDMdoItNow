import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:doitnow/helpers/database_helper.dart';
import 'package:doitnow/models/task_model.dart';


class AddTaskScreen extends StatefulWidget {
  final Function? updateTaskList;
  final Task? task;


  AddTaskScreen({this.updateTaskList, this.task});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  Color blueColor = Color(0xFF2D55A1);
  String? _title = "";
  String? _priority = "Baixa";
  DateTime? _date = DateTime.now();
  final TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormatter = DateFormat(' dd/MM/yyyy');
  final List<String> _priorities = ["Baixa", "Media", "Alta"];

  _handleDatePicker() async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: _date!,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter.format(date);
    }
  }

  _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      //print('$_title, $_priority, $_date');

      // Insert Task to Users Database
      Task task = Task(title: _title, date: _date, priority: _priority);
      if (widget.task == null) {
        task.status = 0;
        DatabaseHelper.instance.insertTask(task);
      } else {
        // Update Task to Users Database
        task.id = widget.task!.id;
        task.status = widget.task!.status;
        DatabaseHelper.instance.updateTask(task);
      }

      widget.updateTaskList!();
      Navigator.pop(context);
    }
  }

  _delete() {
    DatabaseHelper.instance.deleteTask(widget.task!.id);
    widget.updateTaskList!();
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _dateController.text = _dateFormatter.format(_date!);

    if (widget.task != null) {
      _title = widget.task!.title;
      _priority = widget.task!.priority;
      _date = widget.task!.date;
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                    color: blueColor,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  widget.task == null ? 'Adicionar tarefa' : 'Atualizar tarefa',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          style: const TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                              labelText: 'Título',
                              labelStyle: const TextStyle(fontSize: 18),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          validator: (input) => input!.trim().isEmpty
                              ? 'Insira um título para a tarefa'
                              : null,
                          onSaved: (input) => _title = input,
                          initialValue: _title,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextFormField(
                          readOnly: true,
                          controller: _dateController,
                          style: const TextStyle(fontSize: 18),
                          onTap: _handleDatePicker,
                          decoration: InputDecoration(
                              labelText: 'Data',
                              labelStyle: const TextStyle(fontSize: 18),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: DropdownButtonFormField(
                          isDense: true,
                          icon: const Icon(Icons.arrow_drop_down_circle),
                          iconSize: 22.0,
                          iconEnabledColor: blueColor,
                          style: const TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                              labelText: 'Prioridade',
                              labelStyle: const TextStyle(fontSize: 18),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          validator: (dynamic input) => input.toString().trim().isEmpty
                              ? 'Insira um nível de prioridade'
                              : null,
                          // onSaved: (input) => _priority = input.toString(),
                          items: _priorities.map((String priority) {
                            return DropdownMenuItem(
                                value: priority,
                                child:  Text(
                                  priority,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18.0),
                                ));
                          }).toList(),
                          onChanged: (dynamic newValue) {
                            //print(newValue.runtimeType);
                            setState(() {
                              _priority = newValue.toString();
                            });
                          },
                          // value : _priority
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20.0),
                        height: 60.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: blueColor,
                            borderRadius: BorderRadius.circular(30.0)),
                        child: TextButton(
                          onPressed: _submit,
                          child: Text(
                            widget.task == null ? 'Adicionar' : 'Atualizar',
                            style:
                            const TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                      ),
                      widget.task != null
                          ? Container(
                        margin: const EdgeInsets.symmetric(vertical: 20.0),
                        height: 60.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: blueColor,
                            borderRadius: BorderRadius.circular(30.0)),
                        child: TextButton(
                          onPressed: _delete,
                          child:  const Text(
                            'Deletar',
                            style: TextStyle(
                                color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                      )
                          : const SizedBox.shrink(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}