import 'package:flutter/material.dart';

void main() {
  runApp(MediCareApp());
}

Color darkBg = Color(0xFF081B29);
Color cardColor = Color(0xFF102A3A);
Color blueColor = Color(0xFF0D6EFD);

class Doctor {
  String id;
  String name;
  String email;
  String phone;
  String experience;
  String specialization;
  String department;
  String qualification;
  String password;

  Doctor({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.experience,
    required this.specialization,
    required this.department,
    required this.qualification,
    this.password = "doctor123",
  });
}

class Patient {
  String id;
  String name;
  String email;
  String phone;
  String age;
  String gender;
  String bloodGroup;
  String address;
  String medicalHistory;
  String password;

  Patient({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.age,
    required this.gender,
    required this.bloodGroup,
    required this.address,
    required this.medicalHistory,
    this.password = "patient123",
  });
}

class Appointment {
  String id;
  String patientId;
  String patientName;
  String doctorId;
  String doctorName;
  String department;
  String date;
  String time;
  String reason;
  String status;

  Appointment({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.doctorId,
    required this.doctorName,
    required this.department,
    required this.date,
    required this.time,
    required this.reason,
    required this.status,
  });
}

class NotificationData {
  String title;
  String message;
  String type;
  String recipientRole;
  String recipientId;

  NotificationData({
    required this.title,
    required this.message,
    required this.type,
    this.recipientRole = "",
    this.recipientId = "",
  });
}

class MedicalRecord {
  String patientId;
  String doctorId;
  String doctorName;
  String diagnosis;
  String prescription;
  String notes;
  String date;

  MedicalRecord({
    required this.patientId,
    required this.doctorId,
    required this.doctorName,
    required this.diagnosis,
    required this.prescription,
    required this.notes,
    required this.date,
  });
}

List<Doctor> doctors = [
  Doctor(
    id: "D001",
    name: "Dr. Preet Sharma",
    email: "doctorname@gmail.com",
    phone: "9876543210",
    experience: "8 Years",
    specialization: "Cardiologist",
    department: "Cardiology",
    qualification: "MBBS, MD",
    password: "doctor",
  ),
  Doctor(
    id: "D002",
    name: "Dr. Priya Shah",
    email: "priya@medicare.com",
    phone: "9876543211",
    experience: "6 Years",
    specialization: "Neurologist",
    department: "Neurology",
    qualification: "MBBS, DM",
  ),
  Doctor(
    id: "D003",
    name: "Dr. Rita Patil",
    email: "amit@medicare.com",
    phone: "9876543212",
    experience: "10 Years",
    specialization: "Orthopedic",
    department: "Orthopedic",
    qualification: "MBBS, MS",
  ),
];

List<Patient> patients = [
  Patient(
    id: "P001",
    name: "Sufiya Sayyed",
    email: "patient@gmail.com",
    phone: "9876543215",
    age: "20",
    gender: "Female",
    bloodGroup: "B+",
    address: "Mumbai",
    medicalHistory: "No major medical history",
    password: "patient",
  ),
  Patient(
    id: "P002",
    name: "Reeba Patil",
    email: "rahulpatil@gmail.com",
    phone: "9876543216",
    age: "35",
    gender: "Male",
    bloodGroup: "O+",
    address: "Thane",
    medicalHistory: "Blood pressure history",
  ),
];

List<Appointment> appointments = [];

List<NotificationData> notifications = [
  NotificationData(
    title: "Welcome",
    message: "Welcome to MediCare Admin Portal",
    type: "system",
    recipientRole: "admin",
    recipientId: "admin",
  ),
];

List<MedicalRecord> medicalRecords = [];

class MediCareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MediCare",
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: darkBg,
        primaryColor: blueColor,
        appBarTheme: AppBarTheme(backgroundColor: blueColor, elevation: 0),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: cardColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: RoleSelectionPage(),
    );
  }
}


Widget inputField(
    String label,
    TextEditingController controller, {
      IconData? icon,
      bool password = false,
      TextInputType keyboardType = TextInputType.text,
    }) {
  return TextField(
    controller: controller,
    obscureText: password,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: icon == null ? null : Icon(icon),
    ),
  );
}

class RoleSelectionPage extends StatefulWidget {
  @override
  State<RoleSelectionPage> createState() => _RoleSelectionPageState();
}

class _RoleSelectionPageState extends State<RoleSelectionPage> {
  String selectedRole = "Admin";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;

  void login() {
    String email = emailController.text.trim().toLowerCase();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showError("Please enter email and password");
      return;
    }

