import "sorter.sol";
import "oraclizeAPI.sol";
import "strings.sol";

contract Lotto is usingOraclize{
    using strings for *;
    address owner;
    uint min_bet = 100;//finney ~ 0.00005BTC ~ 1USD
    uint smallest_number = 1;
    uint largest_number = 36;
    uint total_number = 7;
    uint delay = 1;//1209600 //2weeks
    uint[] temp;
    uint[] lotto_number;  
    mapping (bytes32 => address) private balances;
    Sorter sort;
    
    event print(uint);
    event print_addr(address);
    event print_str(string);
    event print_b(bytes32);
    event present_winner(address, uint);

    function Lotto()
    {
        owner = msg.sender;
        sort = Sorter(0xe0dccf67776caf8801dd1ac3ce5969111d74c6e0);
    }
    function configure(uint _m, uint _s, uint _l, uint _t, uint _d)
    ownerOnly
    {
        min_bet = _m;
        smallest_number = _s;
        largest_number = _l;
        total_number = _t;
        delay = _d;
    }
    function start_round()
    {
        oraclize_query(delay, "URL", "https://www.random.org/integers/?num=7&min=1&max=32&col=1&base=10&format=plain&rnd=new");
    }
    function __callback(bytes32 myid, string result)
    {
        print_str("__callback");
        if (msg.sender != oraclize_cbAddress()) throw;

        var s = result.toSlice();
        var delim = " ".toSlice();
        var len = s.count(delim) + 1;
        for(uint i = 0; i < len; i++) {
            lotto_number.push(parseInt(s.split(delim).toString()));
        }

        sort.set(lotto_number);
        sort.sort();

        for (uint j=0;j<lotto_number.length;j++){
            lotto_number[j] = sort.data(j);
        }
        bytes32 hash = sha3(lotto_number);

        if ( balances[hash] != 0){
            present_winner(balances[hash], this.balance);
            if (!balances[hash].send(this.balance)){
                throw;
            }
        } else { //No winner
            print_str("No winner");
            print_addr(balances[hash]);
            start_round();
        }
    }
    function pickWinner()
    {
        print_str("pickWinner");
    }
    function bet(uint[] num)
    checkData(msg.value, num)
    {
        print(msg.value);
        print_addr(msg.sender);
        print(now);
        print(now + 4 weeks);
        
        temp = num;

        sort.set(temp);
        sort.sort();

        for (uint i=0;i<temp.length;i++){
            print(sort.data(i));
            temp[i] = sort.data(i);
        }

        bytes32 hash = sha3(temp);
        balances[hash] = msg.sender;
    }
    modifier ownerOnly(){
        if (msg.sender != owner)
            throw;
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