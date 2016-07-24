//import "./oraclizeAPI.sol";

contract Mycontract{

    enum Hand { scissor, stone, bag }

    struct Player {
        address owner;
        Hand hand;
    }

    address public owner;
    uint public players;
    
    Player[2] users;
    event print(address);
    event print_int(uint);
    event print_str(string);
    event print_b(bytes32);
    
    function Mycontract()
    {

    }
    function play(address a,uint game)
    onlyAvailable()
    {
        users[players] = Player(a, Hand(game));
        players = players + 1;
        print_int(players);        

    }
    function findWinner()
    onyAllplayerPlayed()
    {
        if (users[0].hand == Hand.scissor && users[1].hand == Hand.bag){
            users[0].owner.send(1000000);
        } else if(users[0].hand == Hand.scissor && users[1].hand == Hand.stone){
            users[1].owner.send(1000000);
        } else if(users[0].hand == Hand.scissor && users[1].hand == Hand.scissor){
            print_str("DRAW");
        } else if(users[0].hand == Hand.stone && users[1].hand == Hand.scissor){
            users[0].owner.send(1000000);
        } else if(users[0].hand == Hand.stone && users[1].hand == Hand.bag){
            users[1].owner.send(1000000);
        } else if(users[0].hand == Hand.stone && users[1].hand == Hand.stone){
            print_str("DRAW");
        } else if(users[0].hand == Hand.bag && users[1].hand == Hand.stone){
            users[0].owner.send(1000000);
        } else if(users[0].hand == Hand.bag && users[1].hand == Hand.scissor){
            users[1].owner.send(1000000);
        } else if(users[0].hand == Hand.bag && users[1].hand == Hand.bag){
            print_str("DRAW");
        } else {
            throw;
        }
        
    }
    modifier onyAllplayerPlayed {
        if (players == 2) _
    }
    modifier onlyAvailable { 
        if (players < 2) _ 
        
    }
}