    if (selectedRole == "Admin") {
      if (email == "admin@gmail.com" && password == "admin") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminDashboard()),
        );
      } else {
        showError("Invalid Admin Email or Password");
      }
      return;
    }

    if (selectedRole == "Doctor") {
      Doctor? doctor;
      for (Doctor d in doctors) {
        if (d.email.trim().toLowerCase() == email && d.password == password) {
          doctor = d;
          break;
        }
      }

      if (doctor != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorDashboard(doctor: doctor!),
          ),
        );
      } else {
        showError("Invalid Doctor Email or Password");
      }
      return;
    }

    if (selectedRole == "Patient") {
      Patient? patient;
      for (Patient p in patients) {
        if (p.email.trim().toLowerCase() == email && p.password == password) {
          patient = p;
          break;
        }
      }

      if (patient != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PatientDashboard(patient: patient!),
          ),
        );
      } else {
        showError("Invalid Patient Email or Password");
      }
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    color: blueColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Icon(
                    Icons.local_hospital,
                    size: 55,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "MediCare",
                  style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "Your Health, Our Priority",
                  style: TextStyle(fontSize: 16, color: Colors.white60),
                ),
                SizedBox(height: 35),
                Card(
                  color: cardColor,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Text(
                          "Select Portal",
                          style: TextStyle(color: Colors.white70),
                        ),
                        SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: darkBg,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.white24),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedRole,
                              isExpanded: true,
                              dropdownColor: cardColor,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              items: [
                                DropdownMenuItem(
                                  value: "Admin",
                                  child: Text("Admin"),
                                ),
                                DropdownMenuItem(
                                  value: "Doctor",
                                  child: Text("Doctor"),
                                ),
                                DropdownMenuItem(
                                  value: "Patient",
                                  child: Text("Patient"),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  selectedRole = value!;
                                  emailController.clear();
                                  passwordController.clear();
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Enter your email",
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        SizedBox(height: 18),
                        TextField(
                          controller: passwordController,
                          obscureText: hidePassword,
                          decoration: InputDecoration(
                            labelText: "Enter your password",
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                hidePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: login,
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            "Doctor Demo: doctorname@gmail.com / doctor",
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AdminDashboard extends StatefulWidget {
  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      adminHome(),
      DoctorsPage(
        onChanged: () {
          setState(() {});
        },
      ),
      PatientsPage(),
      AdminAppointmentsPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Portal"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      NotificationsPage(role: "admin", id: "admin"),
                ),
              );
            },
            icon: Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => RoleSelectionPage()),
                    (route) => false,
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: cardColor,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.white54,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: "Doctors",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Patients"),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Appointments",
          ),
        ],
      ),
    );
  }

  Widget statCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: blueColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: Colors.blueAccent, size: 28),
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(title, style: TextStyle(color: Colors.white60)),
            ],
          ),
        ],
      ),
    );
  }

  Widget actionButton(String title, IconData icon, VoidCallback function) {
    return Expanded(
      child: SizedBox(
        height: 105,
        child: ElevatedButton(
          onPressed: function,
          style: ElevatedButton.styleFrom(
            backgroundColor: cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.blueAccent, size: 30),
              SizedBox(height: 8),
              Text(title, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  Widget adminHome() {
    int pending = appointments
        .where((appointment) => appointment.status == "Pending")
        .length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome Back, Admin 👋",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 7),
          Text(
            "Manage your MediCare system",
            style: TextStyle(color: Colors.white60),
          ),
          SizedBox(height: 25),
          statCard(
            "Total Doctors",
            doctors.length.toString(),
            Icons.medical_services,
          ),
          SizedBox(height: 12),
          statCard("Total Patients", patients.length.toString(), Icons.people),
          SizedBox(height: 12),
          statCard(
            "Total Appointments",
            appointments.length.toString(),
            Icons.calendar_month,
          ),
          SizedBox(height: 12),
          statCard(
            "Pending Appointments",
            pending.toString(),
            Icons.pending_actions,
          ),
          SizedBox(height: 25),
          Text(
            "Quick Actions",
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              actionButton("Add Doctor", Icons.person_add, () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddDoctorPage()),
                );
                setState(() {});
              }),
              SizedBox(width: 12),
              actionButton("Doctors", Icons.medical_services, () {
                setState(() {
                  selectedIndex = 1;
                });
              }),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              actionButton("Patients", Icons.people, () {
                setState(() {
                  selectedIndex = 2;
                });
              }),
              SizedBox(width: 12),
              actionButton("Appointments", Icons.calendar_month, () {
                setState(() {
                  selectedIndex = 3;
                });
              }),
            ],
          ),
        ],
      ),
    );
  }
}


class AddDoctorPage extends StatefulWidget {
  @override
  State<AddDoctorPage> createState() => _AddDoctorPageState();
}

