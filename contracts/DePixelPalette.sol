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
    Counters.Counter private _itemsSold;

    uint256 listingPrice = 0.0015 ether;
    address payable owner;

    mapping(unit256 => MarketItem) private idMarketItem;

    struct MarketItem{
        uint256 tokenId;
        address payable seller;
        address payable owner;
        uint256 price;
        bool sold;
    }

    event idMarketItemCreated(
        uint256 indexed tokenId,
        address seller,
        address owner,
        uint256 price,
        bool sold
    );

    modifier onlyOwner{
        require(msg.sender == owner,
        "only owner of the marketplace can change the listing price"
        );
        
    }
    constructor() ERC721("NFT Metavarse Token", "MYNFT"){
        owner == payable(msg.sender);
    }

    function updateListingPrice(uint256 _ListingPrice) 
    public
    payable
    onlyOwner
    {
       listingPrice = _listingPrice
    }


    function getListingPrice() public view returns (uint256){
        return listingPrice;
    }

}