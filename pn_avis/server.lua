local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","pn_avis")

RegisterServerEvent('pn_avis:CheckMoney')
AddEventHandler('pn_avis:CheckMoney', function()
    local source = source
    local user_id = vRP.getUserId({source})
			if vRP.tryFullPayment({user_id,100}) then	
				TriggerClientEvent('pn_avis:Animation', source)
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Tager Avis...'}, 5000)
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Du har ikke råd til at købe en Avis!'}, 5000)
			end
		end)

RegisterServerEvent('pn_avis:KobAvis')
AddEventHandler('pn_avis:KobAvis', function()
    local source = source
    local user_id = vRP.getUserId({source})
	vRP.giveInventoryItem({user_id,"pn_avis",1,false})
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Du købte en Avis!'}, 5000)
end)

vRP.defInventoryItem({"pn_avis","PN Avis","Du er satme Kinky!", function()
	
	local choices = {}
	
	choices["> Brug"] = {function(source,choice,mod)
		local source = source
		local user_id = vRP.getUserId({source})
        if user_id ~= nil then
			TriggerClientEvent("pn_avis:Use", source)
            vRP.closeMenu({source})
        else
		end
	end}

	return choices
end, 0.50})