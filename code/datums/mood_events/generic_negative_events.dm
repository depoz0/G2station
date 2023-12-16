/datum/mood_event/handcuffed
	description = "Похоже, мои выходки наконец-то настигли меня."
	mood_change = -1

/datum/mood_event/broken_vow //Used for when mimes break their vow of silence
	description = "Я опозорил свое имя и предал своих коллег-мимов, нарушив нашу священную клятву..."
	mood_change = -8

/datum/mood_event/on_fire
	description = "Я В УДАРЕ!!!"
	mood_change = -12

/datum/mood_event/suffocation
	description = "НЕ МОГУ... ДЫШАТЬ..."
	mood_change = -12

/datum/mood_event/burnt_thumb
	description = "Мне не следует играть с зажигалками..."
	mood_change = -1
	timeout = 2 MINUTES

/datum/mood_event/cold
	description = "Здесь очень холодно."
	mood_change = -5

/datum/mood_event/hot
	description = "Здесь становится жарко."
	mood_change = -5

/datum/mood_event/creampie
	description = "I've been creamed. Tastes like pie flavor."
	mood_change = -2
	timeout = 3 MINUTES

/datum/mood_event/slipped
	description = "Я поскользнулся. В следующий раз мне следует быть осторожнее..."
	mood_change = -2
	timeout = 3 MINUTES

/datum/mood_event/eye_stab
	description = "Когда-то я был таким же искателем приключений как вы, пока мне не проткнули глаз отверткой."
	mood_change = -4
	timeout = 3 MINUTES

/datum/mood_event/delam //SM delamination
	description = "Эти чертовы инженеры ничего не могут сделать правильно..."
	mood_change = -2
	timeout = 4 MINUTES

/datum/mood_event/cascade // Big boi delamination
	description = "I never thought I'd see a resonance cascade, let alone experience one..."
	mood_change = -8
	timeout = 5 MINUTES

/datum/mood_event/depression_minimal
	description = "Я чувствую себя немного подавленно."
	mood_change = -10
	timeout = 2 MINUTES

/datum/mood_event/depression_mild
	description = "Мне грустно без особых на то причин."
	mood_change = -12
	timeout = 2 MINUTES

/datum/mood_event/depression_moderate
	description = "Я чувствую себя несчастным."
	mood_change = -14
	timeout = 2 MINUTES

/datum/mood_event/depression_severe
	description = "Я потерял всякую надежду."
	mood_change = -16
	timeout = 2 MINUTES

/datum/mood_event/shameful_suicide //suicide_acts that return SHAME, like sord
	description = "Я даже не могу покончить со всем этим!"
	mood_change = -15
	timeout = 60 SECONDS

/datum/mood_event/dismembered
	description = "AHH! MY LIMB! I WAS USING THAT!"
	mood_change = -10
	timeout = 8 MINUTES

/datum/mood_event/dismembered/add_effects(obj/item/bodypart/limb)
	if(limb)
		description = "AHH! MY [uppertext(limb.plaintext_zone)]! I WAS USING THAT!"

/datum/mood_event/reattachment
	description = "Ouch! My limb feels like I fell asleep on it."
	mood_change = -3
	timeout = 2 MINUTES

/datum/mood_event/reattachment/add_effects(obj/item/bodypart/limb)
	if(limb)
		description = "Ouch! My [limb.plaintext_zone] feels like I fell asleep on it."

/datum/mood_event/tased
	description = "There's no \"z\" in \"taser\". It's in the zap."
	mood_change = -3
	timeout = 2 MINUTES

/datum/mood_event/embedded
	description = "Pull it out!"
	mood_change = -7

/datum/mood_event/table
	description = "Кто-то швырнул меня на стол!"
	mood_change = -2
	timeout = 2 MINUTES

