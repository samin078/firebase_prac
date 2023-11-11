import 'package:firebase_prac/screens/result_screen.dart';
import 'package:firebase_prac/unused/skill.dart';
import 'package:firebase_prac/unused/skill_data.dart';
import 'package:flutter/material.dart';

class Skills extends StatefulWidget {
  const Skills({Key? key}) : super(key: key);

  @override
  _SkillsState createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  SkillData skillData = SkillData();

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  List<Skill> categories = [];

  Future<void> loadCategories() async {
    categories = skillData.categories;
  }

  List<Skill> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: const [
            Text('Checkboxes'),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Please Choose the ones you are skilled in:",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              Column(
                children: categories.map((favorite) {
                  return CheckboxListTile(
                    activeColor: Colors.deepPurpleAccent,
                    checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    value: favorite.isChecked,
                    title: Text(favorite.name),
                    onChanged: (val) {
                      setState(() {
                        favorite.isChecked = val ?? false;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              Wrap(
                children: categories.map((favorite) {
                  if (favorite.isChecked == true) {
                    return Card(
                      elevation: 3,
                      color: Colors.deepPurpleAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              favorite.name,
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  favorite.isChecked = !favorite.isChecked;
                                });
                              },
                              child: const Icon(
                                Icons.delete_forever_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Container();
                }).toList(),
              ),
              Divider(color: Colors.grey),
              ElevatedButton(
                onPressed: () {
                  selectedCategories.clear();
                  for (var category in categories) {
                    if (category.isChecked) {
                      selectedCategories.add(category);
                    }
                  }
                  print('Selected Categories: $selectedCategories');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultScreen(),
                    ),
                  );
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
