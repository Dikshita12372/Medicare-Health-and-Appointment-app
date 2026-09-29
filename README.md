# MediCare - Health & Appointment App

MediCare is a Flutter-based healthcare application that connects patients, doctors, and administrators in one simple app.

The app allows patients to register and book appointments, doctors to manage appointment requests and patients, and admins to manage doctors, patients, and appointments.

## Features

### Admin
- Admin Login
- Admin Dashboard
- Add Doctors
- View Doctors
- View Patients
- View Appointments
- Manage the healthcare system

### Doctor
- Doctor Login
- Doctor Dashboard
- View Appointment Requests
- Accept or Reject Appointments
- Manage Availability
- View Patients
- View Patient Details
- Add Prescriptions
- Doctor Profile

### Patient
- Patient Registration
- Patient Login
- View Doctors
- Search Doctors
- Select Doctor
- Book Appointment
- View Appointment Status
- View My Appointments

## Appointment Flow

```text
Patient
   ↓
Select Doctor
   ↓
Book Appointment
   ↓
Appointment Request
   ↓
Selected Doctor
   ↓
Accept / Reject
   ↓
Patient sees updated status
