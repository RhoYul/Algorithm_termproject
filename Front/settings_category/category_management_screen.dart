import 'package:flutter/material.dart';
import 'SubjectAddScreen.dart';
import 'Subject.dart';

class CategoryManagementScreen extends StatefulWidget {
  @override
  _CategoryManagementScreenState createState() => _CategoryManagementScreenState();
}

class _CategoryManagementScreenState extends State<CategoryManagementScreen> {
  List<Subject> subjectCategories = [];
  List<String> generalCategories = [];

  void _addSubjectCategory() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SubjectAddScreen()),
    ).then((newSubject) {
      if (newSubject != null && newSubject is Subject) {
        setState(() {
          subjectCategories.add(newSubject);
        });
      }
    });
  }

  void _addGeneralCategory() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: Text('Add General Category'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter General Category Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String name = controller.text.trim();
                if (name.isNotEmpty) {
                  setState(() {
                    generalCategories.add(name);
                  });
                }
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _editGeneralCategory(int index) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController();
        controller.text = generalCategories[index];
        return AlertDialog(
          title: Text('Edit General Category'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Edit Category Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String updatedName = controller.text.trim();
                if (updatedName.isNotEmpty) {
                  setState(() {
                    generalCategories[index] = updatedName;
                  });
                }
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _editSubjectCategory(int index) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController();
        controller.text = subjectCategories[index].name;
        return AlertDialog(
          title: Text('Edit Subject'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Edit Subject Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String updatedName = controller.text.trim();
                if (updatedName.isNotEmpty) {
                  setState(() {
                    subjectCategories[index].name = updatedName;
                  });
                }
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteSubjectCategory(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Subject'),
        content: Text('Are you sure you want to delete this subject?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                subjectCategories.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _deleteGeneralCategory(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Category'),
        content: Text('Are you sure you want to delete this category?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                generalCategories.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Management'),
      ),
      body: ListView(
        children: [
          // Subject Category Section
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Subjects'),
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: _addSubjectCategory,
            ),
          ),
          ...subjectCategories.asMap().entries.map((entry) {
            int index = entry.key;
            Subject subject = entry.value;
            return ListTile(
              title: Text(subject.name),
              subtitle: Text("Credit: ${subject.creditHours}, Major: ${subject.isMajor ? 'Yes' : 'No'}"),
              leading: Icon(Icons.book),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _editSubjectCategory(index),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteSubjectCategory(index),
                  ),
                ],
              ),
            );
          }).toList(),
          Divider(),
          // General Category Section
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('General'),
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: _addGeneralCategory,
            ),
          ),
          ...generalCategories.asMap().entries.map((entry) {
            int index = entry.key;
            String category = entry.value;
            return ListTile(
              title: Text(category),
              leading: Icon(Icons.category),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _editGeneralCategory(index),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteGeneralCategory(index),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
