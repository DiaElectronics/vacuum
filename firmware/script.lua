-- Vacuum Cleaner Firmware

-- setup is called once
-- mode
-- 1 = NO MONEY
-- 2 = SOME_MONEY_NOT STARTED
-- 3 = STARTED_AND_WORKING
-- 4 = THANKS

setup = function()
    version="0.1"
    price_per_minute = 10.0
    -- thanks screen visible interval in seconds
    thanks_time = 20
    balance = 0.0
    balance_int = 0
    mode = 1
    
    -- this is about buttons
    turn_light(1, animation.stop)
    
    -- turn off all activators
    run_program(program.stop)
    printMessage("Vacuum Cleaner Sample v." .. version)
    return 0
end

-- loop is being executed
loop = function()
    mode = run_mode(mode)
    return 0;
end

run_mode = function(new_mode)
    if new_mode == 1 then return welcome_mode() end
    if new_mode == 2 then return moremoney_mode() end
    if new_mode == 3 then return working_mode() end
    if new_mode == 4 then return thanks_mode() end
end

get_key = function()
    return hardware:GetKey()
end

welcome_mode = function()
    welcome:Display()
    turn_light(1, animation.stop)
    run_program(program.stop)

    update_balance()
    if(balance > 0.99) then return 2 end
    smart_delay(100)
    return 1
end

moremoney_mode = function()
    turn_light(1, animation.one_button)
    run_program(program.stop)

    update_balance()
    balance_int = math.ceil(balance)
    moremoney:Set("balance.value", balance_int)
    moremoney:Display()
    key = get_key()
    if(key == 1) then return 3 end
    smart_delay(100)

    return 2
end

working_mode = function()
    turn_light(1, animation.one_button)
    run_program(program.run)

    update_balance()
    balance_int = math.ceil(balance)
    working:Set("balance.value", balance_int)
    working:Display()
    if balance < 0.01 then
        balance = 0
        return 4
    end
    smart_delay(100)
    balance = balance - (price_per_minute * 0.00166667)

    return 3
end

thanks_mode = function()
    thanks:Display()
    turn_light(1, animation.stop)
    run_program(program.stop)
    waiting_loops = thanks_time * 10;
    while(waiting_loops>0)
    do
        update_balance()
        if balance > 0.99 then return 2 end
        smart_delay(100)
        waiting_loops = waiting_loops - 1
    end

    return 1
end

smart_delay = function(ms)
    hardware:SmartDelay(ms)
end

update_balance = function()
    balance=balance + hardware:GetCoins()
    balance=balance + hardware:GetBanknotes()
end

turn_light = function(rel_num, animation_code)
    hardware:TurnLight(rel_num, animation_code)
end

run_program = function(program_num)
    hardware:TurnProgram(program_num)
end
