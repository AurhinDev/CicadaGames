pragma solidity >=0.5.0 <0.6.0;

import "../Tools/SolidityHelper.sol";
import "../Tools/Ownable.sol";
import "./Factory.sol";

contract Buildings is SolidityHelper, Ownable, Factory {

    mapping(address=>uint) barLevel;
    mapping(address=>uint) blacksmithLevel;
    mapping(address=>uint) arcanistLevel;
    mapping(address=>uint) madscientistLevel;
    mapping(address=>uint) hospitalLevel;
    mapping(address=>uint) arenaLevel;

    event BuildingLeveled(address indexed _from, bytes32 indexed _nameOfBuilding, uint _level);
    event CreatureHealed(address indexed _id, uint hitpoints);
    event CreatureLeveled(address indexed _from, bytes32 indexed _id, uint _value);

    SolidityHelper instanceHelper;
    Ownable instanceOwnable;
    Factory instanceFactory;

    //Requires Solidityhelper, Ownable and Factory contract.
    constructor(address _help, address _own, address _fact) public {
        instanceHelper = SolidityHelper(_help);
        instanceOwnable = Ownable(_own);
        instanceFactory = Factory(_fact);
    }
    function initLevels() internal {
        barLevel[msg.sender] = 1;
        blacksmithLevel[msg.sender] = 1;
        arcanistLevel[msg.sender] = 1;
        madscientistLevel[msg.sender] = 1;
        hospitalLevel[msg.sender] = 1;
        arenaLevel[msg.sender] = 1;
    }

    uint levelUpFee = 0.001 ether;
    uint MAX_LEVEL = 5;

    function withdraw() external onlyOwner {
        address _owner = owner();
        _owner.transfer(address(this).balance);
    }

    function setLevelUpFee(uint _fee) external onlyOwner {
        levelUpFee = _fee;
    }

    function levelUp(uint _creatureId, uint _buildingType) external payable {
        require(msg.value == levelUpFee, "Value not correct");
        if(_buildingType == 0) {
            require(barLevel[msg.sender] < MAX_LEVEL, "Already max level");
            barLevel[msg.sender] = barLevel[msg.sender].add(1);
            emit BuildingLeveled(msg.sender, "Bar", barLevel[msg.sender]);
        }
        if(_buildingType == 1) {
            require(blacksmithLevel[msg.sender] < MAX_LEVEL, "Already max level");
            blacksmithLevel[msg.sender] = blacksmithLevel[msg.sender].add(1);
            emit BuildingLeveled(msg.sender, "Blacksmith", blacksmithLevel[msg.sender]);
        }
        if(_buildingType == 2) {
            require(arcanistLevel[msg.sender] < MAX_LEVEL, "Already max level");
            arcanistLevel[msg.sender] = arcanistLevel[msg.sender].add(1);
            emit BuildingLeveled(msg.sender, "Arcanist", arcanistLevel[msg.sender]);
        }
        if(_buildingType == 3) {
            require(madscientistLevel[msg.sender] < MAX_LEVEL, "Already max level");
            madscientistLevel[msg.sender] = madscientistLevel[msg.sender].add(1);
            emit BuildingLeveled(msg.sender, "MadScientist", madscientistLevel[msg.sender]);
        }
        if(_buildingType == 4) {
            require(hospitalLevel[msg.sender] < MAX_LEVEL, "Already max level");
            hospitalLevel[msg.sender] = hospitalLevel[msg.sender].add(1);
            emit BuildingLeveled(msg.sender, "Hospital", hospitalLevel[msg.sender]);
        }
        if(_buildingType == 5) {
            require(arenaLevel[msg.sender] < MAX_LEVEL, "Already max level");
            arenaLevel[msg.sender] = arenaLevel[msg.sender].add(1);
            emit BuildingLeveled(msg.sender, "Arena", arenaLevel[msg.sender]);
        }
        else {
            revert("No building type matches parameter");
        }
    }

    //Bar functionality
    function recruitNewCreature() public {

    }

    //Blacksmith functionality
    function rerollEquipmentQuality() public {

    }

    //Arcanist functionality
    function rerollCreatureType() public {
    }

    //MadScientist functionality
    function cloneDefeatedCreature() public {

    }

    //Hospital functionality
    function healCreature(uint _creatureID) public {
        require(creatures[_creatureID].health > 0, "Creature is dead");
        if(creatures[_creatureID].health + hospitalLevel[msg.sender].mul(5) >= creatures[_creatureID].maxhealth){
            creatures[_creatureID].health = creatures[_creatureID].maxhealth;
        }
        else {
            creatures[_creatureID].health.Add(hospitalLevel[msg.sender].mul(5));
        }
        emit CreatureHealed(_creatureID, creatures[_creatureID].health);
    }

    //Arena functionality
    function fightMonster(uint _creatureID) public {

    }

}
