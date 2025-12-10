// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Import openzeppelin -> Permet de developper des smart contract securises
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol"; 

// Creation du Contract, herite des fonctionnalite stantard ERC20
contract Lperthui42Token is ERC20, Ownable {
    // Definition du nom du token, son symbole (ticker), et son Owner (msg.sender = la personne qui appelle le Contract, dans le cas de l'appel du constructeur, c'est forcement la personne deployant le contract)
    constructor(uint256 initialSupply)
        ERC20("Lperthui42Token", "LT42")
        Ownable(msg.sender) 
    {
        _mint(msg.sender, initialSupply * 10 ** 18); // Attribu initial supply au deployeur (1 token = 10 ** 18 wei -> unite de base de ETH sur Etherum)
    }
    
    function amITheOwner() public view returns (bool) {
        return msg.sender == owner();
    }
}