/datum/mood_event/table/add_effects()
	if(isfelinid(owner)) //Holy snowflake batman!
		var/mob/living/carbon/human/H = owner
		SEND_SIGNAL(H, COMSIG_ORGAN_WAG_TAIL, TRUE, 3 SECONDS)
		description = "They want to play on the table!"
		mood_change = 2

/datum/mood_event/table_limbsmash
	description = "That fucking table, man that hurts..."
	mood_change = -3
	timeout = 3 MINUTES

/datum/mood_event/table_limbsmash/add_effects(obj/item/bodypart/banged_limb)
	if(banged_limb)
		description = "My fucking [banged_limb.plaintext_zone], man that hurts..."

/datum/mood_event/brain_damage
	mood_change = -3

/datum/mood_event/brain_damage/add_effects()
	var/damage_message = pick_list_replacements(BRAIN_DAMAGE_FILE, "brain_damage")
	description = "Hurr durr... [damage_message]"

/datum/mood_event/hulk //Entire duration of having the hulk mutation
	description = "HULK SMASH!"
	mood_change = -4

/datum/mood_event/epilepsy //Only when the mutation causes a seizure
	description = "I should have paid attention to the epilepsy warning."
	mood_change = -3
	timeout = 5 MINUTES

/datum/mood_event/photophobia
	description = "Свет слишком яркий..."
	mood_change = -3

/datum/mood_event/nyctophobia
	description = "Как же здесь темно..."
	mood_change = -3

/datum/mood_event/claustrophobia
	description = "Почему я чувствую себя в ловушке?!  Выпустите меня!!!"
	mood_change = -7
	timeout = 1 MINUTES

/datum/mood_event/bright_light
	description = "I hate it in the light...I need to find a darker place..."
	mood_change = -12

/datum/mood_event/family_heirloom_missing
	description = "I'm missing my family heirloom..."
	mood_change = -4

/datum/mood_event/healsbadman
	description = "I feel like I'm held together by flimsy string, and could fall apart at any moment!"
	mood_change = -4
	timeout = 2 MINUTES

/datum/mood_event/healsbadman/long_term
	timeout = 10 MINUTES

/datum/mood_event/jittery
	description = "I'm nervous and on edge and I can't stand still!!"
	mood_change = -2

/datum/mood_event/choke
	description = "Я НЕ МОГУ ДЫШАТЬ!!!"
	mood_change = -10

/datum/mood_event/vomit
	description = "Меня только что вырвало. Мерзость."
	mood_change = -2
	timeout = 2 MINUTES

/datum/mood_event/vomitself
	description = "Меня только что стошнило на себя. Это отвратительно."
	mood_change = -4
	timeout = 3 MINUTES

/datum/mood_event/painful_medicine
	description = "Medicine may be good for me but right now it stings like hell."
	mood_change = -5
	timeout = 60 SECONDS

/datum/mood_event/spooked
	description = "The rattling of those bones... It still haunts me."
	mood_change = -4
	timeout = 4 MINUTES

/datum/mood_event/loud_gong
	description = "That loud gong noise really hurt my ears!"
	mood_change = -3
	timeout = 2 MINUTES

/datum/mood_event/notcreeping
	description = "The voices are not happy, and they painfully contort my thoughts into getting back on task."
	mood_change = -6
	timeout = 3 SECONDS
	hidden = TRUE

/datum/mood_event/notcreepingsevere//not hidden since it's so severe
	description = "THEY NEEEEEEED OBSESSIONNNN!!"
	mood_change = -30
	timeout = 3 SECONDS

/datum/mood_event/notcreepingsevere/add_effects(name)
	var/list/unstable = list(name)
	for(var/i in 1 to rand(3,5))
		unstable += copytext_char(name, -1)
	var/unhinged = uppertext(unstable.Join(""))//example Tinea Luxor > TINEA LUXORRRR (with randomness in how long that slur is)
	description = "THEY NEEEEEEED [unhinged]!!"

/datum/mood_event/tower_of_babel
	description = "Моя способность к общению - это бессвязный лепет..."
	mood_change = -1
	timeout = 15 SECONDS

