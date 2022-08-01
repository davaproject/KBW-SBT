// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IERC721Metadata, ERC721, ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {IERC165} from "@openzeppelin/contracts/utils/introspection/IERC165.sol";
import {Operable} from "./Operable.sol";
import {ERC5192} from "./ERC5192/ERC5192.sol";

contract SBT is ERC5192, ERC721URIStorage, Ownable, Operable {
    uint256 private _totalIssuedTokenAmount;
    uint256 private _totalBurntTokenAmount;

    event Attest(address indexed to, uint256 indexed tokenId);
    event Revoke(address indexed to, uint256 indexed tokenId);

    constructor(string memory _name, string memory _symbol)
        ERC721(_name, _symbol)
    {}

    function mint(address _receiver, string calldata _tokenURI)
        external
        onlyOperator
    {
        _safeMint(_receiver, _totalIssuedTokenAmount);
        _setTokenURI(_totalIssuedTokenAmount, _tokenURI);
        emit Attest(_receiver, _totalIssuedTokenAmount);

        _totalIssuedTokenAmount += 1;
    }

    function burn(uint256 _tokenId) external {
        require(
            _isApprovedOrOwner(_msgSender(), _tokenId),
            "Caller is not token owner nor approved"
        );
        _burn(_tokenId);
        emit Revoke(_msgSender(), _tokenId);

        _totalBurntTokenAmount += 1;
    }

    function locked(uint256 tokenId) external view override returns (bool) {
        require(_exists(tokenId), "ERC5192: token does not exists");
        return true;
    }

    function totalIssuedTokens() public view returns (uint256) {
        return _totalIssuedTokenAmount;
    }

    function totalSupply() public view returns (uint256) {
        return _totalIssuedTokenAmount + _totalBurntTokenAmount;
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC5192)
        returns (bool)
    {
        return
            interfaceId == type(IERC721Metadata).interfaceId ||
            interfaceId == type(IERC165).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return ERC721URIStorage.tokenURI(tokenId);
    }

    function approve(address, uint256) public pure override {
        revert("Can not approve SBT");
    }

    function setApprovalForAll(address, bool) public pure override {
        revert("Can not approve SBT");
    }

    function _burn(uint256 tokenId)
        internal
        virtual
        override(ERC721, ERC721URIStorage)
    {
        ERC721URIStorage._burn(tokenId);
    }

    function _transfer(
        address,
        address,
        uint256
    ) internal pure override {
        revert("Can not transfer SBT");
    }

    /**
        @dev Operable Role
     */
    function grantOperatorRole(address _candidate) external onlyOwner {
        _grantOperatorRole(_candidate);
    }

    function revokeOperatorRole(address _candidate) external onlyOwner {
        _grantOperatorRole(_candidate);
    }
}
