# ars_billing
[ESX][OX] Item based billing system

**FREATURES**
- discord logs
- open source
- resmon 0.0
- item based
-  easy configuration

**INTALATION**

> Step 1
insert ensure ars_billing in your server.cfg
```ensure ars_billing ```
> Step 2
create item in ox inventory
ox_inventory/data/items.lua
``` 	['itemname'] = {
		label = 'Item label',
		weight = 1,
		stack = true,
		close = true,
		description = nil,
	}, 
```
> Step 3 
ox_inventory/modules/items/client.lua
```
Item('itemname', function(data, slot)
	exports.ars_billing:useBillingItem(data)
end)
```
and you are done!


preview on forums
