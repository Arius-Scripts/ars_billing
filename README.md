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
```
ensure ars_billing
```
> Step 2
create item in ox inventory
ox_inventory/data/items.lua
``` 
['itemname'] = {
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

> PREVIEW

Player 1

![image](https://user-images.githubusercontent.com/70983185/206866313-8bf8c57d-c604-452b-8c6c-e15760d21f4b.png)

![image](https://user-images.githubusercontent.com/70983185/206866325-de4265fd-73a9-49b0-beae-bd28519d0a0d.png)

Player 2

![image](https://user-images.githubusercontent.com/70983185/206866334-d4ee447b-25ab-4a9f-913f-7b5445eff43a.png)

![image](https://user-images.githubusercontent.com/70983185/206866341-e583716b-3f15-423b-bcb6-0f2a1e8f8537.png)

![image](https://user-images.githubusercontent.com/70983185/206866346-3ea78a15-11d9-4e16-8875-d354b6bfb375.png)

![image](https://user-images.githubusercontent.com/70983185/206866350-f696a822-7d7d-45ce-8e78-c3468b83b3c7.png)

