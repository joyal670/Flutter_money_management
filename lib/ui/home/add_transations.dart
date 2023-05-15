import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:money_management/db/catgeory/category_db.dart';
import 'package:money_management/db/transations/transations_db.dart';
import 'package:money_management/models/category/category.dart';
import 'package:money_management/models/transcations/transactions.dart';

class AddTranscations extends StatefulWidget {
  static const routeName = "addTranscations";

  const AddTranscations({super.key});

  @override
  State<AddTranscations> createState() => _AddTranscationsState();
}

class _AddTranscationsState extends State<AddTranscations> {
  /*  
  purpose (text)
  date (date picker)
  amount (text)
  income/expence (radio)
  type (drop down) */

  DateTime? _selectedDate;
  CategoryType? _selectedType;
  CategoryModel? _selectedCategoryModel;
  String? _selectedDropDownValue;

  final _purposeController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void initState() {
    _selectedType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _purposeController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(hintText: 'Purpose'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Amount'),
              ),
              TextButton.icon(
                  onPressed: () async {
                    final _selectedDateTemp = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 30)),
                      lastDate: DateTime.now(),
                    );

                    if (_selectedDateTemp == null) {
                      return;
                    } else {
                      setState(() {
                        _selectedDate = _selectedDateTemp;
                      });
                    }
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: Text(_selectedDate == null
                      ? 'Select Date'
                      : _selectedDate.toString())),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                      value: CategoryType.income,
                      groupValue: _selectedType,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedType = CategoryType.income;
                          _selectedDropDownValue = null;
                        });
                      }),
                  Text('Income'),
                  Radio(
                      value: CategoryType.expense,
                      groupValue: _selectedType,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedType = CategoryType.expense;
                          _selectedDropDownValue = null;
                        });
                      }),
                  Text('Expence')
                ],
              ),
              DropdownButton(
                  hint: const Text('Select type'),
                  value: _selectedDropDownValue,
                  items: (_selectedType == CategoryType.income
                          ? categoryDb.instance.incomeList
                          : categoryDb.instance.expenceList)
                      .value
                      .map((e) {
                    return DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name),
                      onTap: () {
                        _selectedCategoryModel = e;
                      },
                    );
                  }).toList(),
                  onChanged: (selectedValue) {
                    setState(() {
                      _selectedDropDownValue = selectedValue;
                    });
                  }),
              ElevatedButton(
                  onPressed: () {
                    AddTranscations();
                  },
                  child: const Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }

  AddTranscations() async {
    if (_purposeController.text.isEmpty) {
      return;
    }
    if (_amountController.text.isEmpty) {
      return;
    }
    if (_selectedDate == null) {
      return;
    }
    if (_selectedDropDownValue == null) {
      return;
    }

    final _parsedAmount = double.tryParse(_amountController.text);
    if (_parsedAmount == null) {
      return;
    }

    if (_selectedCategoryModel == null) {
      return;
    }
    final model = TransactionModel(
        purpose: _purposeController.text,
        amount: _parsedAmount,
        date: _selectedDate!,
        categoryType: _selectedType!,
        categoryModel: _selectedCategoryModel!);

    await TrsansctionDb.instance.addTransation(model);
    print(TrsansctionDb.instance.getTranscation());
    Navigator.of(context).pop();
    TrsansctionDb().refersh();
  }
}
