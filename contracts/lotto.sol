


contract Lotto{
    address owner;
    uint min_bet = 100;
    uint smallest_number = 1;
    uint largest_number = 36;
    uint total_number = 7;

    struct Better{
        uint number_of_bets;
         uint[][7] lotto_numbers;
    }
    
    mapping (address => Better) private balances;
    
    event print(uint);
    event print_addr(address);
    event print_str(string);

    function Lotto()
    {
        //bytes32 myid = oraclize_query("URL", "https://www.random.org/integers/?num=7&min=1&max=32&col=1&base=10&format=plain&rnd=new");
        
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
        Better b = balances[msg.sender];
  
        b.lotto_numbers[b.number_of_bets] = num;
        b.number_of_bets = b.number_of_bets + 1;
        print(b.number_of_bets);
        balances[msg.sender] = b;

        
    }
    function print_data()
    {
        Better b = balances[msg.sender];
        
        for (uint j = 0;j < b.number_of_bets;j++){
            for(uint i = 0;i < b.lotto_numbers[j].length; i++){
                print(b.lotto_numbers[j][i]);
            }
        }
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