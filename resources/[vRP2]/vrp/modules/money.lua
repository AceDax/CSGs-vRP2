if not vRP.modules.money then return end

local lang = vRP.lang

-- Money module, wallet/bank
local Money = class("Money", vRP.Extension)

-- SUBCLASS

Money.User = class("User")

-- get wallet amount
function Money.User:getWallet()
  return self.cdata.wallet
end

-- get debt amount
function Money.User:getDebt()
  return self.cdata.debt
end

-- get bank amount
function Money.User:getBank()
  return self.cdata.bank
end

-- set wallet amount
function Money.User:setWallet(amount)
  if self.cdata.wallet ~= amount then
    self.cdata.wallet = amount
    vRP:triggerEvent("playerMoneyUpdate", self)
  end
end

-- set debt amount
function Money.User:setDebt(amount)
  if self.cdata.debt ~= amount then
    self.cdata.debt = amount
    vRP:triggerEvent("playerMoneyUpdate", self)
  end
end

-- set bank amount
function Money.User:setBank(amount)
  if self.cdata.bank ~= amount then
    self.cdata.bank = amount
    vRP:triggerEvent("playerMoneyUpdate", self)
  end
end

-- give money to bank
function Money.User:giveBank(amount)
  self:setBank(self:getBank()+math.abs(amount))
end

-- give money to debt
function Money.User:giveDebt(amount)
  self:setDebt(self:getDebt()+math.abs(amount))
end

-- give money to wallet
function Money.User:giveWallet(amount)
  self:setWallet(self:getWallet()+math.abs(amount))
end

-- try a payment (with wallet)
-- dry: if passed/true, will not affect
-- return true if debited or false
function Money.User:tryPayment(amount, dry)
  local money = self:getWallet()
  if amount >= 0 and money >= amount then
    if not dry then
      self:setWallet(money-amount)
    end
    return true
  else
    return false
  end
end

-- try a withdraw (from bank)
-- dry: if passed/true, will not affect
-- return true if withdrawn or false
function Money.User:tryWithdraw(amount, dry)
  local money = self:getBank()
  if amount >= 0 and money >= amount then
    if not dry then
      self:setBank(money-amount)
      self:giveWallet(amount)
    end
    return true
  else
    return false
  end
end

--pay state debt
function Money.User:tryPaydebt(amount, dry)
  local debt = self:getDebt()
  if amount >= 0 and debt >= amount then
    if self:tryFullPayment(amount, dry) then
      if not dry then
        self:setDebt(debt-amount)
      end
      return true
    else
      return false
    end
  else
    return false
  end
end

-- try a deposit
-- dry: if passed/true, will not affect
-- return true if deposited or false
function Money.User:tryDeposit(amount, dry)
  if self:tryPayment(amount, dry) then
    if not dry then
      self:giveBank(amount)
    end
    return true
  else
    return false
  end
end

-- try full payment (wallet + bank to complete payment)
-- dry: if passed/true, will not affect
-- return true if debited or false
function Money.User:tryFullPayment(amount, dry)
  local money = self:getWallet()
  if money >= amount then -- enough, simple payment
    return self:tryPayment(amount, dry)
  else  -- not enough, withdraw -> payment
    if self:tryWithdraw(amount-money, dry) then -- withdraw to complete amount
      return self:tryPayment(amount, dry)
    end
  end

  return false
end

-- PRIVATE METHODS

local function define_items(self)
  local function m_money_unpack(menu)
    local user = menu.user
    local fullid = menu.data.fullid

    local amount = user:getItemAmount(fullid)
    local ramount = parseInt(user:prompt(lang.item.money.unpack.prompt({amount}), ""))
    if user:tryTakeItem(fullid, ramount) then -- unpack the money
      user:giveWallet(ramount)

      if ramount == amount then
        user:closeMenu(menu)
      else
        user:actualizeMenu()
      end
    end
  end

  local function i_money_menu(args, menu)
    menu:addOption(lang.item.money.unpack.title(), m_money_unpack)
  end

  local function m_money_binder_bind(menu)
    local user = menu.user
    local fullid = menu.data.fullid

    if user:tryTakeItem(fullid, 1, true) and user:tryPayment(1000, true) and user:tryGiveItem("money", 1000, true) then
      user:tryTakeItem(fullid, 1)
      user:tryPayment(1000)
      user:tryGiveItem("money", 1000)

      local namount = user:getItemAmount(fullid)
      if namount > 0 then
        user:actualizeMenu()
      else
        user:closeMenu(menu)
      end
    else
      vRP.EXT.Base.remote._notify(user.source, lang.money.not_enough())
    end
  end

  local function i_money_binder_menu(args, menu)
    menu:addOption(lang.item.money_binder.bind.title(), m_money_binder_bind)
  end

  -- vRP.EXT.Inventory:defineItem("money", lang.item.money.name(), lang.item.money.description(), i_money_menu, 0)
  -- vRP.EXT.Inventory:defineItem("money_binder", lang.item.money_binder.name(), lang.item.money_binder.description(), i_money_binder_menu, 0)
end

function Money:unPack(source, amount)
  local user = vRP.users_by_source[source]
  if amount <= 10000 and amount > 999 then
    if user:tryTakeItem("money", amount) then
      user:giveWallet(amount)
      vRP.EXT.Base.remote._notify(user.source, "Recieved ~g~$"..amount)

      if amount == amount then
        TriggerClientEvent("inventoryHud:closeMenu", user.source)
      end
    end
  else
    TriggerClientEvent("inventoryHud:closeMenu", user.source)
    vRP.EXT.Base.remote._notify(user.source, "~r~Failed to Un-Bind Money~w~: Minimum is ~g~$1,000 ~w~& Maximum is ~g~$10,000")
  end
end

