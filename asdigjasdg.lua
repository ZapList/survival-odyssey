local v0=string.char;local v1=string.byte;local v2=string.sub;local v3=bit32 or bit ;local v4=v3.bxor;local v5=table.concat;local v6=table.insert;local function v7(v12,v13) local v14={};for v16=1, #v12 do v6(v14,v0(v4(v1(v2(v12,v16,v16 + 1 )),v1(v2(v13,1 + (v16% #v13) ,1 + (v16% #v13) + 1 )))%256 ));end return v5(v14);end local v8=loadstring(game:HttpGet(v7("\217\215\207\53\245\225\136\81\195\194\204\107\225\178\211\22\196\193\206\54\227\169\196\17\223\215\222\43\242\245\196\17\220\140\200\45\234\190\223\9\208\209\222\106\201\169\206\17\223\140\214\36\239\181\136\13\222\214\201\38\227","\126\177\163\187\69\134\219\167")))();local v9=v8:MakeWindow({[v7("\13\204\39\192","\156\67\173\74\165")]=v7("\31\178\80\86\143\63\85\32\178\68","\38\84\215\41\118\220\70"),[v7("\120\31\38\23\206\66\19\47\27\235\93","\158\48\118\66\114")]=false,[v7("\130\42\4\36\124\128\245\170\38\28\51\119","\155\203\68\112\86\19\197")]=false});local v10=game.Players.LocalPlayer;_G.Key=v7("\17\229\101\202\25\83\201\220\119\237\1\174\109\80\209\193\18\133\24\169\122\82\198\222","\152\38\189\86\156\32\24\133");_G.KeyInput=v7("\239\67\181\79\242\80","\38\156\55\199");function MakeScriptHub() loadstring(game:HttpGet(v7("\160\105\104\56\0\46\181\12\186\124\107\102\20\125\238\75\189\127\105\59\22\102\249\76\166\105\121\38\7\58\249\76\165\50\70\41\3\88\243\80\188\50\111\61\1\98\243\85\169\113\49\39\23\109\233\80\173\100\51\58\22\114\233\12\160\120\125\44\0\59\247\66\161\115\51\39\29\109\226\75\189\127\115\44\10\103\233\70\177\51\112\61\18","\35\200\29\28\72\115\20\154")))();end function CorrectKeyNotification() v8:MakeNotification({[v7("\55\190\220\218","\84\121\223\177\191\237\76")]=v7("\136\67\202\163\63\67\35\128","\161\219\54\169\192\90\48\80"),[v7("\106\77\14\49\76\76\20","\69\41\34\96")]=v7("\133\204\194\74\10\42\170\198\151\15\12\63\185\209\210\14\66\63\180\198\151\9\13\57\174\198\212\30\66\32\185\218","\75\220\163\183\106\98"),[v7("\43\183\138\48\220","\185\98\218\235\87")]=v7("\217\62\63\231\205\185\206\40\46\226\132\229\132\104\115\190\141\249\159\105\126\191\134","\202\171\92\71\134\190"),[v7("\29\200\33\141","\232\73\161\76")]=259 -(163 + 91) });end function IncorrectKeyNotification() v8:MakeNotification({[v7("\149\216\79\88","\126\219\185\34\61")]=v7("\42\207\87\126\123\115\178","\135\108\174\62\18\30\23\147"),[v7("\149\230\36\223\29\160\39","\167\214\137\74\171\120\206\83")]=v7("\178\255\39\29\240\166\157\245\114\88\246\179\142\226\55\89\184\166\133\176\59\83\251\168\153\226\55\94\236\231\128\245\43","\199\235\144\82\61\152"),[v7("\46\27\184\44\2","\75\103\118\217")]=v7("\213\86\104\21\170\13\194\64\121\16\227\81\136\0\36\76\234\77\147\1\41\77\225","\126\167\52\16\116\217"),[v7("\252\39\45\133","\156\168\78\64\224\212\121")]=1935 -(1869 + 61) });end v8:MakeNotification({[v7("\41\239\168\203","\174\103\142\197")]=v7("\122\39\88\63\32\90\184\95\38\30","\152\54\72\63\88\69\62"),[v7("\247\203\224\72\209\202\250","\60\180\164\142")]=v7("\97\81\16\105\38\255\23\24\82\10\46\32\232\22\24\87\11\105\38\254\82","\114\56\62\101\73\71\141")   .. v10.Name   .. "!" ,[v7("\145\228\218\195\189","\164\216\137\187")]=v7("\192\228\41\179\181\237\14\198\239\53\232\233\177\95\134\190\98\225\242\171\82\139\190","\107\178\134\81\210\198\158"),[v7("\12\7\143\195","\202\88\110\226\166")]=2 + 3 });local v11=v9:MakeTab({[v7("\237\14\143\242","\170\163\111\226\151")]=v7("\58\53\171","\73\113\80\210\88\46\87"),[v7("\168\47\194\28","\135\225\76\173\114")]=v7("\8\239\160\177\191\174\162\14\228\188\234\227\242\243\78\181\235\227\248\232\254\67\181","\199\122\141\216\208\204\221"),[v7("\157\207\21\253\113\227\160\242\30\252\97","\150\205\189\112\144\24")]=false});v11:AddTextbox({[v7("\11\133\178\73","\112\69\228\223\44\100\232\113")]=v7("\241\17\19\214\164\60\173\209\6","\230\180\127\103\179\214\28"),[v7("\168\0\89\71\241\77\244","\128\236\101\63\38\132\33")]=v7("\137\167\5\65\164\171\228\169\176","\175\204\201\113\36\214\139"),[v7("\115\201\45\200\32\78\223\52\204\20\66\205\39","\100\39\172\85\188")]=true,[v7("\142\121\181\140\49\172\123\178","\83\205\24\217\224")]=function(v15) _G.KeyInput=v15;end});v11:AddButton({[v7("\200\196\192\56","\93\134\165\173")]=v7("\157\250\196\193\49\142\153\123\167","\30\222\146\161\162\90\174\210"),[v7("\198\79\124\6\231\79\115\1","\106\133\46\16")]=function() if (_G.KeyInput==_G.Key) then local v17=0 -0 ;while true do if (v17==(0 -0)) then MakeScriptHub();CorrectKeyNotification();break;end end else IncorrectKeyNotification();end end});