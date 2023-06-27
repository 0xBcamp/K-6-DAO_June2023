//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Administration.sol";
import "./StudentContract.sol";
import "./SuperTutor.sol";

contract MainContract {
    address public studentContract; // Address of the student contract
    address public tutorContract; // Address of the tutor contract
    address public administrationContract; // Address of the administration contract

    constructor(
        address _studentContract,
        address _tutorContract,
        address _administrationContract
    ) {
        studentContract = _studentContract; // Set the address of the student contract
        tutorContract = _tutorContract; // Set the address of the tutor contract
        administrationContract = _administrationContract; // Set the address of the administration contract
    }

    function registerStudent(
        string memory _email,
        string memory _password
    ) external {
        StudentContract(studentContract).register(_email, _password); // Call the register function of the student contract
    }

    function registerTutor() external {
        SuperTutor(tutorContract).register(); // Call the register function of the tutor contract
    }

    function selectSubject(address _tutorAddress) external {
        StudentContract(studentContract).selectSubject(_tutorAddress); // Call the selectSubject function of the student contract
        SuperTutor(tutorContract).selectSubject(msg.sender); // Call the selectSubject function of the tutor contract
    }

    function setAdministrationContract(
        address _administrationContract
    ) external {
        administrationContract = _administrationContract; // Set the address of the administration contract
    }

    function accessStudentProfile(
        address _studentAddress
    ) external view returns (string memory) {
        require(
            administrationContract != address(0),
            "Administration contract is not set."
        ); // Check if the administration contract is set
        return
            Administration(administrationContract).getProfile(_studentAddress); // Call the getStudentProfile function of the administration contract
    }

    function accessTutorProfile(
        address _tutorAddress
    ) external view returns (string memory) {
        require(
            administrationContract != address(0),
            "Administration contract is not set."
        ); // Check if the administration contract is set
        return Administration(administrationContract).getProfile(_tutorAddress); // Call the getTutorProfile function of the administration contract
    }
}
