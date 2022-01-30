// contracts/NFT.sol
// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity ^0.8.3;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";

import "hardhat/console.sol";

contract NFT is Initializable, ERC721URIStorageUpgradeable {
    using CountersUpgradeable for CountersUpgradeable.Counter;
    CountersUpgradeable.Counter private _tokenIds;
    address contractAddress;

    function initialize(address marketplaceAddress) initializer public {
      __ERC721_init("Metaverse Tokens", "METT");
        contractAddress = marketplaceAddress;
    }
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() initializer {}

    // constructor(address marketplaceAddress) ERC721("Metaverse Tokens", "METT") {
    //     contractAddress = marketplaceAddress;
    // }

    function createToken(string memory tokenURI) public returns (uint) {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();

        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);
        setApprovalForAll(contractAddress, true);
        return newItemId;
    }
}