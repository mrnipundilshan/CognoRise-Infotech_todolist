import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ToDoModalClass {
  String title;
  String description;
  String date;
  ToDoModalClass({
    required this.title,
    required this.description,
    required this.date,
  });
}

List colorList = [
  const Color(0xFFFAE8E8),
  const Color(0xffE8EDFA),
  const Color(0xffFAF9E8),
  const Color(0xffFAE8FA),
];

List<ToDoModalClass> list = [
  ToDoModalClass(
    title: '1st task ',
    description: 'I have a class',
    date: '17 may 2024',
  ),
  ToDoModalClass(
    title: '2nd task ',
    description: 'I have a trip',
    date: '30 may 2024',
  ),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();
  TextEditingController dateEditingController = TextEditingController();

  void editCard(ToDoModalClass toDoModalObj) {
    setState(() {
      modalbottomsheet(true, toDoModalObj);
      titleEditingController.text = toDoModalObj.title;
      descriptionEditingController.text = toDoModalObj.description;
      dateEditingController.text = toDoModalObj.date;
    });
  }

  void deleteCard(ToDoModalClass toDoModalobj) {
    setState(() {
      list.remove(toDoModalobj);
    });
  }

  void submit(bool isEdit, [ToDoModalClass? toDoModalobj]) {
    if (titleEditingController.text.trim().isNotEmpty &&
        descriptionEditingController.text.trim().isNotEmpty &&
        dateEditingController.text.trim().isNotEmpty) {
      if (!isEdit) {
        list.add(
          ToDoModalClass(
            title: titleEditingController.text.trim(),
            description: descriptionEditingController.text.trim(),
            date: dateEditingController.text.trim(),
          ),
        );
      } else {
        toDoModalobj!.title = titleEditingController.text.trim();
        toDoModalobj.description = descriptionEditingController.text.trim();
        toDoModalobj.date = dateEditingController.text.trim();
      }
    } else {
      final snackBar = SnackBar(
        content: Text(
          'None of the fields can be empty !',
          style:
              GoogleFonts.quicksand(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void modalbottomsheet(bool isEdit, [ToDoModalClass? toDoModalobj]) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Center(
                    child: Text(
                      'Create Task',
                      style: GoogleFonts.quicksand(
                          fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Text(
                  'Title',
                  style: GoogleFonts.quicksand(
                      fontSize: 11, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 40,
                  // width: 330,
                  child: TextField(
                    controller: titleEditingController,
                    style: GoogleFonts.quicksand(
                        fontSize: 12, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          width: 0.5,
                          color: Color(0xFF008B94),
                        ),
                      ),
                      hintText: 'Please Enter Title ',
                      hintStyle: GoogleFonts.quicksand(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Text(
                  'Description',
                  style: GoogleFonts.quicksand(
                      fontSize: 11, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  // width: 330,
                  child: TextField(
                    controller: descriptionEditingController,
                    style: GoogleFonts.quicksand(
                        fontSize: 12, fontWeight: FontWeight.w500),
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          width: 0.5,
                          color: Color(0xFF008B94),
                        ),
                      ),
                      hintText: 'Enter the Description',
                      hintStyle: GoogleFonts.quicksand(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Text(
                  'Date',
                  style: GoogleFonts.quicksand(
                      fontSize: 11, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 40,
                  // width: 330,
                  child: TextField(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2024),
                        lastDate: DateTime(2025),
                      );
                      String formatedDate =
                          DateFormat.yMMMd().format(pickedDate!);
                      setState(() {
                        dateEditingController.text = formatedDate;
                      });
                    },
                    readOnly: true,
                    controller: dateEditingController,
                    style: GoogleFonts.quicksand(
                        fontSize: 12, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.calendar_month_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          width: 0.5,
                          color: Color(0xFF008B94),
                        ),
                      ),
                      hintText: '10 Jan 2024 ',
                      hintStyle: GoogleFonts.quicksand(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (isEdit) {
                          submit(isEdit, toDoModalobj);
                        } else {
                          submit(isEdit);
                        }
                      });

                      Navigator.of(context).pop();
                      titleEditingController.clear();
                      descriptionEditingController.clear();
                      dateEditingController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(300, 50),
                        backgroundColor: const Color.fromARGB(255, 0, 139, 148),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(
                      'Submit',
                      style: GoogleFonts.quicksand(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Padding myCard(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: colorList[index % colorList.length],
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 10,
              spreadRadius: 1,
              offset: Offset(0, 10),
            )
          ],
        ),
        width: double.infinity,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        height: 40,
                        width: 40,
                        child: Image.asset('assets/img.png'),
                      ),
                    ),
                  ),
                  Text(
                    list[index].date,
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      list[index].title,
                      style: GoogleFonts.quicksand(
                          fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      list[index].description,
                      style: GoogleFonts.quicksand(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            editCard(list[index]);
                          },
                          child: const Icon(
                            Icons.edit,
                            size: 15,
                            color: Color(0xff008B94),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            deleteCard(list[index]);
                          },
                          child: const Icon(
                            Icons.delete_outline_outlined,
                            size: 15,
                            color: Color(0xff008B94),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To-Do List',
          style:
              GoogleFonts.quicksand(fontWeight: FontWeight.w700, fontSize: 26),
        ),
        backgroundColor: const Color(0xff02A7B1),
        foregroundColor: const Color(0xffFFFFFF),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          modalbottomsheet(false);
        },
        backgroundColor: const Color(0xff02A7B1),
        foregroundColor: const Color(0xffFFFFFF),
        child: const Icon(
          Icons.add,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: ((context, index) {
            return myCard(index);
          }),
        ),
      ),
    );
  }
}
