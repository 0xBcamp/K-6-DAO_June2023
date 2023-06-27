pragma solidity ^0.8.0;

contract Tutor {
    address public tutorAddress; // Address of the tutor
    bool public isRegistered; // Flag indicating if the tutor is registered
    address public selectedSubject; // Address of the selected subject (student)

    event TutorRegistered(address tutorAddress); // Event emitted when a tutor is registered
    event SubjectSelected(address tutorAddress, address studentAddress); // Event emitted when a subject is selected

    constructor() {
        tutorAddress = msg.sender; // Set the tutor's address as the contract deployer's address
    }

    function register() external {
        require(!isRegistered, "Tutor is already registered."); // Check if the tutor is not already registered
        isRegistered = true; // Mark the tutor as registered
        emit TutorRegistered(tutorAddress); // Emit the TutorRegistered event
    }

    function selectSubject(address _studentAddress) external {
        require(isRegistered, "Tutor is not registered."); // Check if the tutor is registered
        require(selectedSubject == address(0), "Tutor has already selected a subject."); // Check if the tutor has not already selected a subject
        selectedSubject = _studentAddress; // Set the selected subject (student)
        emit SubjectSelected(tutorAddress, _studentAddress); // Emit the SubjectSelected event
    }
}
