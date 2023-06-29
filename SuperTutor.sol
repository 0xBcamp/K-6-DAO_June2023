// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SuperTutor {
    struct Tutor {
        bool isRegistered;
        bool hasSelectedSubject;
        mapping(address => bool) selectedSubjects;
    }

    mapping(address => Tutor) public tutors;

    event TutorRegistered(address tutorAddress);
    event SubjectSelected(address tutorAddress, address studentAddress);

    function register() external {
        require(!tutors[msg.sender].isRegistered, "Tutor is already registered.");

        // Perform additional registration checks if needed

        tutors[msg.sender].isRegistered = true;

        // Optionally, store additional details about the tutor securely

        emit TutorRegistered(msg.sender);
    }

    function selectSubject(address _studentAddress) external {
        require(tutors[msg.sender].isRegistered, "Tutor is not registered.");
        require(!tutors[msg.sender].hasSelectedSubject, "Tutor has already selected a subject.");
        require(tutors[_studentAddress].isRegistered, "Student is not registered.");

        tutors[msg.sender].selectedSubjects[_studentAddress] = true;
        tutors[msg.sender].hasSelectedSubject = true;

        emit SubjectSelected(msg.sender, _studentAddress);
    }

    function isTutorRegistered(address _tutorAddress) external view returns (bool) {
        return tutors[_tutorAddress].isRegistered;
    }

    function hasTutorSelectedSubject(address _tutorAddress) external view returns (bool) {
        return tutors[_tutorAddress].hasSelectedSubject;
    }

    function isSubjectSelectedByTutor(address _tutorAddress, address _studentAddress) external view returns (bool) {
        return tutors[_tutorAddress].selectedSubjects[_studentAddress];
    }
}