local function roundToFirstDecimal(t)
  return math.round(t*10)*0.1
end

function Money:bindMoney(source, amount)
  local user = vRP.users_by_source[source]
  local binder = math.ceil(amount*100/100000)
  if amount <= 10000 and amount > 999 then
    if user:tryTakeItem("money_binder", binder, true) then
      if user:tryPayment(amount, true) and user:tryGiveItem("money", amount, true) then
        user:tryTakeItem("money_binder", binder)
        user:tryPayment(amount)
        user:tryGiveItem("money", amount)
        local namount = user:getItemAmount("money_binder")

        if namount > 0 then
          TriggerClientEvent("inventoryHud:closeMenu", user.source)
        end
      else
        TriggerClientEvent("inventoryHud:closeMenu", user.source)
        vRP.EXT.Base.remote._notify(user.source, lang.money.not_enough())
      end
    else
      TriggerClientEvent("inventoryHud:closeMenu", user.source)
      vRP.EXT.Base.remote._notify(user.source, "~r~~r~Not enough binders. ~y~One Binder is required every $1,000")
    end					
  else
    TriggerClientEvent("inventoryHud:closeMenu", user.source)
   vRP.EXT.Base.remote._notify(user.source, "~r~Failed to Bind Money~w~: Minimum is ~g~$1,000 ~w~& Maximum is ~g~$10,000")
  end
end

-- menu: admin users user
local function menu_admin_users_user(self)
  local function m_givemoney(menu)
    local user = menu.user
    local tuser = vRP.users[menu.data.id]

    if tuser then
      local amount = parseInt(user:prompt(lang.admin.users.user.give_money.prompt(),""))
      tuser:giveWallet(amount)
    end
  end

  vRP.EXT.GUI:registerMenuBuilder("admin.users.user", function(menu)
    local user = menu.user
    local tuser = vRP.users[menu.data.id]

    if tuser then
      if user:hasPermission("player.givemoney") then
        menu:addOption(lang.admin.users.user.give_money.title(), m_givemoney)
      end
    end
  end)
end

-- METHODS

function Money:__construct()
  vRP.Extension.__construct(self)

  self.cfg = module("cfg/money")

  -- items
  define_items(self)

  -- menu
  menu_admin_users_user(self)

  -- main menu

  local function m_give(menu)
    local user = menu.user
    local nuser
    local nplayer = vRP.EXT.Base.remote.getNearestPlayer(user.source,10)
    if nplayer then nuser = vRP.users_by_source[nplayer] end

    if nuser then
      -- prompt number
      local amount = parseInt(user:prompt(lang.money.give.prompt(),""))
      if amount > 0 and user:tryPayment(amount) then
        nuser:giveWallet(amount)
        vRP.EXT.Base.remote._notify(user.source,lang.money.given({amount}))
        vRP.EXT.Base.remote._notify(nuser.source,lang.money.received({amount}))
      else
        vRP.EXT.Base.remote._notify(user.source,lang.money.not_enough())
      end
    else
      vRP.EXT.Base.remote._notify(user.source,lang.common.no_player_near())
    end
  end

  -- add give money to main menu
  vRP.EXT.GUI:registerMenuBuilder("main", function(menu)
    menu:addOption(lang.money.give.title(), m_give, lang.money.give.description())
  end)

  -- transformer processor

  vRP.EXT.Transformer:registerProcessor("money", function(user, reagents, products) -- on display
    local r_info, p_info = "", ""

    if reagents then
      if reagents > 0 then r_info = r_info..lang.money.transformer_recipe({reagents}) end
    end

    if products then
      if products > 0 then p_info = p_info..lang.money.transformer_recipe({products}) end
    end

    return r_info, p_info
  end, function(user, reagents, products) -- on check
    local ok = true

    if reagents then
      ok = (reagents > 0 and user:getWallet() >= reagents)

      if not ok then
        vRP.EXT.Base.remote._notify(user.source, lang.money.not_enough())
      end
    end

    return ok
  end, function(user, reagents, products) -- on process
    if reagents then
      if reagents > 0 then user:tryPayment(reagents) end
    end

    if products then
      if products > 0 then user:giveWallet(products) end
    end
  end)
end

-- EVENT
Money.event = {}

function Money.event:characterLoad(user)
  -- init character money

  if not user.cdata.wallet then
    user.cdata.wallet = self.cfg.open_wallet
  end

  if not user.cdata.bank then
    user.cdata.bank = self.cfg.open_bank
  end

  if not user.cdata.debt then
    user.cdata.debt = self.cfg.open_debt
  end

  vRP:triggerEvent("playerMoneyUpdate", user)
end

function Money.event:comma_value(n) -- credit http://richard.warburton.it
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end

function Money.event:playerSpawn(user, first_spawn)
  -- add money display
  if self.cfg.money_display and first_spawn then
    vRP.EXT.GUI.remote._setDiv(user.source,"money",self.cfg.display_css,lang.money.display({Money.event:comma_value(user:getWallet())}))
	vRP.EXT.GUI.remote._setDiv(user.source,"bmoney",self.cfg.display_css,lang.money.display({Money.event:comma_value(user:getBank())})) --Bank display, comment if you don't need this
  end
end

function Money.event:playerDeath(user)
  if self.cfg.lose_wallet_on_death then
    user:setWallet(0)
  end
end

function Money.event:playerMoneyUpdate(user)
  if self.cfg.money_display then
    -- update money
    vRP.EXT.GUI.remote._setDivContent(user.source,"money",lang.money.display({Money.event:comma_value(user:getWallet())}))
	vRP.EXT.GUI.remote._setDivContent(user.source,"bmoney",lang.money.display({Money.event:comma_value(user:getBank())})) --Bank display, comment if you don't need this
  end
end

vRP:registerExtension(Money)