class _AddDoctorPageState extends State<AddDoctorPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController specializationController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();

  String generatePassword(String name) {
    String cleanName = name
        .replaceAll("Dr.", "")
        .replaceAll("dr.", "")
        .replaceAll(" ", "")
        .trim()
        .toLowerCase();

    if (cleanName.isEmpty) {
      return "doctor@123";
    }
    return cleanName + "@123";
  }

  String generateDoctorId() {
    int number = doctors.length + 1;
    String id = "D${number.toString().padLeft(3, '0')}";

    bool exists = doctors.any((doctor) => doctor.id == id);
    while (exists) {
      number++;
      id = "D${number.toString().padLeft(3, '0')}";
      exists = doctors.any((doctor) => doctor.id == id);
    }
    return id;
  }

  void addDoctor() {
    String name = nameController.text.trim();
    String email = emailController.text.trim().toLowerCase();

    if (name.isEmpty ||
        email.isEmpty ||
        phoneController.text.trim().isEmpty ||
        experienceController.text.trim().isEmpty ||
        specializationController.text.trim().isEmpty ||
        departmentController.text.trim().isEmpty ||
        qualificationController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please fill all doctor details"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!email.contains("@") || !email.contains(".")) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter a valid email"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    for (Doctor d in doctors) {
      if (d.email.toLowerCase() == email) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("This email is already registered"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    String generatedPassword = generatePassword(name);
    String doctorId = idController.text.trim();
    if (doctorId.isEmpty) {
      doctorId = generateDoctorId();
    }

    for (Doctor d in doctors) {
      if (d.id == doctorId) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Doctor ID already exists"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    Doctor doctor = Doctor(
      id: doctorId,
      name: name,
      email: email,
      phone: phoneController.text.trim(),
      experience: experienceController.text.trim(),
      specialization: specializationController.text.trim(),
      department: departmentController.text.trim(),
      qualification: qualificationController.text.trim(),
      password: generatedPassword,
    );

    doctors.add(doctor);

    notifications.add(
      NotificationData(
        title: "New Doctor Added",
        message: "${doctor.name} has been added successfully.",
        type: "doctor",
        recipientRole: "admin",
        recipientId: "admin",
      ),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text("Doctor Added"),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Doctor added successfully."),
              SizedBox(height: 18),
              Text(
                "Doctor Login Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                "Username / Email",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              SelectableText(doctor.email),
              SizedBox(height: 12),
              Text("Password", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              SelectableText(
                doctor.password,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                "Doctor ID: ${doctor.id}",
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text("DONE"),
            ),
          ],
        );
      },
    );
  }

  Widget field(String name, TextEditingController controller, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: inputField(name, controller, icon: icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Doctor")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            Text(
              "Doctor Login Password will be generated automatically.",
              style: TextStyle(color: Colors.white60),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            field("Doctor ID (Optional)", idController, Icons.badge),
            field("Doctor Name", nameController, Icons.person),
            field("Email / Username", emailController, Icons.email),
            field("Phone", phoneController, Icons.phone),
            field("Experience", experienceController, Icons.work),
            field(
              "Specialization",
              specializationController,
              Icons.medical_information,
            ),
            field("Department", departmentController, Icons.business),
            field("Qualification", qualificationController, Icons.school),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: addDoctor,
                child: Text(
                  "ADD DOCTOR",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class DoctorsPage extends StatefulWidget {
  final VoidCallback? onChanged;

  DoctorsPage({this.onChanged});

  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  String selectedDepartment = "All";

  @override
  Widget build(BuildContext context) {
    List<String> departments = ["All"];

    for (Doctor doctor in doctors) {
      if (!departments.contains(doctor.department)) {
        departments.add(doctor.department);
      }
    }

    List<Doctor> filteredDoctors = doctors;

    if (selectedDepartment != "All") {
      filteredDoctors = doctors
          .where((doctor) => doctor.department == selectedDepartment)
          .toList();
    }

    return Scaffold(
      backgroundColor: darkBg,
      body: Column(
        children: [
          SizedBox(
            height: 55,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: departments.length,
              itemBuilder: (context, index) {
                String department = departments[index];

                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 15 : 5,
                    right: 5,
                    top: 10,
                    bottom: 5,
                  ),
                  child: ChoiceChip(
                    label: Text(department),
                    selected: selectedDepartment == department,
                    selectedColor: blueColor,
                    onSelected: (value) {
                      setState(() {
                        selectedDepartment = department;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: filteredDoctors.isEmpty
                ? Center(child: Text("No doctors found"))
                : ListView.builder(
              padding: EdgeInsets.all(15),
              itemCount: filteredDoctors.length,
              itemBuilder: (context, index) {
                Doctor doctor = filteredDoctors[index];

                return Card(
                  color: cardColor,
                  margin: EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(15),
                    leading: CircleAvatar(
                      backgroundColor: blueColor,
                      child: Icon(
                        Icons.medical_services,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      doctor.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(top: 7),
                      child: Text(
                        "${doctor.specialization}\n"
                            "${doctor.department}\n"
                            "${doctor.experience}",
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 17),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorDetailsPage(
                            doctor: doctor,
                            showBookButton: false,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class DoctorDetailsPage extends StatelessWidget {
  final Doctor doctor;
  final bool showBookButton;
  final Patient? patient;

  DoctorDetailsPage({
    required this.doctor,
    this.showBookButton = false,
    this.patient,
  });

  Widget detail(String title, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Doctor Details")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            CircleAvatar(
              radius: 55,
              backgroundColor: blueColor,
              child: Icon(Icons.medical_services, size: 55),
            ),
            SizedBox(height: 15),
            Text(
              doctor.name,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            detail("Doctor ID", doctor.id),
            detail("Email", doctor.email),
            detail("Phone", doctor.phone),
            detail("Specialization", doctor.specialization),
            detail("Department", doctor.department),
            detail("Experience", doctor.experience),
            detail("Qualification", doctor.qualification),
            if (showBookButton)
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookAppointmentPage(
                          doctor: doctor,
                          patient: patient!,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "BOOK APPOINTMENT",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


class PatientsPage extends StatefulWidget {
  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      body: patients.isEmpty
          ? Center(child: Text("No patients found"))
          : ListView.builder(
        padding: EdgeInsets.all(15),
        itemCount: patients.length,
        itemBuilder: (context, index) {
          Patient patient = patients[index];

          return Card(
            color: cardColor,
            margin: EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(15),
              leading: CircleAvatar(
                backgroundColor: blueColor,
                child: Icon(Icons.person),
              ),
              title: Text(
                patient.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "${patient.email}\n"
                    "Age: ${patient.age} | ${patient.bloodGroup}",
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PatientDetailsPage(patient: patient),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}



class PatientDetailsPage extends StatelessWidget {
  final Patient patient;

  PatientDetailsPage({required this.patient});

  Widget info(String title, String value) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text("$title: $value", style: TextStyle(fontSize: 15)),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Appointment> patientAppointments = appointments
        .where((appointment) => appointment.patientId == patient.id)
        .toList();

    List<MedicalRecord> records = medicalRecords
        .where((record) => record.patientId == patient.id)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text("Patient Details")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 55,
                backgroundColor: blueColor,
                child: Icon(Icons.person, size: 55, color: Colors.white),
              ),
            ),

            SizedBox(height: 15),

            Center(
              child: Text(
                patient.name,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: 25),

            Text(
              "Personal Information",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 12),

            info("Patient ID", patient.id),
            info("Email", patient.email),
            info("Phone", patient.phone),
            info("Age", patient.age),
            info("Gender", patient.gender),
            info("Blood Group", patient.bloodGroup),
            info("Address", patient.address),

            SizedBox(height: 15),

            Text(
              "Medical History",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 12),

            info("History", patient.medicalHistory),

            SizedBox(height: 20),

            Text(
              "Appointments",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 12),

            if (patientAppointments.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  "No appointments found",
                  style: TextStyle(color: Colors.white70),
                ),
              ),

            for (Appointment appointment in patientAppointments)
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 12),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.doctorName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8),

                    Text("Department: ${appointment.department}"),

                    Text("Date: ${appointment.date}"),

                    Text("Time: ${appointment.time}"),

                    Text("Reason: ${appointment.reason}"),

                    SizedBox(height: 8),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: appointment.status == "Accepted"
                            ? Colors.green
                            : appointment.status == "Rejected"
                            ? Colors.red
                            : Colors.orange,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        appointment.status,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

            SizedBox(height: 20),

            Text(
              "Medical Records",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 12),

            if (records.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  "No medical records found",
                  style: TextStyle(color: Colors.white70),
                ),
              ),

            for (MedicalRecord record in records)
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 12),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dr. ${record.doctorName}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text("Date: ${record.date}"),

                    SizedBox(height: 6),

                    Text("Diagnosis: ${record.diagnosis}"),

                    SizedBox(height: 6),

                    Text("Prescription: ${record.prescription}"),

                    SizedBox(height: 6),

                    Text("Notes: ${record.notes}"),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}


class AdminAppointmentsPage extends StatefulWidget {
  @override
  State<AdminAppointmentsPage> createState() => _AdminAppointmentsPageState();
}

class _AdminAppointmentsPageState extends State<AdminAppointmentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,

      body: appointments.isEmpty
          ? Center(
        child: Text(
          "No appointments found",
          style: TextStyle(color: Colors.white70, fontSize: 17),
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(15),
        itemCount: appointments.length,

        itemBuilder: (context, index) {
          Appointment appointment = appointments[index];

          return Card(
            color: cardColor,
            margin: EdgeInsets.only(bottom: 12),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),

            child: Padding(
              padding: EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    appointment.doctorName,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text("Patient: ${appointment.patientName}"),

                  Text("Department: ${appointment.department}"),

                  Text("Date: ${appointment.date}"),

                  Text("Time: ${appointment.time}"),

                  Text("Reason: ${appointment.reason}"),

                  SizedBox(height: 10),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),

                    decoration: BoxDecoration(
                      color: appointment.status == "Accepted"
                          ? Colors.green
                          : appointment.status == "Rejected"
                          ? Colors.red
                          : Colors.orange,

                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Text(
                      appointment.status,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


class NotificationsPage extends StatefulWidget {
  final String role;
  final String id;

  NotificationsPage({required this.role, required this.id});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    List<NotificationData> myNotifications = notifications.where((
        notification,
        ) {
      if (notification.recipientRole.isEmpty) {
        return true;
      }

      return notification.recipientRole == widget.role &&
          notification.recipientId == widget.id;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text("Notifications")),

      body: myNotifications.isEmpty
          ? Center(
        child: Text(
          "No notifications",
          style: TextStyle(color: Colors.white70),
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(15),

        itemCount: myNotifications.length,

        itemBuilder: (context, index) {
          NotificationData notification = myNotifications[index];

          return Card(
            color: cardColor,

            margin: EdgeInsets.only(bottom: 12),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),

            child: ListTile(
              contentPadding: EdgeInsets.all(15),

              leading: CircleAvatar(
                backgroundColor: blueColor,

                child: Icon(Icons.notifications, color: Colors.white),
              ),

              title: Text(
                notification.title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              subtitle: Padding(
                padding: EdgeInsets.only(top: 8),

                child: Text(notification.message),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PatientLoginPage extends StatefulWidget {
  @override
  State<PatientLoginPage> createState() => _PatientLoginPageState();
}

class _PatientLoginPageState extends State<PatientLoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  void loginPatient() {
    Patient? patient;

    for (Patient item in patients) {
      if (item.email == emailController.text.trim() &&
          item.password == passwordController.text) {
        patient = item;
        break;
      }
    }

    if (patient != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PatientDashboard(patient: patient!),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid Patient Email or Password")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Patient Login")),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(25),

        child: Column(
          children: [
            SizedBox(height: 45),

            Icon(Icons.person, size: 90, color: Colors.blueAccent),

            SizedBox(height: 20),

            Text(
              "Welcome Back, Patient 👋",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 30),

            inputField(
              "Email",
              emailController,
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),

            SizedBox(height: 18),

            inputField(
              "Password",
              passwordController,
              icon: Icons.lock,
              password: true,
            ),

            SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed: loginPatient,

                child: Text("LOGIN", style: TextStyle(fontSize: 18)),
              ),
            ),

            SizedBox(height: 18),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PatientSignupPage()),
                );
              },

              child: Text("Don't have an account? Create Account"),
            ),

            SizedBox(height: 15),

            Text(
              "Demo: sufiya@gmail.com",
              style: TextStyle(color: Colors.white54),
            ),

            Text(
              "Password: patient123",
              style: TextStyle(color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}


class PatientSignupPage extends StatefulWidget {
  @override
  State<PatientSignupPage> createState() => _PatientSignupPageState();
}

class _PatientSignupPageState extends State<PatientSignupPage> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController ageController = TextEditingController();

  TextEditingController genderController = TextEditingController();

  TextEditingController bloodController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  void signup() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        ageController.text.isEmpty ||
        genderController.text.isEmpty ||
        bloodController.text.isEmpty ||
        addressController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please fill all details")));

      return;
    }

    String newId = "P${(patients.length + 1).toString().padLeft(3, '0')}";

    Patient newPatient = Patient(
      id: newId,
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      age: ageController.text,
      gender: genderController.text,
      bloodGroup: bloodController.text,
      address: addressController.text,
      medicalHistory: "No medical history added",
      password: passwordController.text,
    );

    patients.add(newPatient);

    notifications.add(
      NotificationData(
        title: "New Patient Registered",
        message: "A new patient, ${newPatient.name}, has registered.",
        type: "patient",
        recipientRole: "admin",
        recipientId: "admin",
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Patient registered successfully"),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  }

  Widget field(String title, TextEditingController controller, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14),

      child: inputField(title, controller, icon: icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Patient Account")),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(18),

        child: Column(
          children: [
            field("Full Name", nameController, Icons.person),

            field("Email", emailController, Icons.email),

            field("Phone", phoneController, Icons.phone),

            field("Age", ageController, Icons.cake),

            field("Gender", genderController, Icons.people),

            field("Blood Group", bloodController, Icons.bloodtype),

            field("Address", addressController, Icons.location_on),

            field("Password", passwordController, Icons.lock),

            SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed: signup,

                child: Text(
                  "CREATE ACCOUNT",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class PatientDashboard extends StatefulWidget {
  final Patient patient;

  PatientDashboard({required this.patient});

  @override
  State<PatientDashboard> createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      patientHome(),

      FindDoctorsPage(
        patient: widget.patient,
        onBooked: () {
          setState(() {});
        },
      ),

      MyAppointmentsPage(patient: widget.patient),

      PatientRecordsPage(patient: widget.patient),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Patient Portal"),

        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      NotificationsPage(role: "patient", id: widget.patient.id),
                ),
              );
            },
            icon: Icon(Icons.notifications),
          ),

          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => RoleSelectionPage()),
                    (route) => false,
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),

      body: pages[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,

        type: BottomNavigationBarType.fixed,

        backgroundColor: cardColor,

        selectedItemColor: Colors.blueAccent,

        unselectedItemColor: Colors.white54,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),

          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Doctors"),

          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Appointments",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.medical_information),
            label: "Records",
          ),
        ],
      ),
    );
  }

  Widget patientHome() {
    List<Appointment> myAppointments = appointments
        .where((appointment) => appointment.patientId == widget.patient.id)
        .toList();

    int upcoming = myAppointments.length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(18),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            "Welcome Back, ${widget.patient.name} 👋",
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 8),

          Text(
            "How can we help you today?",
            style: TextStyle(color: Colors.white60, fontSize: 16),
          ),

          SizedBox(height: 25),

          Container(
            width: double.infinity,

            padding: EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(20),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Icon(Icons.local_hospital, size: 40, color: Colors.blueAccent),

                SizedBox(height: 12),

                Text(
                  "Find a Doctor",
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 7),

                Text(
                  "Search doctors and book your appointment.",
                  style: TextStyle(color: Colors.white60),
                ),

                SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  height: 48,

                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },

                    child: Text("FIND DOCTORS"),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: dashboardSmallCard(
                  "Appointments",
                  upcoming.toString(),
                  Icons.calendar_month,
                ),
              ),

              SizedBox(width: 12),

              Expanded(
                child: dashboardSmallCard(
                  "Records",
                  medicalRecords
                      .where((record) => record.patientId == widget.patient.id)
                      .length
                      .toString(),
                  Icons.medical_information,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget dashboardSmallCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Icon(icon, color: Colors.blueAccent, size: 30),

          SizedBox(height: 10),

          Text(
            value,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 4),

          Text(title, style: TextStyle(color: Colors.white60)),
        ],
      ),
    );
  }
}


class FindDoctorsPage extends StatefulWidget {
  final Patient patient;
  final VoidCallback? onBooked;

  FindDoctorsPage({required this.patient, this.onBooked});

  @override
  State<FindDoctorsPage> createState() => _FindDoctorsPageState();
}

class _FindDoctorsPageState extends State<FindDoctorsPage> {
  String search = "";

  @override
  Widget build(BuildContext context) {
    List<Doctor> filtered = doctors.where((doctor) {
      String text =
      "${doctor.name} "
          "${doctor.department} "
          "${doctor.specialization}"
          .toLowerCase();

      return text.contains(search.toLowerCase());
    }).toList();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(15),

          child: TextField(
            onChanged: (value) {
              setState(() {
                search = value;
              });
            },

            decoration: InputDecoration(
              hintText: "Search doctor or department",
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),

        Expanded(
          child: filtered.isEmpty
              ? Center(child: Text("No doctors found"))
              : ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 15),

            itemCount: filtered.length,

            itemBuilder: (context, index) {
              Doctor doctor = filtered[index];

              return Card(
                color: cardColor,

                margin: EdgeInsets.only(bottom: 12),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),

                child: ListTile(
                  contentPadding: EdgeInsets.all(15),

                  leading: CircleAvatar(
                    backgroundColor: blueColor,
                    child: Icon(Icons.medical_services),
                  ),

                  title: Text(
                    doctor.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  subtitle: Padding(
                    padding: EdgeInsets.only(top: 7),
                    child: Text(
                      "${doctor.specialization}\n"
                          "${doctor.department}\n"
                          "${doctor.experience}",
                    ),
                  ),

                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookAppointmentPage(
                            doctor: doctor,
                            patient: widget.patient,
                          ),
                        ),
                      ).then((value) {
                        if (value == true) {
                          setState(() {});

                          if (widget.onBooked != null) {
                            widget.onBooked!();
                          }
                        }
                      });
                    },

                    child: Text("BOOK"),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}


class BookAppointmentPage extends StatefulWidget {
  final Doctor doctor;
  final Patient patient;

  BookAppointmentPage({required this.doctor, required this.patient});

  @override
  State<BookAppointmentPage> createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  TextEditingController dateController = TextEditingController();

  TextEditingController timeController = TextEditingController();

  TextEditingController reasonController = TextEditingController();

  void bookAppointment() {
    if (dateController.text.isEmpty ||
        timeController.text.isEmpty ||
        reasonController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please fill all details")));

      return;
    }

    String appointmentId =
        "A${(appointments.length + 1).toString().padLeft(3, '0')}";

    Appointment appointment = Appointment(
      id: appointmentId,
      patientId: widget.patient.id,
      patientName: widget.patient.name,
      doctorId: widget.doctor.id,
      doctorName: widget.doctor.name,
      department: widget.doctor.department,
      date: dateController.text,
      time: timeController.text,
      reason: reasonController.text,
      status: "Pending",
    );

    appointments.add(appointment);

    notifications.add(
      NotificationData(
        title: "New Appointment Request",
        message: "New appointment request from ${widget.patient.name}.",
        type: "appointment",
        recipientRole: "doctor",
        recipientId: widget.doctor.id,
      ),
    );

    notifications.add(
      NotificationData(
        title: "New Appointment",
        message:
        "${widget.patient.name} booked an appointment with ${widget.doctor.name}.",
        type: "appointment",
        recipientRole: "admin",
        recipientId: "admin",
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Appointment request sent successfully"),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context, true);
  }

  Widget field(String title, TextEditingController controller, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),

      child: inputField(title, controller, icon: icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book Appointment")),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              widget.doctor.name,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 7),

            Text(
              "${widget.doctor.specialization} • "
                  "${widget.doctor.department}",
              style: TextStyle(color: Colors.white60),
            ),

            SizedBox(height: 25),

            field("Date", dateController, Icons.calendar_today),

            field("Time", timeController, Icons.access_time),

            field(
              "Reason for Appointment",
              reasonController,
              Icons.description,
            ),

            SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed: bookAppointment,

                child: Text(
                  "BOOK APPOINTMENT",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//Dikshita
class DoctorLoginPage extends StatefulWidget {
  DoctorLoginPage();

  @override
  State<DoctorLoginPage> createState() => _DoctorLoginPageState();
}

class _DoctorLoginPageState extends State<DoctorLoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;

  void doctorLogin() {
    String email = emailController.text.trim().toLowerCase();
    String password = passwordController.text.trim();
    Doctor? doctor;

    for (Doctor d in doctors) {
      if (d.email.toLowerCase() == email && d.password == password) {
        doctor = d;
        break;
      }
    }

    if (doctor != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DoctorDashboard(doctor: doctor!),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Invalid doctor email or password"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(title: Text("Doctor Login")),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Card(
            color: cardColor,
            elevation: 8,
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                children: [
                  Icon(Icons.medical_services, size: 70, color: blueColor),
                  SizedBox(height: 15),
                  Text(
                    "Doctor Login",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 25),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email / Username",
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          hidePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: doctorLogin,
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Demo: doctorname@gmail.com / doctor",
                    style: TextStyle(color: Colors.white54),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyAppointmentsPage extends StatefulWidget {
  final Patient patient;

  MyAppointmentsPage({required this.patient});

  @override
  State<MyAppointmentsPage> createState() => _MyAppointmentsPageState();
}

class _MyAppointmentsPageState extends State<MyAppointmentsPage> {
  @override
  Widget build(BuildContext context) {
    List<Appointment> myAppointments = appointments
        .where((appointment) => appointment.patientId == widget.patient.id)
        .toList();

    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(backgroundColor: darkBg, title: Text("My Appointments")),
      body: myAppointments.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_month, size: 70, color: Colors.white38),
            SizedBox(height: 15),
            Text(
              "No appointments yet",
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(15),
        itemCount: myAppointments.length,
        itemBuilder: (context, index) {
          Appointment appointment = myAppointments[index];

          return Card(
            color: cardColor,
            margin: EdgeInsets.only(bottom: 15),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: blueColor,
                        child: Icon(Icons.person, color: Colors.white),
                      ),

                      SizedBox(width: 12),

                      Expanded(
                        child: Text(
                          appointment.doctorName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),

                  Text(
                    "Department: ${appointment.department}",
                    style: TextStyle(color: Colors.white70),
                  ),

                  SizedBox(height: 7),

                  Text(
                    "Date: ${appointment.date}",
                    style: TextStyle(color: Colors.white70),
                  ),

                  SizedBox(height: 7),

                  Text(
                    "Time: ${appointment.time}",
                    style: TextStyle(color: Colors.white70),
                  ),

                  SizedBox(height: 7),

                  Text(
                    "Reason: ${appointment.reason}",
                    style: TextStyle(color: Colors.white70),
                  ),

                  SizedBox(height: 12),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: appointment.status == "Accepted"
                          ? Colors.green.withValues(alpha: 0.2)
                          : appointment.status == "Rejected"
                          ? Colors.red.withValues(alpha: 0.2)
                          : Colors.orange.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      appointment.status,
                      style: TextStyle(
                        color: appointment.status == "Accepted"
                            ? Colors.greenAccent
                            : appointment.status == "Rejected"
                            ? Colors.redAccent
                            : Colors.orangeAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PatientProfilePage extends StatelessWidget {
  final Patient patient;

  PatientProfilePage({required this.patient});

  Widget profileRow(IconData icon, String title, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: blueColor, size: 25),

          SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),

                SizedBox(height: 4),

                Text(
                  value,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(backgroundColor: darkBg, title: Text("My Profile")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 55,
              backgroundColor: blueColor,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),

            SizedBox(height: 15),

            Text(
              patient.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 25),

            profileRow(Icons.badge, "Patient ID", patient.id),

            profileRow(Icons.email, "Email", patient.email),

            profileRow(Icons.phone, "Phone", patient.phone),

            profileRow(Icons.calendar_today, "Age", patient.age),

            profileRow(Icons.person, "Gender", patient.gender),

            profileRow(Icons.bloodtype, "Blood Group", patient.bloodGroup),

            profileRow(Icons.location_on, "Address", patient.address),

            profileRow(
              Icons.medical_information,
              "Medical History",
              patient.medicalHistory,
            ),
          ],
        ),
      ),
    );
  }
}

class PatientRecordsPage extends StatelessWidget {
  final Patient patient;

  PatientRecordsPage({required this.patient});

  @override
  Widget build(BuildContext context) {
    List<MedicalRecord> records = medicalRecords
        .where((record) => record.patientId == patient.id)
        .toList();

    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(backgroundColor: darkBg, title: Text("Medical Records")),
      body: records.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.medical_information,
              size: 70,
              color: Colors.white38,
            ),
            SizedBox(height: 15),
            Text(
              "No medical records available",
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(15),
        itemCount: records.length,
        itemBuilder: (context, index) {
          MedicalRecord record = records[index];

          return Card(
            color: cardColor,
            margin: EdgeInsets.only(bottom: 15),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    record.doctorName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Date: ${record.date}",
                    style: TextStyle(color: Colors.white60),
                  ),

                  Divider(color: Colors.white24, height: 25),

                  Text(
                    "Diagnosis",
                    style: TextStyle(
                      color: blueColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    record.diagnosis,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),

                  SizedBox(height: 15),

                  Text(
                    "Prescription",
                    style: TextStyle(
                      color: blueColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    record.prescription,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),

                  SizedBox(height: 15),

                  Text(
                    "Doctor's Notes",
                    style: TextStyle(
                      color: blueColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    record.notes,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DoctorDashboard extends StatefulWidget {
  final Doctor doctor;

  DoctorDashboard({required this.doctor});

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      doctorHome(),
      DoctorAppointmentsPage(doctor: widget.doctor),
      DoctorPatientsPage(doctor: widget.doctor),
      DoctorMedicalRecordsPage(doctor: widget.doctor),
    ];

    return Scaffold(
      backgroundColor: darkBg,
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        backgroundColor: cardColor,
        selectedItemColor: blueColor,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Appointments",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Patients"),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_information),
            label: "Records",
          ),
        ],
      ),
    );
  }

  Widget doctorHome() {
    List<Appointment> myAppointments = appointments
        .where((appointment) => appointment.doctorId == widget.doctor.id)
        .toList();

    int pending = myAppointments
        .where((appointment) => appointment.status == "Pending")
        .length;

    int accepted = myAppointments
        .where((appointment) => appointment.status == "Accepted")
        .length;

    Set<String> patientIds = {};

    for (Appointment appointment in myAppointments) {
      patientIds.add(appointment.patientId);
    }

    return Scaffold(
      backgroundColor: darkBg,

      appBar: AppBar(
        backgroundColor: darkBg,
        title: Text("Doctor Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      NotificationsPage(role: "doctor", id: widget.doctor.id),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => RoleSelectionPage()),
                    (route) => false,
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome, ${widget.doctor.name} 👋",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 5),

            Text(
              widget.doctor.specialization,
              style: TextStyle(color: Colors.white60, fontSize: 16),
            ),

            SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  child: dashboardCard(
                    "Appointments",
                    myAppointments.length.toString(),
                    Icons.calendar_month,
                  ),
                ),

                SizedBox(width: 12),

                Expanded(
                  child: dashboardCard(
                    "Pending",
                    pending.toString(),
                    Icons.pending_actions,
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: dashboardCard(
                    "Accepted",
                    accepted.toString(),
                    Icons.check_circle,
                  ),
                ),

                SizedBox(width: 12),

                Expanded(
                  child: dashboardCard(
                    "Patients",
                    patientIds.length.toString(),
                    Icons.people,
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),

            Text(
              "Quick Actions",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 15),

            quickAction(Icons.calendar_month, "My Appointments", () {
              setState(() {
                selectedIndex = 1;
              });
            }),

            quickAction(Icons.people, "My Patients", () {
              setState(() {
                selectedIndex = 2;
              });
            }),

            quickAction(Icons.medical_information, "Medical Records", () {
              setState(() {
                selectedIndex = 3;
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget dashboardCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(icon, color: blueColor, size: 35),

          SizedBox(height: 10),

          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 5),

          Text(title, style: TextStyle(color: Colors.white60)),
        ],
      ),
    );
  }

  Widget quickAction(IconData icon, String title, VoidCallback onTap) {
    return Card(
      color: cardColor,
      margin: EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: blueColor,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title, style: TextStyle(color: Colors.white)),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white54,
          size: 18,
        ),
        onTap: onTap,
      ),
    );
  }
}

class DoctorAppointmentsPage extends StatefulWidget {
  final Doctor doctor;

  DoctorAppointmentsPage({required this.doctor});

  @override
  State<DoctorAppointmentsPage> createState() => _DoctorAppointmentsPageState();
}

class _DoctorAppointmentsPageState extends State<DoctorAppointmentsPage> {
  void acceptAppointment(Appointment appointment) {
    setState(() {
      appointment.status = "Accepted";
    });

    notifications.add(
      NotificationData(
        title: "Appointment Confirmed",
        message:
        "Your appointment has been booked with ${appointment.doctorName}.",
        type: "appointment",
        recipientRole: "patient",
        recipientId: appointment.patientId,
      ),
    );

    notifications.add(
      NotificationData(
        title: "Appointment Accepted",
        message:
        "${appointment.doctorName} accepted the appointment of ${appointment.patientName}.",
        type: "appointment",
        recipientRole: "admin",
        recipientId: "admin",
      ),
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Appointment accepted")));
  }

  void rejectAppointment(Appointment appointment) {
    setState(() {
      appointment.status = "Rejected";
    });

    notifications.add(
      NotificationData(
        title: "Appointment Rejected",
        message:
        "Your appointment with ${appointment.doctorName} has been rejected.",
        type: "appointment",
        recipientRole: "patient",
        recipientId: appointment.patientId,
      ),
    );

    notifications.add(
      NotificationData(
        title: "Appointment Rejected",
        message:
        "${appointment.doctorName} rejected the appointment of ${appointment.patientName}.",
        type: "appointment",
        recipientRole: "admin",
        recipientId: "admin",
      ),
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Appointment rejected")));
  }

  @override
  Widget build(BuildContext context) {
    List<Appointment> myAppointments = appointments
        .where((appointment) => appointment.doctorId == widget.doctor.id)
        .toList();

    return Scaffold(
      backgroundColor: darkBg,

      appBar: AppBar(backgroundColor: darkBg, title: Text("My Appointments")),

      body: myAppointments.isEmpty
          ? Center(
        child: Text(
          "No appointments yet",
          style: TextStyle(color: Colors.white70, fontSize: 18),
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(15),
        itemCount: myAppointments.length,
        itemBuilder: (context, index) {
          Appointment appointment = myAppointments[index];

          return Card(
            color: cardColor,
            margin: EdgeInsets.only(bottom: 15),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appointment.patientName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Date: ${appointment.date}",
                    style: TextStyle(color: Colors.white70),
                  ),

                  SizedBox(height: 5),

                  Text(
                    "Time: ${appointment.time}",
                    style: TextStyle(color: Colors.white70),
                  ),

                  SizedBox(height: 5),

                  Text(
                    "Reason: ${appointment.reason}",
                    style: TextStyle(color: Colors.white70),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Status: ${appointment.status}",
                    style: TextStyle(
                      color: appointment.status == "Accepted"
                          ? Colors.greenAccent
                          : appointment.status == "Rejected"
                          ? Colors.redAccent
                          : Colors.orangeAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  if (appointment.status == "Pending")
                    SizedBox(height: 15),

                  if (appointment.status == "Pending")
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              acceptAppointment(appointment);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: Text(
                              "Accept",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),

                        SizedBox(width: 10),

                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              rejectAppointment(appointment);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: Text(
                              "Reject",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DoctorPatientsPage extends StatelessWidget {
  final Doctor doctor;

  DoctorPatientsPage({required this.doctor});

  @override
  Widget build(BuildContext context) {
    List<String> patientIds = [];

    for (Appointment appointment in appointments) {
      if (appointment.doctorId == doctor.id) {
        if (!patientIds.contains(appointment.patientId)) {
          patientIds.add(appointment.patientId);
        }
      }
    }

    List<Patient> myPatients = patients
        .where((patient) => patientIds.contains(patient.id))
        .toList();

    return Scaffold(
      backgroundColor: darkBg,

      appBar: AppBar(backgroundColor: darkBg, title: Text("My Patients")),

      body: myPatients.isEmpty
          ? Center(
        child: Text(
          "No patients yet",
          style: TextStyle(color: Colors.white70, fontSize: 18),
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(15),
        itemCount: myPatients.length,
        itemBuilder: (context, index) {
          Patient patient = myPatients[index];

          return Card(
            color: cardColor,
            margin: EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: blueColor,
                child: Icon(Icons.person, color: Colors.white),
              ),

              title: Text(
                patient.name,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: Text(
                "Age: ${patient.age} | ${patient.gender}",
                style: TextStyle(color: Colors.white60),
              ),

              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white54,
                size: 18,
              ),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PatientDetailsPage(patient: patient),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}


// DOCTOR MEDICAL RECORDS PAGE


class DoctorMedicalRecordsPage extends StatefulWidget {
  final Doctor doctor;

  DoctorMedicalRecordsPage({required this.doctor});

  @override
  State<DoctorMedicalRecordsPage> createState() =>
      _DoctorMedicalRecordsPageState();
}

class _DoctorMedicalRecordsPageState extends State<DoctorMedicalRecordsPage> {
  void addMedicalRecord() {
    List<String> patientIds = [];

    for (Appointment appointment in appointments) {
      if (appointment.doctorId == widget.doctor.id) {
        if (!patientIds.contains(appointment.patientId)) {
          patientIds.add(appointment.patientId);
        }
      }
    }

    List<Patient> myPatients = patients
        .where((patient) => patientIds.contains(patient.id))
        .toList();

    if (myPatients.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No patients available")));
      return;
    }

    Patient selectedPatient = myPatients[0];

    TextEditingController diagnosisController = TextEditingController();

    TextEditingController prescriptionController = TextEditingController();

    TextEditingController notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: cardColor,

              title: Text(
                "Add Medical Record",
                style: TextStyle(color: Colors.white),
              ),

              content: SingleChildScrollView(
                child: Column(
                  children: [
                    DropdownButtonFormField<Patient>(
                      value: selectedPatient,
                      dropdownColor: cardColor,
                      decoration: InputDecoration(
                        labelText: "Select Patient",
                        labelStyle: TextStyle(color: Colors.white70),
                      ),
                      style: TextStyle(color: Colors.white),
                      items: myPatients.map((Patient patient) {
                        return DropdownMenuItem<Patient>(
                          value: patient,
                          child: Text(patient.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setDialogState(() {
                            selectedPatient = value;
                          });
                        }
                      },
                    ),

                    SizedBox(height: 15),

                    TextField(
                      controller: diagnosisController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Diagnosis",
                        labelStyle: TextStyle(color: Colors.white70),
                        border: OutlineInputBorder(),
                      ),
                    ),

                    SizedBox(height: 15),

                    TextField(
                      controller: prescriptionController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Prescription",
                        labelStyle: TextStyle(color: Colors.white70),
                        border: OutlineInputBorder(),
                      ),
                    ),

                    SizedBox(height: 15),

                    TextField(
                      controller: notesController,
                      maxLines: 3,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Doctor's Notes",
                        labelStyle: TextStyle(color: Colors.white70),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),

              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    if (diagnosisController.text.isEmpty ||
                        prescriptionController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Please fill diagnosis and prescription",
                          ),
                        ),
                      );
                      return;
                    }

                    medicalRecords.add(
                      MedicalRecord(
                        patientId: selectedPatient.id,
                        doctorId: widget.doctor.id,
                        doctorName: widget.doctor.name,
                        diagnosis: diagnosisController.text,
                        prescription: prescriptionController.text,
                        notes: notesController.text,
                        date: DateTime.now().toString().substring(0, 10),
                      ),
                    );

                    notifications.add(
                      NotificationData(
                        title: "New Medical Record",
                        message:
                        "${widget.doctor.name} added a new medical record for you.",
                        type: "medical_record",
                        recipientRole: "patient",
                        recipientId: selectedPatient.id,
                      ),
                    );

                    Navigator.pop(context);

                    setState(() {});

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Medical record added successfully"),
                      ),
                    );
                  },

                  style: ElevatedButton.styleFrom(backgroundColor: blueColor),

                  child: Text("Save", style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<MedicalRecord> records = medicalRecords
        .where((record) => record.doctorId == widget.doctor.id)
        .toList();

    return Scaffold(
      backgroundColor: darkBg,

      appBar: AppBar(
        backgroundColor: darkBg,
        title: Text("Medical Records"),
        actions: [
          IconButton(onPressed: addMedicalRecord, icon: Icon(Icons.add)),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: blueColor,
        onPressed: addMedicalRecord,
        child: Icon(Icons.add, color: Colors.white),
      ),

      body: records.isEmpty
          ? Center(
        child: Text(
          "No medical records yet",
          style: TextStyle(color: Colors.white70, fontSize: 18),
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(15),
        itemCount: records.length,
        itemBuilder: (context, index) {
          MedicalRecord record = records[index];

          return Card(
            color: cardColor,
            margin: EdgeInsets.only(bottom: 15),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    record.doctorName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Date: ${record.date}",
                    style: TextStyle(color: Colors.white60),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Diagnosis: ${record.diagnosis}",
                    style: TextStyle(color: Colors.white),
                  ),

                  SizedBox(height: 6),

                  Text(
                    "Prescription: ${record.prescription}",
                    style: TextStyle(color: Colors.white),
                  ),

                  SizedBox(height: 6),

                  Text(
                    "Notes: ${record.notes}",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
