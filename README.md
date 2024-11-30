# GPA Buddy

GPA Buddy is a Flutter-based app designed to simplify GPA calculation by providing an intuitive interface for inputting course details (name, units, and grades) and dynamically calculating results.

 This application uses the Provider package for state management

## Core Functionality

### Add Courses
- Dynamically add new course sections, each with fields for:
- Course Name: Text input for course identification.
- Units: Numeric input for course credit hours.
- Grade: Dropdown selection for grades (A, B, C, D, E, F).

### Real-Time Updates
        
Changes to grades or units instantly update the app's state using Provider.


### Validation

Ensures valid input for course units and grades, preventing errors during GPA calculation.


## Technical Overview

### Key Components

CourseSubsection Widget
    Represents a single course section with three main inputs:
        Course Name: Free-text input.
        Units: Numeric input with validation (only positive integers allowed).
        Grade: Dropdown with predefined grade options.

CourseSelectionList Model
    Manages the state for:
        A list of courses.
        Corresponding course units and grades.
        Addition and update operations for courses.

## Installation and Setup
Prerequisites

    Install Flutter: Flutter installation guide
    A text editor/IDE like VS Code or Android Studio.

Steps

    Clone the repository:

git clone https://github.com/your-repo/GPA-Buddy.git
cd GPA-Buddy

Install dependencies:

flutter pub get

Run the app:

    flutter run

How to Use

    Add Courses
        Click the "Add Course" button to add a new section for inputting course details.

    Enter Course Details
        Fill in the course name, number of units, and select a grade from the dropdown.

    Repeat for All Courses
        Add as many courses as needed by repeating the above steps.

    Calculate GPA
        [Feature Placeholder] Once all course details are entered, GPA calculation logic will process the input.