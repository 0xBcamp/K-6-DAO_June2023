import React, { useState } from 'react';
import Web3 from 'web3';

const argon2 = require('argon2');

async function hashPassword(password) {
    try{
        const hash = await argon2.hash(password);
        console.log(hash);
        return hash;
    } catch (err) {
        console.log(err);
    }
}

async function verify(password, hashed){
    try {
        if (await argon2.verify("<big long hash>", "password")) {
          // password match
            return true
        } else {
            return false
          // password did not match
        }
      } catch (err) {
        console.log(err)
        // internal failure
      }
}

const StudentRegister = () => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [account, setAccount] = useState('');

    // Get accounts from MetaMask
    const loadBlockchainData = async () => {
        const web3 = new Web3(Web3.givenProvider || "http://localhost:8545")
        const accounts = await web3.eth.getAccounts()
        setAccount(accounts[0])
    }

  


    // Function to handle form submission
    // Function to handle form submission
    const handleSubmit = async (event) => {

    // Hash the password before sending it
    const hashedPassword = await argon2.hash(password);
    


    event.preventDefault();
    await loadBlockchainData();

    // You'll need the contract ABI and address
    const contractABI = [
        {
            "inputs": [
                {
                    "internalType": "string",
                    "name": "_email",
                    "type": "string"
                },
                {
                    "internalType": "string",
                    "name": "_password",
                    "type": "string"
                }
            ],
            "name": "register",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "address",
                    "name": "_tutorAddress",
                    "type": "address"
                }
            ],
            "name": "selectSubject",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "anonymous": false,
            "inputs": [
                {
                    "indexed": false,
                    "internalType": "address",
                    "name": "studentAddress",
                    "type": "address"
                }
            ],
            "name": "StudentRegistered",
            "type": "event"
        },
        {
            "anonymous": false,
            "inputs": [
                {
                    "indexed": false,
                    "internalType": "address",
                    "name": "studentAddress",
                    "type": "address"
                },
                {
                    "indexed": false,
                    "internalType": "address",
                    "name": "tutorAddress",
                    "type": "address"
                }
            ],
            "name": "SubjectSelected",
            "type": "event"
        },
        {
            "inputs": [
                {
                    "internalType": "address",
                    "name": "_studentAddress",
                    "type": "address"
                }
            ],
            "name": "getStudentProfile",
            "outputs": [
                {
                    "internalType": "string",
                    "name": "",
                    "type": "string"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "address",
                    "name": "",
                    "type": "address"
                }
            ],
            "name": "students",
            "outputs": [
                {
                    "internalType": "bool",
                    "name": "isRegistered",
                    "type": "bool"
                },
                {
                    "internalType": "bool",
                    "name": "hasSelectedSubject",
                    "type": "bool"
                },
                {
                    "internalType": "string",
                    "name": "profile",
                    "type": "string"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        }
    ]; // ABI of your contract
    const contractAddress = '0xd9145CCE52D386f254917e481eB44e9943F39138'; // Address of your contract

    const web3 = new Web3(Web3.givenProvider || "http://localhost:8545")
    const contractInstance = new web3.eth.Contract(contractABI, contractAddress);

    // Call the register function of your contract
    // You should handle errors appropriately and provide user feedback
    await contractInstance.methods.register(email, hashedPassword).send({ from: account });
}


    return (
        <div className="Register">
            <h2>Register</h2>
            <form onSubmit={handleSubmit}>
                <input type="email" placeholder="Email" value={email} onChange={e => setEmail(e.target.value)} required />
                <input type="password" placeholder="Password" value={password} onChange={e => setPassword(e.target.value)} required />
                <button type="submit">Register</button>
            </form>
            <form onSubmit={handleSubmit}>


            </form>

        </div>
    );
}

export default StudentRegister;
