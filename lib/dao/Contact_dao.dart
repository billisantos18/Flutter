import 'package:bitycode/models/contact.dart';
import 'package:bitycode/databases/app_databases.dart';
import 'package:sqflite/sqflite.dart';

class ContactDao {

  static const String tablesql = 'CREATE TABLE $_tableName ('
      '$_id INTEGER PRAMARY KEY,'
      '$_name TEXT, '
      '$_accountNumber INTERGER)';

  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';

  Future <int>  save(Contact contact) async{
    final Database db = await createDatabase();
    Map<String, dynamic> contactMap = _toMap(contact);
    return  db.insert(_tableName, contactMap);
    //return createDatabase().then((db){
    // final Map<String, dynamic> contactMap = Map();
    //contactMap['name'] = contact.name;
    //contactMap['account_number'] = contact.accountNumber;
    // return  db.insert('contacts', contactMap);
    //});
  }

  Map<String, dynamic> _toMap(Contact contact) {

    final Map<String, dynamic> contactMap = Map();
    contactMap[_name] = contact.name;
    contactMap[_accountNumber] = contact.accountNumber;
    return contactMap;
  }

  Future<List<Contact>> findAll() async {
    final Database db = await createDatabase();
    final List<Map<String, dynamic>> result = await  db.query(_tableName);
    List<Contact> contacts = _toList(result);
    return contacts;


  }

  List<Contact> _toList(List<Map<String, dynamic>> result) {
     final List<Contact> contacts = List();
    for(Map<String, dynamic> row in result){
      final Contact contact = Contact(row[_id], row[_name], row[_accountNumber]);
      contacts.add(contact);
    }
    return contacts;
  }
}