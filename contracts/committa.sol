pragma solidity ^0.8.0;

contract Commita {
  mapping(uint256 => address) public positions;
  mapping(uint256 => uint256[]) public ancestors;
  mapping(uint256 => uint256[]) public descendants;
  uint256 public totalPositions;

  constructor() {
    totalPositions = 1;
  }

  function addPosition(address owner) public {
    require(positions[totalPositions] == address(0), "Position already exists");
    positions[totalPositions] = owner;
    if(totalPositions > 1) {
      ancestors[totalPositions] = [totalPositions - 1];
      descendants[totalPositions - 1].push(totalPositions);
    } else {
      ancestors[totalPositions] = new uint256[](0);
    }
    descendants[totalPositions] = new uint256[](0);
    totalPositions++;
  }

  function getOwner(uint256 position) public view returns (address) {
    require(positions[position] != address(0), "Position does not exist");
    return positions[position];
  }

  function getAncestors(uint256 position) public view returns (uint256[] memory ) {
    require(positions[position] != address(0), "Position does not exist");
    return ancestors[position];
  }

  function getDescendants(uint256 position) public view returns (uint256[] memory ) {
    require(positions[position] != address(0), "Position does not exist");
    return descendants[position];
  }

  function removePosition(uint256 position) public {
    require(positions[position] != address(0), "Position does not exist");
    require(positions[position] == msg.sender, "Caller is not the owner of this position");
    positions[position] = address(0);
    
    for (uint256 i = 0; i < ancestors[position].length; i++) {
      uint256[] storage desc = descendants[ancestors[position][i]];
      for(uint j = 0; j < desc.length; j++){
        if(desc[j] == position){
          desc[j] = desc[desc.length - 1];
          desc.pop();
          break;
        }
      }
    }

    for (uint256 i = 0; i < descendants[position].length; i++) {
      uint256[] storage anc = ancestors[descendants[position][i]];
      for(uint j = 0; j < anc.length; j++){
        if(anc[j] == position){
          anc[j] = anc[anc.length - 1];
          anc.pop();
          break;
        }
      }
    }

    totalPositions--;
  }
}