/datum/mood_event/back_pain
	description = "Bags never sit right on my back, this hurts like hell!"
	mood_change = -15

/datum/mood_event/sad_empath
	description = "Кажется, кто-то расстроен..."
	mood_change = -1
	timeout = 60 SECONDS

/datum/mood_event/sad_empath/add_effects(mob/sadtarget)
	description = "[sadtarget.name] кажется расстроенным..."

/datum/mood_event/sacrifice_bad
	description = "Эти чертовы дикари!"
	mood_change = -5
	timeout = 2 MINUTES

/datum/mood_event/artbad
	description = "У меня из одного места выходят произведения получше, чем это."
	mood_change = -2
	timeout = 2 MINUTES

/datum/mood_event/graverobbing
	description = "Я только что осквернил чью-то могилу... Не могу поверить, что я это сделал..."
	mood_change = -8
	timeout = 3 MINUTES

/datum/mood_event/deaths_door
	description = "Вот и все... Я точно умру."
	mood_change = -20

/datum/mood_event/gunpoint
	description = "Этот тип сумасшедший! Мне лучше быть осторожнее..."
	mood_change = -10

/datum/mood_event/tripped
	description = "I can't believe I fell for the oldest trick in the book!"
	mood_change = -5
	timeout = 2 MINUTES

/datum/mood_event/untied
	description = "Ненавижу когда у меня развязываются шнурки!"
	mood_change = -3
	timeout = 60 SECONDS

/datum/mood_event/gates_of_mansus
	description = "I HAD A GLIMPSE OF THE HORROR BEYOND THIS WORLD. REALITY UNCOILED BEFORE MY EYES!"
	mood_change = -25
	timeout = 4 MINUTES

/datum/mood_event/high_five_alone
	description = "Вы пытались получить 'дай пять' когда рядом никого не было, как же это неловко!"
	mood_change = -2
	timeout = 60 SECONDS

/datum/mood_event/high_five_full_hand
	description = "О боже, я даже не знаю как правильно делать 'дай пять'..."
	mood_change = -1
	timeout = 45 SECONDS

/datum/mood_event/left_hanging
	description = "Все же любят 'дай пять'! Может люди просто... ненавидят меня?"
	mood_change = -2
	timeout = 90 SECONDS

/datum/mood_event/too_slow
	description = "НЕТ! КАК Я МОГУ БЫТЬ... ТАКИМ МЕДЛЕННЫМ????"
	mood_change = -2 // multiplied by how many people saw it happen, up to 8, so potentially massive. the ULTIMATE prank carries a lot of weight
	timeout = 2 MINUTES

/datum/mood_event/too_slow/add_effects(param)
	var/people_laughing_at_you = 1 // start with 1 in case they're on the same tile or something
	for(var/mob/living/carbon/iter_carbon in oview(owner, 7))
		if(iter_carbon.stat == CONSCIOUS)
			people_laughing_at_you++
			if(people_laughing_at_you > 7)
				break

	mood_change *= people_laughing_at_you
	return ..()

//These are unused so far but I want to remember them to use them later
/datum/mood_event/surgery
	description = "ОНИ ВСКРЫВАЮТ МЕНЯ!!!"
	mood_change = -8

/datum/mood_event/bald
	description = "Мне нужно чем-то прикрыть голову..."
	mood_change = -3

/datum/mood_event/bald_reminder
	description = "Мне напомнили что я не могу отрастить волосы! Это ужасно!"
	mood_change = -5
	timeout = 4 MINUTES

/datum/mood_event/bad_touch
	description = "Я не люблю когда ко мне прикасаются."
	mood_change = -3
	timeout = 4 MINUTES

/datum/mood_event/very_bad_touch
	description = "Я очень не люблю когда ко мне прикасаются."
	mood_change = -5
	timeout = 4 MINUTES

/datum/mood_event/noogie
	description = "Ow! This is like space high school all over again..."
	mood_change = -2
	timeout = 60 SECONDS

