// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

//INTERNAL IMPORT FOR NFT OPENZIPLINE


import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters/sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

import "hardhat/console.sol";

contract DePixelPalette is ERC721URIStorage{
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;
    Counters.Counter private _itemSold;;

}