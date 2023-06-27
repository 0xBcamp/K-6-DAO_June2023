pragma solidity ^0.8.0;

contract Student {
    address public studentAddress; // Address of the student
    string public email; // Email of the student
    string public password; // Password of the student
    bool public isRegistered; // Flag indicating if the student is registered
    address public selectedSubject; // Address of the selected subject (tutor)

    event StudentRegistered(address studentAddress, string email); // Event emitted when a student is registered
    event SubjectSelected(address studentAddress, address tutorAddress); // Event emitted when a subject is selected

    constructor() {
        studentAddress = msg.sender; // Set the student's address as the contract deployer's address
    }

    function register(string memory _email, string memory _password) external {
        require(!isRegistered, "Student is already registered."); // Check if the student is not already registered
        email = _email; // Set the student's email
        password = _password; // Set the student's password
        isRegistered = true; // Mark the student as registered
        emit StudentRegistered(studentAddress, email); // Emit the StudentRegistered event
    }

    function selectSubject(address _tutorAddress) external {
        require(isRegistered, "Student is not registered."); // Check if the student is registered
        require(selectedSubject == address(0), "Student has already selected a subject."); // Check if the student has not already selected a subject
        selectedSubject = _tutorAddress; // Set the selected subject (tutor)
        emit SubjectSelected(studentAddress, _tutorAddress); // Emit the SubjectSelected event
    }
}
