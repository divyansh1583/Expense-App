import 'package:expense_app/model/expense_model.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat('DD/MM/yyyy');

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.addExpense});
  final void Function(ExpenseModel) addExpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  CategoryExpense? _selectedCategory;
  //To check valid invalid data and submit it
  void _sumbitData() {
    //checks title is empty or not by trim blank spaces
    var isTitleNUll = _titleController.text.trim().isEmpty;
    var isAmountNull = double.tryParse(_amountController.text) == null;
    var isDateNull = _selectedDate == null;
    var isCategoryNull = _selectedCategory == null;

    //Error Message if all conditions are true
    if (isTitleNUll || isAmountNull || isDateNull || isCategoryNull) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Input!"),
          content: const Text('Please enter all the values correctly.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
      //to make sure no code i srun futher if error occurs
      return;
    }
    //Adding inpust to expense list in home.dart with addExpense()
    widget.addExpense(ExpenseModel(
      title: _titleController.text,
      amount: double.parse(_amountController.text),
      date: _selectedDate!,
      category: _selectedCategory!,
    ));
    Navigator.pop(context);
  }

  //Function to pick Date
  //void _pickDate() async {
  void _pickDate() {
    final now = DateTime.now();
    final dateLimit = DateTime(now.year - 1, now.month, now.day);
    // await showDatePicker(
    showDatePicker(
      context: context,
      initialDate: now,
      firstDate: dateLimit,
      lastDate: now,
    ).then((value) {
      //why cant we use simple function here?
      setState(() {
        _selectedDate = value;
      });
    });
  }

  //To dispose controller values
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    //UI of Add Screen
    return Column(
      children: [
        //column1
        TextField(
          // style: TextStyle(color: Colors.white),
          controller: _titleController,
          maxLength: 50,
          decoration: const InputDecoration(
            labelText: "Title",
          ),
        ),
        const SizedBox(height: 10),
        //column2
        Row(
          children: [
            //AmountField
            SizedBox(
              width: 150,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _amountController,
                decoration: const InputDecoration(
                  prefixText: '₹',
                  labelText: "Amount",
                ),
              ),
            ),
            //Date picker
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(_selectedDate == null
                      ? "No Date Picked"
                      : formatter.format(_selectedDate!)),
                  //Icon Button
                  IconButton(
                      onPressed: _pickDate,
                      icon: const Icon(
                        Icons.calendar_month,
                      ))
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        //column3
        Row(
          children: [
            // Drop Down Button
            DropdownButton(
              value: _selectedCategory,
              items: CategoryExpense.values
                  .map<DropdownMenuItem<CategoryExpense>>((category) {
                return DropdownMenuItem<CategoryExpense>(
                  value: category,
                  child: Text(
                    category.name.toUpperCase(),
                    style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black),
                  ),
                  // child:Text(value.toString().split('.').elementAt(1).toUpperCase()),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Text('cancel'),
            ),
            ElevatedButton(
              onPressed: _sumbitData,
              // onPressed: () {
              //   print(_titleController.text);
              //   print(_amountController.text);
              //   print(_selectedDate.toString());
              //   print(_selectedCategory!.name);
              // },
              child: const Text('Add Expense'),
            ),
          ],
        ),
      ],
    );
  }
}
