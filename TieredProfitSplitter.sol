pragma solidity ^0.5.0;

// lvl 2: tiered split
contract TieredProfitSplitter {
    address payable employee_one;
    address payable employee_two;
    address payable employee_three;

    constructor(address payable _one, address payable _two, address payable _three) public {
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;
    }

    function balance() public view returns(uint) {
        require(address(this).balance == 0, "*****Deposit Function Malfunction!*****");
    }


    function deposit() public payable {
        uint points = msg.value / 100; 
        uint total;
        uint amount;
        
        // points per employee
        uint one_points = points * 60;
        uint two_points = points * 25;
        uint three_points = points * 15;
        
        // amounts per employee + total calculation 
        uint one_amount = amount*one_points;
        total += one_amount;
        uint two_amount = amount*two_points;
        total += two_amount;
        uint three_amount = amount*three_points;
        total += three_amount;

        // transfer to employee accounts 
        employee_one.transfer(one_amount);
        employee_two.transfer(two_amount);
        employee_three.transfer(three_amount);


        employee_one.transfer(msg.value - total); // ceo gets the remaining wei
    }

    function() external payable {
        deposit();
    }
}
