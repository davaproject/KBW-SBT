// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ERC721, ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract SBT is ERC721URIStorage, Ownable {
    uint256 private _totalIssuedTokenAmount;
    uint256 private _totalBurntTokenAmount;

    constructor(string memory _name, string memory _symbol)
        ERC721(_name, _symbol)
    {}

    function mint(address _receiver, string calldata _tokenURI) external {
        _safeMint(_receiver, _totalIssuedTokenAmount);
        _setTokenURI(_totalIssuedTokenAmount, _tokenURI);
        _totalIssuedTokenAmount += 1;
    }

    function burn(uint256 _tokenId) external {
        require(
            _isApprovedOrOwner(_msgSender(), _tokenId),
            "Caller is not token owner nor approved"
        );
        _burn(_tokenId);
        _totalBurntTokenAmount += 1;
    }

    function totalIssuedTokens() public view returns (uint256) {
        return _totalIssuedTokenAmount;
    }

    function totalSupply() public view returns (uint256) {
        return _totalIssuedTokenAmount + _totalBurntTokenAmount;
    }

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
