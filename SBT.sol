// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ERC721, ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract SBT is ERC721URIStorage, Ownable {
    constructor(string memory _name, string memory _symbol)
        ERC721(_name, _symbol)
    {}

    function approve(address, uint256) public pure override {
        revert("Can not approve SBT");
    }

    function setApprovalForAll(address, bool) public pure override {
        revert("Can not approve SBT");
    }

    function _transfer(
        address,
        address,
        uint256
    ) internal pure override {
        revert("Can not transfer SBT");
    }
}
