import "sorter.sol";

contract Lotto{
    address owner;
    uint min_bet = 100;
    uint smallest_number = 1;
    uint largest_number = 36;
    uint total_number = 7;

    uint[] temp;
    
    mapping (bytes32 => address) private balances;
    
    event print(uint);
    event print_addr(address);
    event print_str(string);
    event print_b(bytes32);

    function Lotto()
    {
        //bytes32 myid = oraclize_query("URL", "https://wwww.random.org/integers/?num=7&min=1&max=32&col=1&base=10&format=plain&rnd=new");
        
        //http://docs.ethereum-alarm-clock.com/en/latest/scheduling.html#call-data
        //bytes4 sig = bytes4(sha3("pickWinner()"));
        //uint targetBlock = block.number + 5760;
        //bytes4 scheduleCallSig = bytes4(sha3("scheduleCall(bytes4,uint256)"));
        //scheduler.call(scheduleCallSig, sig, targetBlock)
    }
    function pickWinner()
    {
        
    }
    function bet(uint[] num)
    checkData(msg.value, num)
    {
        print(msg.value);
        print_addr(msg.sender);
        print(now);
        print(now + 4 weeks);
        
        temp = num;
        Sorter s = Sorter(0xdf315f7485c3a86eb692487588735f224482abe3);
        s.set(temp);
        s.sort();

        for (uint i=0;i<temp.length;i++){
            print(s.data(i));
            temp[i] = s.data(i);
        }

        bytes32 hash = sha3(temp);
        balances[hash] = msg.sender;

    }
    modifier checkData(uint value, uint[] numbers){
        if (value != min_bet){
            throw;
        }
        if (numbers.length != total_number){
            throw;
        }
        if (numbers.length > 15){
            throw;
        }
        for(uint i = 0;i < numbers.length; i++){
            print(numbers[i]);
            if (numbers[i] < smallest_number || numbers[i] > largest_number){
                throw;
            }
        }
        _
    }
    function(){
        throw;
    }
}