/datum/mood_event/noogie_harsh
	description = "OW!! That was even worse than a regular noogie!"
	mood_change = -4
	timeout = 60 SECONDS

/datum/mood_event/aquarium_negative
	description = "Все рыбы мертвы..."
	mood_change = -3
	timeout = 90 SECONDS

/datum/mood_event/tail_lost
	description = "Мой хвост!!! Почему?!"
	mood_change = -8
	timeout = 10 MINUTES

/datum/mood_event/tail_balance_lost
	description = "Без хвоста я чувствую себя не в своей тарелке."
	mood_change = -2

/datum/mood_event/tail_regained_right
	description = "Мой хвост вернулся и это было крайне болезненно..."
	mood_change = -2
	timeout = 5 MINUTES

/datum/mood_event/tail_regained_wrong
	description = "Это что, какая-то больная шутка?! Это не тот хвост."
	mood_change = -12 // -8 for tail still missing + -4 bonus for being frakenstein's monster
	timeout = 5 MINUTES

/datum/mood_event/burnt_wings
	description = "MY PRECIOUS WINGS!!"
	mood_change = -10
	timeout = 10 MINUTES

/datum/mood_event/holy_smite //punished
	description = "Меня наказало божество!"
	mood_change = -5
	timeout = 5 MINUTES

/datum/mood_event/banished //when the chaplain is sus! (and gets forcably de-holy'd)
	description = "Я был отлучен от церкви!"
	mood_change = -10
	timeout = 10 MINUTES

/datum/mood_event/heresy
	description = "I can hardly breathe with all this HERESY going on!"
	mood_change = -5
	timeout = 5 MINUTES

/datum/mood_event/soda_spill
	description = "Cool! That's fine, I wanted to wear that soda, not drink it..."
	mood_change = -2
	timeout = 1 MINUTES

/datum/mood_event/watersprayed
	description = "Ненавижу, когда на меня брызгают водой!"
	mood_change = -1
	timeout = 30 SECONDS

/datum/mood_event/gamer_withdrawal
	description = "Хотел бы я сейчас поиграть..."
	mood_change = -5

/datum/mood_event/gamer_lost
	description = "Если я не разбираюсь в видеоиграх, могу ли я по-настоящему называть себя геймером?"
	mood_change = -10
	timeout = 10 MINUTES

/datum/mood_event/lost_52_card_pickup
	description = "Это очень неловко! Мне стыдно поднимать все эти карты с пола..."
	mood_change = -3
	timeout = 3 MINUTES

/datum/mood_event/russian_roulette_lose
	description = "Я поставил на кон свою жизнь и проиграл! Думаю, это конец..."
	mood_change = -20
	timeout = 10 MINUTES

/datum/mood_event/bad_touch_bear_hug
	description = "I just got squeezed way too hard."
	mood_change = -1
	timeout = 2 MINUTES

/datum/mood_event/rippedtail
	description = "Я оторвал им хвост, что я наделал!"
	mood_change = -5
	timeout = 30 SECONDS

/datum/mood_event/sabrage_fail
	description = "Blast it! That stunt didn't go as planned!"
	mood_change = -2
	timeout = 4 MINUTES

/datum/mood_event/body_purist
	description = "I feel cybernetics attached to me, and I HATE IT!"

/datum/mood_event/body_purist/add_effects(power)
	mood_change = power

/datum/mood_event/unsatisfied_nomad
	description = "Я пробыл здесь слишком долго! Я хочу выйти и исследовать космос!"
	mood_change = -3

///Wizard cheesy grand finale - what everyone but the wizard gets
/datum/mood_event/madness_despair
	description = "UNWORTHY, UNWORTHY, UNWORTHY!!!"
	mood_change = -200
	special_screen_obj = "mood_despair"

/datum/mood_event/all_nighter
	description = "I didn't sleep at all last night. I'm exhausted."
	mood_change = -5
