// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

interface IERC4973 {
    event Attest(address indexed to, uint256 indexed tokenId);
    event Revoke(address indexed to, uint256 indexed tokenId);

    function balanceOf(address owner) external view returns (uint256);

    function ownerOf(uint256 tokenId) external view returns (address);

    function burn(uint256 tokenId) external;
}
