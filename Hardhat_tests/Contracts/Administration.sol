
pragma solidity ^0.8.0;

import "./MainContract.sol";

contract Administration {
    address public mainContract; // Address of the main contract

    event MainContractSet(address mainContractAddress); // Event emitted when the main contract is set

    function setMainContract(address _mainContract) external {
        require(mainContract == address(0), "Main contract is already set."); // Check if the main contract is not already set
        mainContract = _mainContract; // Set the address of the main contract
        emit MainContractSet(mainContract); // Emit the MainContractSet event
    }

    function accessStudentProfile(
        address _studentAddress
    ) external view returns (string memory) {
        require(mainContract != address(0), "Main contract is not set."); // Check if the main contract is set
        return MainContract(mainContract).getStudentProfile(_studentAddress); // Call the getStudentProfile function of the main contract
    }

    function accessTutorProfile(
        address _tutorAddress
    ) external view returns (string memory) {
        require(mainContract != address(0), "Main contract is not set."); // Check if the main contract is set
        return MainContract(mainContract).getTutorProfile(_tutorAddress); // Call the getTutorProfile function of the main contract
    }

    function editDAOCode(uint256 _parameters) external {
        require(mainContract != address(0), "Main contract is not set."); // Check if the main contract is set
        // MainContract(mainContract).editDAOCode(_parameters); // Call the editDAOCode function of the main contract
    }

function getProfile(address _userAddress) external view returns (string[] memory) {
    require(mainContract != address(0), "Main contract is not set."); // Check if the main contract is set

    string memory studentProfile = MainContract(mainContract).getStudentProfile(_userAddress);
    if (bytes(studentProfile).length == 0) {
        string memory tutorProfile = MainContract(mainContract).getTutorProfile(_userAddress);
        string[] memory profiles = new string[](1);
        profiles[0] = tutorProfile;
        return profiles; // Return an array containing the tutor profile
    }

    string[] memory profiles = new string[](1);
    profiles[0] = studentProfile;
    return profiles; // Return an array containing the student profile
}

}
