// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentContract {
    struct Student {
        bool isRegistered;
        bool hasSelectedSubject;
        mapping(address => bool) selectedSubjects;
    }

    mapping(address => Student) public students;

    event StudentRegistered(address studentAddress);
    event SubjectSelected(address studentAddress, address tutorAddress);

    function register(string memory _email, string memory _password) external {
        require(!students[msg.sender].isRegistered, "Student is already registered.");

        // Perform additional registration checks if needed

        students[msg.sender].isRegistered = true;

        // Optionally, store additional details about the student

        emit StudentRegistered(msg.sender);
    }

    function selectSubject(address _tutorAddress) external {
        require(students[msg.sender].isRegistered, "Student is not registered.");
        require(!students[msg.sender].hasSelectedSubject, "Student has already selected a subject.");
        require(students[_tutorAddress].isRegistered, "Tutor is not registered.");

        students[msg.sender].selectedSubjects[_tutorAddress] = true;
        students[msg.sender].hasSelectedSubject = true;

        emit SubjectSelected(msg.sender, _tutorAddress);
    }
}
