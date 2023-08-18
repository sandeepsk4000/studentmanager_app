// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// class StudentDetails extends StatelessWidget {

//   dynamic name;
//   dynamic studentId;
//   dynamic domain;
//   dynamic batch;

//   StudentDetails(
//       {required dynamic this.name,
//       required dynamic this.studentId,
//       required dynamic this.domain,
//       required dynamic this.batch,
//       super.key});

//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(),
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.all(10.0),
//           width: 500,
//           height: 500,
//           decoration: BoxDecoration(
//             color: Colors.blueAccent[100],
//           ),
//           child: Card(
//             color: Colors.deepOrange,
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 50,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Align(
//                       alignment: Alignment.topLeft,
//                       child: Text(
//                         'Name :$name ',
//                         style: TextStyle(fontSize: 45),
//                       )),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Align(
//                       alignment: Alignment.topLeft,
//                       child: Text('studentId $studentId', style: TextStyle(fontSize: 45))),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text('domain : $domain', style: TextStyle(fontSize: 45)),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Align(
//                       alignment: Alignment.topLeft,
//                       child: Text('batch : $batch',
//                           style: TextStyle(fontSize: 45))),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                ElevatedButton.icon(
//                     onPressed: () {
//                       return Navigator.pop(context);
//                     },
//                     icon: Icon(Icons.close),
//                     label: Text('close'))
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class StudentDetails extends StatelessWidget {
  final dynamic name;
  final dynamic studentId;
  final dynamic domain;
  final dynamic batch;

  StudentDetails({
    required this.name,
    required this.studentId,
    required this.domain,
    required this.batch,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.0),
          width: 500,
          height: 500,
          decoration: BoxDecoration(
            color: Colors.blueAccent[100],
          ),
          child: Card(
            color: Colors.deepOrange,
            child: Column(
              children: [
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Name: $name',
                      style: TextStyle(fontSize: 45),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'studentId: $studentId',
                      style: TextStyle(fontSize: 45),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'domain: $domain',
                  style: TextStyle(fontSize: 45),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'batch: $batch',
                      style: TextStyle(fontSize: 45),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    return Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                  label: Text('close'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
