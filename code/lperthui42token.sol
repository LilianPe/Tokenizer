// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Import openzeppelin -> Permet de developper des smart contract securises
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol"; 


// Creation du Contract, herite des fonctionnalite stantard ERC20
contract Lperthui42Token is ERC20, Ownable {
    
    // Definition de la struct stockant les requetes de mint
    struct MintRequest {
        address to; // Adresse du mint
        uint256 amount; // Valeur du mint
        uint256 approvals; // Nombre de signatures
        bool executed; // Si la requetes a ete executee
    }

    MintRequest[] public mintRequests; // Les requetes de mint en cours de signature
    mapping(uint256 => mapping(address => bool)) public approved; // map d'adresse de requete -> map d'adresse des signataires -> si ils ont signe
    mapping(address => bool) public isSigner; // map renvoyant si une adresse est signataire ou non
    uint256 public requiredSignatures; // Le nombre de signatures requises pour valider un mint dans le contract
    
    // Definition du nom du token, son symbole (ticker), et son Owner (msg.sender = la personne qui appelle le Contract, dans le cas de l'appel du constructeur, c'est forcement la personne deployant le contract)
    constructor(uint256 initialSupply, address[] memory signers, uint256 _requiredSignatures)
        ERC20("Lperthui42Token", "LT42")
        Ownable(msg.sender) 
    {
        require(_requiredSignatures <= signers.length, "Invalid threshold"); // Verifie la coherence entre signers et _requiredSignature
        _mint(msg.sender, initialSupply * 10 ** 18); // Attribu initial supply au deployeur (1 token = 10 ** 18 wei -> unite de base de ETH sur Etherum)
        requiredSignatures = _requiredSignatures;
        for (uint i = 0; i < signers.length; i++) {
            isSigner[signers[i]] = true; // Map chaque adresse de signers dans isSigner
        }
    }
    
    function amITheOwner() public view returns (bool) {
        return msg.sender == owner(); // Renvoie si l'appellant est Owner du contract
    }

    function proposeMint(address to, uint256 amount) public onlyOwner returns (uint256) {
        mintRequests.push(MintRequest({
            to: to,
            amount: amount,
            approvals: 0,
            executed: false
        })); // push la requete dans mintRequest pour qu'elle puisse etre signee par les autres signataires

        return mintRequests.length - 1; // Renvoie l'index de la requete
    }

    function approveMint(uint256 id) public {
        require(isSigner[msg.sender], "Not authorized"); // Verifie si l'appelant est signataire

        MintRequest storage req = mintRequests[id]; // Recupere la requete de signature correspondante a id

        require(!req.executed, "Already executed"); // Verifie si la requete est toujours en cours
        require(!approved[id][msg.sender], "Already approved"); // Verifie si l'appelant n'a pas deja signe la requete

        approved[id][msg.sender] = true; // Id a signe la requete
        req.approvals++; // Update le nombre de signatures

        if (req.approvals >= requiredSignatures) { // Si assez de signatures
            _mint(req.to, req.amount * 10 ** 18); // Effectue le mint
            req.executed = true; // Requete effectuee
        }
    }

    function getNumberOfMintRequest() public view returns (uint256) {
        return mintRequests.length; // Renvoie le nombre de request
    }

    function getMintRequest(uint256 id) public view  
        returns (address to, uint256 amount, uint256 approvals, bool executed)  
    {
        MintRequest storage req = mintRequests[id];
        return (req.to, req.amount, req.approvals, req.executed); // Permet de voir l'etat d'une requete
    }

}
