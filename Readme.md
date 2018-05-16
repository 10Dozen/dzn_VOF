## dzn Vehicle On Fire

#### Requirement: CBA_A3
#### Version: 4

CRs:
- [+] Update Settings with: Chance of Burn per hit
- [+] Update Settings with: Burning start time
- [+] Update Settings with: Burning time
- [+] Update Settings with: Quick apply to classes
- [+] Update Settings with: Custom whitelist and blacklist
- [+] Update Settings with: Custom ACE-cookoff whitelist and blacklist
- Update Settings with: Planes/Helicopters massive flame option
- [+] Update Settings with: Planes/Helicopters prevent engine destruction chance
- [+] Update Settings with: Land vehicle prevent engine destruction chance
- Combine ACE Cookoff and VOF behaviors: Hit engine/fuel -> fire started -> before sequence ends, if tank/ifv has 25mm+ ammo on board - cookoff is triggered and ka-boom; if not - ammunition cookoff started for few seconds and then vehicle burns down (then ace handled ammo cookoff starts on wreck, so it may be too heavy as both will be executed same time)
- Add logic for Chance of Burn per hit
- Add logic for Burning start time
- Add logic for Burning time
- Add logic for Planes/Helicopters massive flame option
- Add logic for Planes/Helicopters prevent engine destruction chance
- Add logic for Land vehicle prevent engine destruction chance

#### Notes:
Engine selections names: motor, engine_1_hit, engine_2_hit, engine_hit
Fuel: fuel_hit
Engine hitpoint selections: hitengine1, hitengine2, hitengine
Fuel hitpoint: hitfuel




<br /><br /><br /><br /><hr />
#### Description
#### Requirement: CBA_A3

Mod prevents APCs (and any other vehicles that can be configured in mod's settings) from instant destruction in the fireball and adds vehicle fire instead, that burns vehicle after some time
The mod is partially compatible with ACE Cookoff (remove cookoff behavior from vehicles that burns) and ACE Medical modules; the mod is configured to be compatible with vehicles of APC class from RHS AFRF, RHS USAF and CUP Vehicles.

Features:
- Prevents vehicle instant explosion and adds engine fire after engine/fuel critical hit
- Adds smoke effect, notification and damage to crew when vehicle is on fire
- Disables ACE-cookoff for APC vehicles with MG only (e.g. BRDM/BTR w.KPVT)
- All vehicle parts can be dammaged/destroyed (turrets, wheels, etc.); massive damage immobilize vehicle instead of exploding it (pretending that transmission, wheel axes and other not simulated stuff become broken or destroyed)

Usage:
- Install the mod to your client OR dedicated server only
- Check mod settings in the ((Settings -> Addon Options -> dzn Vehicle On Fire))
- (optional) update the list of the classes that should NOT cook-off/explode, but burn in the "Non-cooking off vehicles" in format [@Classname, @DamageLimit], where @Classname is a class of vehicle or it's parent, and @DamageLimit is number of damage that vehicle can take before immobilization; you can define any vehicle class or even root classes like Car
- (optional) update the list of the classes that are sub-classes of "Non-cooking off vehicles", but should cook-off (e.g. BTR-82A) in the "Cooking off vehicles"
- Start the game and have fun!

License: APL-SA

Credits:
Developed by 10Dozen
Tested by Tactical Shift Arma 3 community (wow, much thanks, such appreciate)

ОПИСАНИЕ НА РУССКОМ ЯЗЫКЕ
Мод заменяет классический взрыв техники после нанесения большого урон на кратковременный пожар, который сжигает технику до полного уничтожения (позволяя продолжить использование не уничтоженных турелей и имея доступ к инвентарю техники).
Мод частично совместим с ACE Cookoff (отменяет кукоф для той техники, которая должна гореть) и ACE Medical модулями ; мод имеет преднастройку для классов машин типа БТР из модов RHS AFRF, RHS USAF и CUP Vehicles.

Фичи:
- Предотвращает мгновенный взрыв и добавляет эффект пожара двигателя/топлива при критическом повреждении
- Эффект задымления для экипажа и повреждения тем, кто слишком долго сидит внутри горящей техники
- Отменяет эффект cook off у техники, в которой нечему дефлагрировать (например, БРДМ, БТР-40+, М113)
- Все части техники получают полные повреждения и могут быть уничтожены (колеса, турели), а при больших структурных повреждениях - техника обездвиживается (как будто бы происходит разрушение трансмиссии, осей и прочих агрегатов, которых в арме нет)

Как использовать:
- Установите мод на ваш клиент ИЛИ выделенный сервер
- Настройки мода доступны в ((Настройки -> Настройки Дополнений -> dzn Vehicle On Fire))
- (опционально) вы можете добавить классы техники, которая должна гореть в поле “Машины без эффекта Cook-off”; используйте формат [@Класс, @Поверждения до поломки], например ['CUP_btr_base', 15] или ['Car', 5], где @Класс - название класса техники или родительский класс, @Поверждения до поломки - суммарные повреждения до иммобилизации техники
- (опционально) вы можете добавить классы техники, которая все-таки должна кукофить, но является дочерним классом техники из списка “Машины без эффекта Cook-off” (например, БТР-80А с 30мм пушкой может кукофить, а все прочие БТРы нет)
- Начните игру и… БМП идет, горит, экипаж не выходит, танкист подъезжает закрывает своей броней, говорит съебывайтесь мужики вы ж подбиты, они не выходят, танку снаряд залетел под погон, ушел, БМП сгорела с экипажем...
