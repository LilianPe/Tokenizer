# Lperthui42Token

Lperthui42Token est un **token ERC20 personnalisable** avec un mécanisme de **mint multi-signatures**, développé pour Ethereum et compatible avec Binance Smart Chain (BSC). Ce smart contract permet de sécuriser le processus de création de nouveaux tokens grâce à un système de signatures multiples.

---

## Fonctionnalités principales

- **ERC20 Standard** : Hérite du standard ERC20 d’OpenZeppelin pour garantir la compatibilité et la sécurité.
- **Propriété et contrôle** : Utilisation de `Ownable` pour désigner un propriétaire unique capable de proposer des mint.
- **Mint multi-signatures** : Les requêtes de mint doivent être approuvées par un nombre prédéfini de signataires avant d’être exécutées.
- **Suivi des mint** : Chaque requête de mint est stockée avec ses détails (destinataire, montant, nombre d’approbations, statut d’exécution), ce qui permet de consulter ces differentes informations avant de le signer.

---

## Choix de la blockchain

Le choix de la blockchain **BNB Chain** a été motivé par plusieurs raisons :

1. **Recommandation du sujet** : Le sujet recommande BNB en raison de son impact (et de leur partenariat).
2. **Facilité pour tester et déployer** : Le testnet BNB permet de tester le contrat avant un déploiement mainnet réel.
3. **Recuperation de tokens de test simple** : BNB Chain Faucet permet de recuperer des Tbnb (Token de test) tres facilement.

---

## Choix du langage

Le smart contract a été développé en **Solidity**, version **0.8.20**.  

- **Solidity** est le langage standard pour créer des smart contracts sur Ethereum et les blockchains compatibles EVM, comme BNB Chain.  
- Cette version (0.8.x) permet de bénéficier de **contrôles automatiques sur les overflow et underflow**, ce qui renforce la sécurité du token.  
- Solidity est largement supporté par les outils de développement (Remix, Hardhat, Truffle) et les wallets (MetaMask), ce qui facilite le déploiement et les tests.

---

## Raisons des choix techniques

### 1. Utilisation d’OpenZeppelin
OpenZeppelin est une bibliothèque éprouvée pour le développement de smart contracts sécurisés. Elle permet au contract d'heriter de `ERC20` (norme pour etherum et BNB) et `Ownable`, ce qui permet :

- D'eviter les vulnérabilités courantes liées aux tokens (overflow/underflow, gestion des balances, etc.).
- Gagner du temps en utilisant des fonctions testées et standardisées.
- Bénéficier de fonctionnalités de sécurité comme la gestion des ownership et des droits.

### 2. Multisignature pour les mint
Le choix de requérir plusieurs signatures pour exécuter un mint permet :

- D'empecher un propriétaire malveillant d’émettre des tokens arbitrairement.
- De garantir que plusieurs parties de confiance valident chaque création de token.

### 3. Echelle des tokens
J’ai utilisé `amount * 10 ** 18` pour:

- Respecter le standard ERC20 où 1 token = 10^18 unités de base.
- Assurer la compatibilité avec des wallets comme MetaMask.