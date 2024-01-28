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

    //Let create "CREATE NFT TOKEN FUNCTION"

    function createToken(string memory tokenURI, Uint256 price ) public payable returns(uint256){
        _tokenIds.increment();

        uint256 newTokenId = _tokenIds.current();

        _mint(msg.sender, newTokenId);
        _setTokenURI(newTokenId, tokenURI);

        createMarketItem(newTokenId, price);
        return newTokenId;

    }

    //creating market item
    function createMarketItem(uint256 tokenId, uint256 price) private{
        require(price > 0, "Price must be at least 1");
        require(msg.value == listingPrice, "Price must be equal to listing price");

        idMarketItem[tokenId] = MarketItem(
            tokenId,
            payable(msg.sender),
            payable(address(this)),
            price,
            false
        );

        _transfer(msg.sender, address(this), tokenId);

        emit idMarketItemCreated(tokenId,
        msg.sender,
        address(this),
        price,
        false
        );
    }

    //function for RESALE TOKEN
    function reSellToken(uint256 tokenId, uint256 price) public payable{
        require(idToMarketItem[tokenId].owner == msg.sender, "Only item owner can perform this operation");
        
        require(msg.value == listingPrice, "Price must be equal to listing price");

        idMarketItem[tokenId].sold = false;
        idMarketItem[tokenId].price = price;
        idMarketItem[tokenId].seller = payable(msg.sender);
        idMarketItem[tokenId].owner = payable(address(this));

        _itemsSold.decrement();

        _transfer(msg.sender, address(this), tokenId);
    }

    //Function CREATEMARKETSALE
    function createMarketSale(uint256 tokenId) public payable{
        uint price = idMarketItem[tokenId].price;

        require(
            msg.value == price,
            "Please submit the asking price in order to complete the purchase"
        );

        idMarketItem[tokenId].owner = payable(msg.sender);
        idMarketItem[tokenId.sold = true;
        idMarketItem[tokenId].owner] = payable(address(0));

        _itemsSold.increment();

        _transfer(address(this), msg.sender, tokenId);

        payable()
    }
     
}