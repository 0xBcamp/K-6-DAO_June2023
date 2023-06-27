pragma solidity ^0.8.0;

contract MainContract {
    address public studentContract; // Address of the student contract
    address public tutorContract; // Address of the tutor contract

    constructor(address _studentContract, address _tutorContract) {
        studentContract = _studentContract; // Set the address of the student contract
        tutorContract = _tutorContract; // Set the address of the tutor contract
    }

    function registerStudent(string memory _email, string memory _password) external {
        Student(studentContract).register(_email, _password); // Call the register function of the student contract
    }

    function registerTutor() external {
        Tutor(tutorContract).register(); // Call the register function of the tutor contract
    }

    function selectSubject(address _tutorAddress) external {
        Student(studentContract).selectSubject(_tutorAddress); // Call the selectSubject function of the student contract
        Tutor(tutorContract).selectSubject(msg.sender); // Call the selectSubject function of the tutor contract
    }
}
